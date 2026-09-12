# Reproducing a PPSZ bound with corrected source coefficients

Computational reproduction note. Draft, 12 September 2026.

This package certifies a numerical consequence of specified published PPSZ estimates using exact rational arithmetic. It recombines the corrected 2022 coefficients and obtains

\[
\gamma_*\in[0.0000684193054602820920,\;0.0000684193054602820921].
\]

The conservative bonus `gamma = 0.0000684193` gives a conditional Unique-3-SAT running-time bound `O*(1.306969924^n)`, with the finite-strength qualifications below. The contribution is a reproducible calculation and source-version reconciliation. It is not a new algorithm, a novelty or best-known claim, or a P-versus-NP result.

## Reproduce

Run `python certificate.py` with Python 3 and its standard library. The script asserts the required inequalities and prints JSON. [certificate.json](certificate.json) is the recorded output. No input data, package installation, random seed, optimization solver or SAT experiment is needed.

The program uses exact fractions and rigorous series remainders. Its assertions certify the arithmetic implication from the imported estimates below; they do not independently prove those estimates.

## Source versions

1. [Scheder, PPSZ is better than you think, arXiv:2207.11071v1 (2022)](https://arxiv.org/pdf/2207.11071v1): corrected structural inequality in Section 7.1, regular coefficients in Section 7.8, irregular coefficients in Section 8.4. Printed page 88 records corrections to the earlier edge-cut construction and regular TwoCC bias. This is the version used here.
2. [Scheder, ECCC TR21-069, revision 1 (2021)](https://eccc.weizmann.ac.il/report/2021/069/revision/1/download/): earlier version. A 19-edge cycle disproves the stated universal deletion budget of at most |E|/18 for producing components of at most 17 edges: one deletion leaves an 18-edge path.
3. [Jiang and Cai, A Better Analysis For PPSZ For 3-SAT, arXiv:2607.10697v1 (2026)](https://arxiv.org/html/2607.10697v1): supplies the common-coordinate recombination method used here. Its equations (5) and (10) use the earlier coefficient set and 18/17 factor. This package substitutes the corrected source estimates. The version mismatch alone does not establish that its theorem is false.

The graph correction was already documented by Scheder. The recombination method is credited to Jiang and Cai. The 2024 journal treatment does not contain the full detailed 3-SAT coefficient calculation, so the version-specific citations are essential.

## Imported estimates

Write f(x)=(1-x)ln(1-x)+x. Normalize the relevant structural counts as i0,i1,tau, all nonnegative: i0 and i1 count indegree-zero/one variables outside TwoCC, and tau counts TwoCC variables. Both auxiliary-measure estimates bound the same original, uniform-order, unbiased-guessing PPSZ algorithm.

The corrected regular estimate has low-edge coefficient cL, high-edge coefficient .9T, TwoCC coefficient cT and global subtraction 1.0302rTn, where

\[
c_L=.00168728r-.00638r^2,\qquad
c_T=.009307-.0577r-.1503f(r).
\]

The imported structural inequalities are

\[
(12/11)|H_{low}|+2|H_{high}|+3|TwoCC|\ge|H|,
\quad |H|\ge n-|ID_1|-2|ID_0|-2|TwoCC|.
\]

Set A=(11/12)cL, T=2A/.9, P=1.0302rT and S=cT-5A. The regular gain per variable is at least

\[
L_R=A-P-2Ai_0-Ai_1+S\tau.
\]

The imported irregular estimate gives

\[
L_I=b_0i_0+b_1i_1+b_T\tau,
\]
\[
b_1=.030966i-.0028i^2-.4027f(i),\quad b_0=.06259i-.344f(i),
\]
\[
b_T=.009307-.2405i-.03125i^2-.06183f(5i).
\]

Use r=1/10 and i=73/1000. The certificate checks r,i<=.1, i<=4/5, i<=256/600, 5i<1 and T<=1/4678. Regular and irregular TwoCC bias functions are distinct; no function is transferred between the two source arguments.

## Certified recombination

Let lambda=b1/A. Then

\[
\max(L_R,L_I)\ge
\frac{\lambda(A-P)+(b_0-2b_1)i_0+(b_T+\lambda S)\tau}{1+\lambda}.
\]

The i1 coefficient cancels identically. Exact arithmetic gives A>P>0 and strictly positive remaining structural coefficients:

| Quantity | Outward enclosure |
|---|---|
| b0-2b1 | [0.0013383343013574221959, 0.0013383343013574221960] |
| bT+lambda*S | [0.0139781228441146605913, 0.0139781228441146605914] |
| b1(A-P)/(A+b1) | [0.0000684193054602820920, 0.0000684193054602820921] |

Consequently max(LR,LI)>=gamma_* for every nonnegative structural triple. No parameter optimality or realizability of a worst-case structural triple is asserted.

For logarithms, the certificate truncates -ln(1-x)=sum x^k/k after 100 terms and bounds the tail by x^101/[101(1-x)]. All arithmetic and outward rounding use exact fractions. Separate atanh and exponential series certify `2^(2 ln 2 - 1 - gamma) < 1.306969924`.

## Conditional algorithmic meaning and limits

Assume the cited corrected estimates and their finite-strength convergence. Choose a finite implication strength w after fixing gamma=.0000684193 strictly below gamma_*, then choose n0 so the remaining asymptotic error fits the positive slack. For every uniquely satisfiable 3-CNF on n>=n0 variables,

\[
\Pr[\mathrm{PPSZ}_w\text{ finds the witness}]
\ge 2^{-(2\ln2-1-\gamma)n}.
\]

One run costs n^{O(w)} times polynomial input factors; repeating independently gives constant success probability in O*(1.306969924^n). Outputs are checked against the input formula. No useful explicit numerical w or n0 is provided. The auxiliary measures are proof devices, so discovering their solution-dependent graphs is not an algorithmic preprocessing step.

The known unique-to-general lifting is separate; this package gives no new certified numerical bound for general 3-SAT. The bound here is randomized and exponential. It establishes neither P=NP nor P!=NP. The computational checks and AI-assisted mathematical reviews are not a proof-assistant verification or external peer review.
