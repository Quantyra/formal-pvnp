"""Replay frozen S3044 rows from a pinned archive; never select or analyze outcomes.

Usage: python 2026-09-10-qaoa-replay-selection.py --archive ARCHIVE
       --manifest MANIFEST --receipt RECEIPT --output NEW_JSONL
Output must not already exist. Source archive members are read, never extracted.
"""
import argparse
import hashlib
import json
import pathlib
import tarfile


# SHA256 of sorted `member<TAB>raw-member-sha256<LF>` entries; populated from
# the archive whose full SHA256 is already pinned in the frozen manifest.
EXPECTED_MEMBER_DIGEST = 'a73966d95f3822fc377f4ed1693bec09231e4ee362c1305c2f613d47ced381c5'


def sha_file(path):
    h = hashlib.sha256()
    with path.open('rb') as f:
        for chunk in iter(lambda: f.read(8 * 1024 * 1024), b''):
            h.update(chunk)
    return h.hexdigest()


def require(condition, message):
    if not condition:
        raise ValueError(message)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    for name in ('archive', 'manifest', 'receipt', 'output'):
        parser.add_argument('--' + name, required=True, type=pathlib.Path)
    args = parser.parse_args()
    require(not args.output.exists(), 'Refusing to overwrite existing output')
    receipt = json.loads(args.receipt.read_text(encoding='utf8'))
    require(sha_file(args.manifest) == receipt['manifest_sha256'], 'Manifest checksum mismatch')
    manifest = json.loads(args.manifest.read_text(encoding='utf8'))
    require(args.archive.stat().st_size == manifest['archive']['bytes'], 'Archive size mismatch')
    require(sha_file(args.archive) == manifest['archive']['sha256'], 'Archive checksum mismatch')
    records = manifest['selected_records']
    wanted = {r['member']: r for r in records}
    require(len(wanted) == len(records), 'Duplicate frozen member')
    rows, hashes = [], {}
    with tarfile.open(args.archive, mode='r|gz') as archive:
        for member in archive:
            if member.name not in wanted:
                continue
            require(member.isfile(), 'Selected member is not a regular file')
            require(member.name not in hashes, 'Duplicate selected archive member')
            require(member.size <= 1024 * 1024, 'Unexpected oversized benchmark')
            with archive.extractfile(member) as stream:
                raw = stream.read()
            hashes[member.name] = hashlib.sha256(raw).hexdigest()
            r = json.loads(raw)
            meta = wanted[member.name]
            for source, frozen in (('n', 'n'), ('k', 'k'), ('r', 'r'),
                                   ('p', 'p_explicit'), ('instance_id', 'instance_id'),
                                   ('benchmark_id', 'benchmark_id')):
                require(r[source] == meta[frozen], 'Frozen metadata mismatch: ' + source)
            # Keep source numbers, zeros and nulls; no rounding, filtering or imputation.
            rows.append({'config_id': manifest['config_id'], 'formula_id': r['instance_id'],
                         'depth': r['p'], 'n': r['n'], 'k': r['k'], 'r': r['r'],
                         'a': r.get('eval_qaoa_success_probability'),
                         'K': r.get('num_valid_assignments'),
                         'source_uniform': r.get('random_assignment_success_probability'),
                         'benchmark_id': r['benchmark_id'], 'source_member': member.name,
                         'instance_description_file': r.get('instance_description_file'),
                         'instance_enumeration_file': r.get('instance_enumeration_file')})
    require(set(hashes) == set(wanted), 'Selected source members missing')
    member_digest = hashlib.sha256(''.join(name + '\t' + hashes[name] + '\n'
                                          for name in sorted(hashes)).encode()).hexdigest()
    require(member_digest == EXPECTED_MEMBER_DIGEST, 'Raw member checksum aggregate mismatch')
    rows.sort(key=lambda r: (r['formula_id'], r['depth']))
    require(len(rows) == receipt['rows'], 'Row count mismatch')
    # Original freeze used Path.write_text on Windows; its artifact has CRLF.
    payload = ''.join(json.dumps(r, separators=(',', ':')) + '\r\n' for r in rows).encode('utf8')
    digest = hashlib.sha256(payload).hexdigest()
    require(digest == receipt['selected_data_sha256'], 'Replayed JSONL checksum mismatch')
    with args.output.open('xb') as f:
        f.write(payload)
    print(json.dumps({'rows': len(rows), 'raw_member_digest': member_digest,
                      'selected_data_sha256': digest, 'verified': True}))


if __name__ == '__main__':
    main()
