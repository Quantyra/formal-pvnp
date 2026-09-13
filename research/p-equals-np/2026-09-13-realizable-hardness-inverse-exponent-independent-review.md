# Independent inverse-step exponent challenge

2026-09-13. S3132/S3134. Bounded mathematical source review, not a proof of all imported analytic foundations. No compiler, Git, paper, or Lean changes. Paper freeze 6516d23 remains read-only. The earlier ambient reviews and manuscript integration review did not certify this remaining inverse step.

## Verdict

The printed 0.9-cutoff Markov exponent is incorrect, and its corrected tail cannot simply be discarded against the density threshold S in the random-function inverse argument. A reoptimized cutoff and upward dyadic norm rounding supply a defensible repair without weakening the target inverse agreement epsilon'. I independently checked the arithmetic and selection below, coordinating with occurrence, who owns the full reconstruction. This does not infer that the source theorem is false.

## Primary evidence

I read preserved MZ arXiv:2510.23991v1 text: Definition 2.1; Theorem 4.3 and its random-function proof (printed pages 12-14); Theorem 4.6 (page 16); Lemmas 4.7/4.8 and the passage back to Lemma 4.1 (pages 16-18). File: C:/Users/Dan/AppData/Local/Temp/s3123-mz2510.23991.pdf.txt. Raw SHA256: e8cb21fb8279f7881a5cf5c53b87b09b215f0bb3c8466b8fbdfcd4517ee5fbce.

Use m for the source k, h for its ell, rho for delta, and r=10m/rho. Assume positive fixed small rho<=1/2, integral dimensions and r, and sufficiently large h. The manuscript application has m>=2 (eventually m>=256); the 2/3-cutoff computation below also works for m=1. The previously reviewed positive ambient spectral residual must first be absorbed under its explicit n lower bound to give E|H_high|^2<=2^(-2r*rho*h+r).

## Markov and its actual comparison scale

At the printed threshold 2^(-0.9r*rho*h), Markov gives bad probability at most 2^(-0.2r*rho*h+r)=2^(-2mh+r), not 2^(-r*rho*h). Its ratio to S=2^(-2(1-1000rho)hm) is 2^(r-2000rho*mh), eventually small. But the selected inverse signal has the additional factor beta*2^(-2m*rho*h); beta may itself be exponentially small. Comparison with S alone is insufficient.

A cutoff 2^(-(2/3)r*rho*h) instead gives bad probability <=2^r*2^(-(2/3)r*rho*h). The good-event high mth moment, including the elementary sum inequality and the matrix-comparison factor, is bounded by 2^m*2^(-(2/3)r*rho*hm). For m>=1 this is at most 2^m*2^(-(20/3)mh). Therefore an admissible combined error is D*2^(-(20/3)mh), D=2^m+2^(r+1), including the bad-event matrix factor. These are constants independent of ambient n.

## Joint gluing and affine selection

The inverse proof needs joint, not merely pairwise, compatibility of leaf assignments. Put t0=2(1-rho)h and s=2rho*h. Given a center R, projected leaf increments are independent uniform s-spaces in the (n-t0)-dimensional quotient. For sequential index i=0,...,m-1, collision with the preceding span has probability at most (2^(is)-1)(2^s-1)/(2^(n-t0)-1). Summing telescopes to a numerator at most 2^(ms), so joint-span failure q<=2^(t0+ms+1-n). For s=0 the failure is zero. Requiring q<=S/2 ensures accepted full-span mass >=epsilon/2 whenever original acceptance epsilon>=S.

For a uniform global function f, let X_f be the probability of the accepted full-span test together with agreement of f on every queried label; let beta_f be its center-agreement density. Joint gluing gives E X_f>=epsilon*2^(-(t0+ms))/2 and E beta_f=2^(-t0). Affine averaging therefore selects f with

    X_f >= (epsilon/4)*2^(-ms)*beta_f
           + (epsilon/4)*2^(-(t0+ms)).

Since X_f<=beta_f, beta_f>=(epsilon/4)*2^(-(t0+ms)) >=(1/4)*2^(-2(m+1)h). The first summand is thus at least epsilon^2*2^(-(t0+2ms))/16. The high-degree error is at most half this summand if

    [(8/3)m-2+(3996m+2)rho]h >= log2(32D).

This follows by substituting epsilon>=S; its coefficient is strictly positive for all m>=1. Thus the error is charged against the actual selected lower bound, not just S. The joint-span requirement is another explicit lower bound on n, satisfied by the manuscript's prescribed ambient size for fixed large h.

## Dyadic norm and final agreement

Theorem 4.6 requires a dyadic moment >=4. Its literal use at m*T is unjustified unless that product is dyadic. Choose T a power of two with T>=max(4,(m+1)/(rho-rho^2)), and p the least power of two >=m*T. On the probability space, ||F^{=i}||_(mT)<=||F^{=i}||_p. Theorem 4.6 and raising to the mth power give pseudorandomness exponent m-2m/p >= m-2/T. For 0<epsilon'<=1, this improves rather than weakens the required bound. Constants such as 2^(500r^2*p*m) and triangle factors depend only on fixed r,m,T, not n or h. Replacing the matrix pseudorandomness parameter by 2epsilon' only changes those constants for large h.

Holders inequality still contributes beta^((T-1)/T). After the high-error absorption, divide the selected signal to obtain an inequality of the form

    1 <= K * 2^(2m*rho*h) * beta^(-1/T)
              * epsilon'^(m-2/T) / epsilon,

where K is a fixed positive constant. With epsilon'=2^(-2(1-1000rho^2)h) and beta>=(1/4)2^(-2(m+1)h), the exponent multiplying h is at most

    2m*rho + (2m+6)/T - 2000m*(rho-rho^2)
    <= 2m*rho + 4*(rho-rho^2) - 2000m*(rho-rho^2).

For rho<=1/2, this is at most (4m+4-2000m)*(rho-rho^2)<0. Enlarging h absorbs K and gives the contradiction. Rounding upward to dyadic T and p therefore preserves epsilon', without enlarging r.

Definition 2.1 defines pseudorandomness by agreement <=epsilon' on all permitted zooms. Its failure provides a zoom with agreement >epsilon' for the selected global function, so this reconstructed step can supply the actual epsilon' threshold used by the subsequent amplification; it need not silently lose an unspecified constant from the theorem statement's printed Omega(epsilon'). This conclusion depends on the verified pseudorandomness-to-matrix bridge and Theorem 4.6 as imported analytic results, not on a new local proof of those foundations.

## Remaining boundary

Occurrence should integrate these repairs in its complete inverse reconstruction and check every prefactor consistently. The source's misprinted zoom dimensions in Theorem 4.3 and random-function display are not adopted: the argument uses Definition 2.1's dim(Q)+codim(W)=r and actual center probability 2^(-t0). No paper change is authorized by this note. No full hardness, novelty, publication, or kernel acceptance follows.

## Reconciliation with occurrence's full candidate

After writing the independent derivation above, I read the full candidate `2026-09-13-realizable-hardness-inverse-ambient-full-dependency-audit.md`, raw SHA256 `50d6b600a1755b25167e5d3f8aca253a6660290f7f2fe73920739a3d204fbb1d`. Its choice T>=max(4,4(m+3)/(m*rho)) is another valid dyadic cutoff: 2(m+3)/T<=m*rho/2 gives lambda>=m*rho*(2000(1-rho)-2.5)>0. Its explicit K=2^(2m)(r+1)^m*2^(500mr^2P) safely includes the low/high splitting, matrix factor and lifted parameter 2e. Its D, absorption (C), and final h cutoff (D) match the independently checked signal calculation. Its X_f counts all matching stars, whereas my lower bound can restrict to full-span stars; both have the same sufficient lower bound and are bounded above by the unrestricted matching-star estimate. No additional constant discrepancy was found in that candidate. This is bounded agreement with the repaired derivation conditional on its named analytic imports, not acceptance of the entire paper.
