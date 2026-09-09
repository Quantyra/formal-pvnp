# Effective finite-horizon carrier initialization attempt

2026-09-08; S3040 / E004 / S008. Harness-only satellite derivation. No Lean result, completed numerical PDE certificate, or P=NP claim. This is a dependency of the original polynomial-bit-time SAT goal, not a replacement goal.

## Result and the changed initialization strategy

Computing the stable sheet is **unnecessary for a carrier required to survive only a specified finite tick budget**. One can instead place a positive-radius parcel sufficiently near the exact axis equilibrium. Its radius is nonzero, so its angle is defined. A differential inequality controls departure from the axis for the requested horizon. The result is a family of initial conditions indexed by the tick budget, not one effectively initialized parcel surviving every horizon.

The algorithm below is effective **given a finite rational certificate for normalized local bounds**. Such bounds exist by the previous source-dependent carrier argument. This note does not yet extract their numerical values from the paper. It isolates that finite certificate and shows why no stable-manifold oracle or increasing-order graph computation is needed. A separate analysis makes the cutoff choice constructive conditional on coefficient majorants, and bounds the number of active coefficients.

## Source inspection and exact outstanding input

Primary source: [OpenAI, Finite time blowup for Navier-Stokes](https://cdn.openai.com/pdf/32d9f210-8b73-45e0-91bc-82a30aef8a9a/navier-stokes.pdf), inspected 2026-09-08, printed pp.55–61. Lemma 5.4 constructs increasing cutoff scales by satisfying finitely many coefficient-norm inequalities at each order, equation (5.37). Equation (5.40) permits additional normalized inequalities. Coefficient bounds need not be uniform in their order. No complexity bound for computing those norms is supplied in these passages. This is an unspecified effective input, not evidence that the constants are noncomputable. The completed-carrier and continuation-proof-review notes supply the previously reviewed near-axis identities and uniform derivative implications used here.

In particular, the fixed field itself requires a choice of the cutoff sequence and of the profile data. An existence theorem permitting arbitrary admissible choices does not specify one numerical field. A proposed algorithm must select an effective admissible instance or receive its effective representation.

## Explicit finite certificate

Fix rational admissible parameters h,j0 and hence D=1/2-h. The unique root eta0 of

    D eta + (1-eta^2)(4 eta+j0)=0

in (-j0/4,0) is algebraic and can be enclosed by rational bisection. Work in the inner rectangle

    0<q<=q0, 0<=X<=b, |eta-eta0|<=delta,

where q0,b,delta are positive rational constants, the annular corrections vanish, and the final localization equals the inner field. Put G=D eta+(1-eta^2)Uhat and H=L Fhat. Request rational bounds

    0<kminus <= 1-2 eta Uhat <= kplus,
    -wplus <= What <= -wminus <0,
    H >= fminus >0,
    |partial_eta G| <= B, |partial_X G| <= C,

with B,C positive and the rectangle contained in |eta|<1. Upper bounds on absolute What and the positivity of q guarantee no finite-time loss of positive radius. Uniform bounds from the completed-carrier note and strict axis inequalities imply some such certificate exists after shrinking the rectangle. Their numeric extraction remains open here.

The exact completed equations and exact trace give

    q'=-q(1-2 eta Uhat), X'=X What,
    eta'=G, theta'=H q^(-h), G(q,0,eta0)=0.

No stable graph enters these equations. In particular, the cutoff-derivative contribution already present in What must be retained in any implementation of this certificate.

## Finite-horizon theorem

Let e=eta-eta0 and assume initialization errors |e(0)|<=epsilon0 and 0<X(0)<=x0. Up to first exit from the rectangle,

    X(s)<=x0 exp(-wminus s),
    |e(s)| <= epsilon0 exp(Bs)
              + C x0 [exp(Bs)-exp(-wminus s)]/(B+wminus).

The second inequality follows from |G(q,X,eta)|<=B|e|+CX, variation of constants, and the first inequality. Consequently the sufficient strict conditions

    epsilon0 <= delta exp(-BS)/4,
    x0 <= min(b/2, delta(B+wminus)exp(-BS)/(4C))

give |e(s)|<=delta/2 for 0<=s<=S. A first-exit argument closes the assumption: q decreases and stays positive, X decreases and stays positive, and eta cannot reach the boundary. Bounded negative logarithmic derivatives give q>=q0 exp(-kplus S)>0 and X>=X(0)exp(-wplus S)>0 throughout. Thus the completed physical field has a rotating positive-radius parcel through this finite horizon.

Starting at q(0)=q0, accumulated angle obeys

    theta(S)-theta(0)
      >= fminus q0^(-h) [exp(h kminus S)-1]/(h kminus).

For M full turns it suffices that this exceeds 2 pi M. A strictly pre-blowup deadline follows because q(S)>0 and |eta(S)|<1; tau(S)=q(S)(1-eta(S)^2)>0. The result does not depend on reading a value at the singularity.

The normalized radial preparation is more severe than initialization at a fixed X on the stable sheet, but its bit description stays short. This theorem neither retains a finite-volume bit nor provides readout.

## Actual-source axis certificate and attempted radial majorant extraction

An additional inspection covered Appendix B.1–B.3, including its analytic coefficient norm and contraction proof, and the parameter schedule (A.6). **The following constants are derived from the actual prescribed axis formulas, not the synthetic tests.** Uniformly for every source-admissible 0<h<1/100, 0<j0<=1/20, and |eta|<=1/40:

    99/100 < 1-2 eta(4 eta+j0) < 101/100,
    -301/100 < -3+8h eta^2-(1-2h)j0 eta < -299/100,
    4 < 4+(1/2-h)-12 eta^2-2j0 eta < 5.

Proof: |4eta+j0|<=3/20, so the first deviation from 1 is at most 3/400. In the second, the deviation from -3 is at most 1/20000+1/800=13/10000. In the third it is enough to subtract 12/1600+1/400 from 449/100, or add 1/400 to 9/2. All these bounds use rational arithmetic and hold uniformly in q because the completed axis traces are exact.

The axis root is isolated by (-j0/4,0), since the polynomial is negative at the former point and positive at the latter. In particular eta0 lies in (-1/80,0), and delta=1/100 fits inside the axis interval above. These facts certify the stable radial sign, shrinking-q sign and unstable axial derivative on the actual axis. They do not certify any positive-width rectangle. With an independently proved small off-axis perturbation, one could take kminus=98/100, kplus=102/100, wminus=298/100, wplus=302/100 and B=6. The width realizing those margins is not yet numeric.

A concrete radial obstruction to simply substituting the synthetic C=10 is already visible in the leading profile equations: at X=0,

    partial_X U0 = -Zstar/(2L),
    partial_X G0 = -(1-eta^2) Zstar/(2L).

This follows by evaluating the axial equation in (B.15) at the axis; Zstar is the prescribed expression in (B.1). Its value depends on the outer pressure datum Pi0 and its eta derivative. The angular lower bound likewise depends on the prescribed positive phi_star divided by the subsequently chosen amplitude normalization. Neither can be numerically fixed from h<1/100 and j0<=1/20 alone.

There is a usable route from the analytic norm to actual derivative majorants. If the axial correction u in U0=Ustar+Lambda^(-1)u(Y,eta), Y=Lambda X, has a certified B_rho norm at most K, its zero-eta-derivative coefficients satisfy |u_n|<=K 20^(-n)/(n+1)^2. Thus, for 0<=Y<=1,

    |partial_X U0|=|partial_Y u|
       <= K/[20(1-Y/20)^2] <= 20K/361 < K/18.

This is an explicit rational leading-profile majorant once K is known, not merely an O(1) notation. Other finite derivatives follow by differentiating the absolutely convergent geometric majorants. A certified ball radius for the contraction in Proposition B.2 would supply K. The unresolved named inputs to that contraction bound are a numeric complex neighborhood Omega and rho, norms of its coefficient functions including Zstar/L and chi, the radius and Lipschitz bound of its chosen ball, and admissible Lambda and amplitude thresholds. Completed-field derivatives additionally require the finite positive-order coefficient majorants and cutoff-tail constants of Lemma 5.4. The norm-to-derivative conversion itself is not the missing step.

Finally, a rational h=1/200 used in a synthetic test is **not a certified globally admissible source parameter**. The outer schedule (A.6) chooses h only after large/small parameters Md,Td,Pstar,lambda have been fixed, with further smallness relative to lambda and exp(-Td). Appendix B chooses j0 after that schedule. Theorem 4.6 is existential. Strict-smallness choices plausibly allow rational selections after their thresholds are derived, but this note has not derived those thresholds or selected a complete admissible rational instance. The fixed-rational-parameter hypothesis of the effective algorithm must therefore stay conditional.

## An integer algorithm avoiding transcendental tests

Take q0<=1 and an integer c>=0 satisfying the fixed rational inequality

    2^c >= 1 + 8 h kminus/fminus.

On input M>=1, set p=ceil(log2(M+1)) and

    S=ceil((p+c)/(h kminus)), R=ceil(B S), E=2^(-2R).

Since e>2, exp(h kminus S)>=2^(p+c), and since 2pi<8, the angular lower bound is greater than 2pi M. Since e<4, E<=exp(-BS). Choose a positive dyadic x0 below both b/2 and delta(B+wminus)E/(4C), and compute eta0 to absolute error at most delta E/4. Set X(0)=x0 and eta(0) to that approximation. The radius is positive; a physical coordinate enclosure follows from

    r0=sqrt(2q0 x0), z0=q0^D eta(0), t0=1-q0(1-eta(0)^2).

Use directed rounding and enough guard bits when realizing coordinates so that the actual normalized values satisfy the stated certificate bounds; do not confuse rounding of eta0 with a physical positioning guarantee. One can allocate half each allowed tolerance to root approximation and coordinate conversion. Input-dependent t0 is permitted for this family. A common fixed physical start time would require solving tau0=q(1-eta^2), giving a slightly different initializer and rectangle.

For fixed certified parameters, S,R and the requested binary accuracy are O(log M). The dyadic arithmetic and bisection of this fixed-degree polynomial have polynomial bit cost in log M. The axis root has a uniformly positive derivative on the small isolating interval, so interval widths certify root accuracy without a condition-number oracle. This is a computational initializer conditional on the certificate, not a simulator of M logic operations. No statement that physical preparation costs polynomial work is made.

## Constructive cutoff recursion given norm majorants

Here is an explicit replacement for the sufficiently-small cutoff choice. Suppose each finite requirement at order j has supplied rational C>=1, P>=0, alpha>0 and requires

    C(1+|log q|)^P q^alpha <= 2^(-j), 0<q<=a_j^(-1).

Choose a_j=2^N. Put x=-log q, so x>=N log 2. The function exp(-alpha x)(1+x)^P is decreasing once 1+x>=P/alpha. Since 1/2<log 2<1, it is sufficient to choose N with

    N/2+1 >= P/alpha,
    ceil(log2 C)+ceil(P)ceil(log2(1+N))-floor(alpha N) <= -j.

The second bound dominates C(1+N log2)^P 2^(-alpha N). It can be tested by rational and integer arithmetic. Search increasing integers N, also imposing N>=N_previous+1 and 2^(-N)<q_domain. Linear growth of alpha N eventually dominates log(1+N), so the search terminates. A dyadic doubling search followed by binary refinement also works after the monotonic threshold. Add the finite normalized requirements from (5.40) to the same test list.

This construction preserves the source's scale-doubling and summability requirements. It does not compute C,P,alpha from unspecified smooth coefficients. Their derivation is the exact next source-side obligation. In particular, merely searching for an inequality involving the unknown supremum of a smooth function is not an effective procedure; use a certified upper-bound representation or a computable derivative modulus.

For q>=qmin, doubling yields a_j>=2^(j-1)a_1; hence only

    j <= 1+floor(log2(1/(a_1 qmin)))

can possibly contribute. Along the finite-horizon parcel, qmin=q0 exp(-kplus S), so this count is O(log M), regardless of how fast the cutoff scales actually grow. This improves the earlier unspecified active-order count. It supplies no polynomial bound on generating or evaluating the first O(log M) coefficient profiles, their majorants, or their scales. Reading huge scale integers need not be necessary merely to reject a term once a_j qmin>=1, but producing an effective certificate that it is inactive still needs a specified representation.

## A finite-interval certificate search, if the source instance is effective

There is also a terminating interval algorithm without an a priori uniform-q certificate. Its explicit input interface is: interval evaluators for each required coefficient and cutoff, effective cutoff scales, and convergent interval bounds for the normalized field and its first derivatives on every compact rational box with q>0. This is stronger than merely knowing the source functions are smooth.

Enumerate rational candidate certificates and integer horizons S. For a candidate use the rational lower cutoff

    qmin=(q0/2) 2^(-2 ceil(kplus S)),

which is strictly below q0 exp(-kplus S). Test all the displayed certificate inequalities on [qmin,q0] times the X,eta rectangle by recursive interval subdivision, using strict inequalities and outward rounding. Root isolating intervals handle eta0 and the rectangle endpoints. Reject candidates with an interval counterexample; dovetail subdivision across candidates so a marginal candidate cannot stall the whole search. Check the angular and initializer inequalities by the conservative integer rules above. Accept only after every box has certified bounds. First-exit control now excludes the qmin face as well, because q(s)>=q0 exp(-kplus S)>qmin. The output consists of the initial enclosure, horizon, and covering certificate.

Termination follows from the existing uniform near-axis bounds: a sufficiently small candidate rectangle admits strictly slack rational bounds; for sufficiently large S its angular inequality holds; the effective compact interval interface eventually verifies that candidate. This is a conditional computability theorem with a concrete search, not a complexity result. Naive interval subdivision may require work polynomial in inverse qmin or inverse error tolerance, hence exponential in log M, and coefficient evaluation may be worse. The explicit fixed-certificate initializer above avoids this repeated search once a single uniform certificate has been extracted. Neither procedure currently comes with the required effective representation of an admissible source instance.

## Verification and unresolved dependency

`check_effective_carrier.py` uses exact integer/rational arithmetic to verify the integer initializer's conservative envelope and the dyadic-cutoff majorant test for several nontrivial synthetic certificates. These are checks of the derived inequalities and implementation, not numerical certification of the external flow. They cannot replace the proofs above or the missing source norm bounds.

Next actual obligation: select an admissible effective source instance and produce numerical rational q0,b,delta,kminus,kplus,wminus,wplus,fminus,B,C with interval/analytic majorants valid down to q=0, using a fixed finite coefficient block plus a controlled tail. Only finitely many normalized derivatives are needed for this initializer, independent of M. The current proof therefore removes effective stable-sheet evaluation as a necessary dependency for finite horizons. It leaves source-bound extraction, physical preparation, localized memory, finite-cutoff export, SAT logic and a worst-case polynomial standard-model solver unresolved.
