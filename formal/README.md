# Formal model (TLA+)

`EitherLaws.tla` is a finite TLA+ model of the public semantics of `Either<Left, Right>` as
written in `Sources/EitherSwift`. TLC checks every law over every value of a small carrier
(`Vals = {0, 1}`) and **every** possible transform in the finite function space, so each
law holds for all closures, not just a few hand-picked examples.

| Invariant | Swift API it abstracts |
|---|---|
| `TypeOK`, `TagsExclusive` | `enum Either { case left, right }`, `isLeft` / `isRight` |
| `FunctorIdentity`, `FunctorComposition` | `map`, `mapRight`, `mapLeft` (functor laws) |
| `LeftPreservedByMap` | `map` on `.left` returns the same `.left` |
| `BiMapIsBothMaps` | `biMap(f, g) == mapLeft(f) ∘ map(g)` |
| `MonadLeftIdentity`, `MonadRightIdentity`, `MonadAssociativity` | `flatMap` / `flatMapRight` (monad laws) |
| `FlatMapLeftShortCircuits` | `flatMapLeft` on `.right` is a no-op |
| `FoldIsCaseAnalysis` | `fold(leftTransform, rightTransform)` |
| `MapViaFlatMap` | `map(f) == flatMap { .right(f($0)) }` |

## Non-vacuity

Each `EitherLaws.<mutant>.cfg` seeds one bug through the `Mutant` constant and names the
invariant that must catch it (`\* EXPECT_VIOLATION: …`). `run_tlc.sh` fails if a mutant passes,
which proves the invariants can go red.

## Running

```sh
TLA_JAR=/path/to/tla2tools-1.7.4.jar formal/run_tlc.sh   # needs Java 11+
```

The script checks the jar's SHA-256 against the pinned tla2tools 1.7.4. CI runs it on a
self-hosted Oracle ARM64 runner, only on pushes to the default branch or by manual dispatch
(`.github/workflows/oracle-tla.yml`). The Swift build and tests stay on hosted macOS.

## Limits

The model describes the *intended* semantics, read by hand from the Swift sources. It does not
prove the Swift code conforms; the XCTest suite covers the code. If the Swift behaviour
changes, update the model in the same PR.
