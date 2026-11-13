---------------------------- MODULE EitherLaws ----------------------------
(* Finite model of Sources/EitherSwift: Either<Left, Right> and its         *)
(* map / mapLeft / biMap / flatMap / flatMapLeft / fold / isLeft / isRight. *)
(* Values range over small finite sets; transforms range over the full      *)
(* function space, so every law is checked for every possible closure.      *)
EXTENDS Naturals

CONSTANTS Vals,     \* carrier used for both Left and Right payloads
          Mutant    \* "none" for the real semantics, otherwise a seeded bug

Left(x)  == [tag |-> "left",  v |-> x]
Right(x) == [tag |-> "right", v |-> x]
Eithers  == {Left(x) : x \in Vals} \cup {Right(x) : x \in Vals}
Fns      == [Vals -> Vals]
KFns     == [Vals -> Eithers]          \* Kleisli arrows R -> Either<L, R'>
Id       == [x \in Vals |-> x]
Compose(g, f) == [x \in Vals |-> g[f[x]]]

IsLeft(e)  == e.tag = "left"
IsRight(e) == e.tag = "right"

\* EitherMap.swift
Map(e, f) ==
  IF IsRight(e) THEN Right(f[e.v])
  ELSE IF Mutant = "map_flips_left" THEN Right(e.v) ELSE e
MapLeft(e, f)    == IF IsLeft(e) THEN Left(f[e.v]) ELSE e
BiMap(e, f, g)   == IF IsLeft(e) THEN Left(f[e.v]) ELSE Right(g[e.v])
FlatMap(e, k)    ==
  IF IsRight(e) THEN k[e.v]
  ELSE IF Mutant = "flatmap_drops_left" THEN Right(e.v) ELSE e
FlatMapLeft(e, k) == IF IsLeft(e) THEN k[e.v] ELSE e
\* EitherFold.swift
Fold(e, f, g)    == IF IsLeft(e) THEN f[e.v] ELSE g[e.v]
KCompose(k2, k1) == [x \in Vals |-> FlatMap(k1[x], k2)]

VARIABLE e
Init == e \in Eithers
Next == UNCHANGED e
Spec == Init /\ [][Next]_e

TypeOK            == e \in Eithers
TagsExclusive     == IsLeft(e) # IsRight(e)
FunctorIdentity   == Map(e, Id) = e /\ MapLeft(e, Id) = e
FunctorComposition ==
  \A f, g \in Fns : Map(e, Compose(g, f)) = Map(Map(e, f), g)
LeftPreservedByMap == IsLeft(e) => \A f \in Fns : Map(e, f) = e
BiMapIsBothMaps   ==
  \A f, g \in Fns : BiMap(e, f, g) = MapLeft(Map(e, g), f)
MonadLeftIdentity ==
  \A k \in KFns : \A x \in Vals : FlatMap(Right(x), k) = k[x]
MonadRightIdentity == FlatMap(e, [x \in Vals |-> Right(x)]) = e
MonadAssociativity ==
  \A k1, k2 \in KFns : FlatMap(FlatMap(e, k1), k2) = FlatMap(e, KCompose(k2, k1))
FlatMapLeftShortCircuits ==
  IsRight(e) => \A k \in KFns : FlatMapLeft(e, k) = e
FoldIsCaseAnalysis ==
  \A f, g \in Fns : Fold(e, f, g) = (IF IsLeft(e) THEN f[e.v] ELSE g[e.v])
MapViaFlatMap ==
  \A f \in Fns : Map(e, f) = FlatMap(e, [x \in Vals |-> Right(f[x])])
=============================================================================
