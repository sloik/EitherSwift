
import Foundation

// MARK: - Utils
// Inspired from: http://hackage.haskell.org/package/base-4.14.0.0/docs/Data-Either.html


/// Case analisis for for `Either` type.
///
/// When one neads a value depending on `right` or `left` case:
///
///  ```swift
///
///  let intFromEither: (Either<String,Int>) -> Int = either( { $0.count } , { $0 + 1 } )
///
///  intFromEither( Either<String,Int>.right(41) )
///  // returns 42
///
///  intFromEither( Either<String,Int>.left("lorem ipsum") )
///  // returns 11
///  ```
///
/// - Parameters:
///   - leftTransform: Closure transforming instance of `Left` type to `T`
///   - rightTransform: Closure transforming instance of `Right` type to `T`
/// - Returns: value ot type `T`.
@discardableResult
public func either<L,R,T>(
    _  leftTransform: @escaping (L) -> T,
    _ rightTransform: @escaping (R) -> T) -> (Either<L,R>) -> T {
    return { either in
        switch either {
        case .left(let l) : return  leftTransform(l)
        case .right(let r): return rightTransform(r)
        }
    }
}

@discardableResult
public func lefts<L,R>(_ eithers: [Either<L,R>] ) -> [L] {
    eithers.compactMap(\.left)
}

@discardableResult
public func rights<L,R>(_ eithers: [Either<L,R>] ) -> [R] {
    eithers.compactMap(\.right)
}

@discardableResult
public func partitionEithers<L,R>(_ eithers: [Either<L,R>]) -> ([L], [R]) {
    
    eithers
        .reduce(
            into: (lefts: [L](), rights: [R]())
        ) { (partialResult, either) in
            either
                .biMap(
                    { l in partialResult.lefts.append( l ) },
                    { r in partialResult.rights.append( r ) }
                )
        }
}
