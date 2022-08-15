import Foundation

public extension Either {

    @discardableResult
    func map<R>(_ transform: (Right) -> R) -> Either<Left,R> {
        switch self {
        case .right(let r):
            return .right( transform( r ) )

        case .left(let l):
            return .left( l )
        }
    }

    @discardableResult
    func mapRight<R>(_ transform: (Right) -> R) -> Either<Left, R> {
        map(transform)
    }

    @discardableResult
    func mapLeft<L>(_ transform: (Left) -> L) -> Either<L, Right> {
        switch self {
        case .right(let r):
            return .right( r )

        case .left(let l):
            return  .left( transform(l) )
        }
    }

    @discardableResult
    func biMap<L,R>( _  leftTransform:  (Left) -> L,
                     _ rightTransform: (Right) -> R)
        -> Either<L, R> {
            switch self {
            case .left (let l): return  Either<L, R>.left ( leftTransform(l))
            case .right(let r): return  Either<L, R>.right(rightTransform(r))
            }
    }
}

public extension Either {

    @discardableResult
    func flatMap<R>(_ transform: (Right) -> Either<Left, R> ) -> Either<Left, R> {
        switch self {
        case .left(let l) : return Either<Left, R>.left(l)
        case .right(let r): return transform(r)
        }
    }

    @discardableResult
    func flatMapRight<R>(_ transform: (Right) -> Either<Left, R>) -> Either<Left, R> {
        flatMap(transform)
    }

    @discardableResult
    func flatMapLeft<L>(_ transform: (Left) -> Either<L, Right>) -> Either<L, Right> {
        switch self {
        case .left(let l) : return transform(l)
        case .right(let r): return Either<L, Right>.right(r)
        }
    }
}

// MARK: - Free Maps

@discardableResult
public func map<NewRight,L,R>(
    _ either: Either<L,R>,
    _ transform: (R) -> NewRight)
    -> Either<L,NewRight> {
        either.map(transform)
}

@discardableResult
public func mapRight<NewRight,L,R>(
    _ either: Either<L,R>,
    _ transform: (R) -> NewRight)
    -> Either<L,NewRight> {
        map(either, transform)
}

@discardableResult
public func mapLeft<NewLeft,L,R>(
    _ either: Either<L,R>,
    _ transform: (L) -> NewLeft)
    -> Either<NewLeft,R> {
        either.mapLeft(transform)
}

@discardableResult
public func biMap<NewLeft, NewRight, L,R>(
    _ either: Either<L,R>,
    _ leftTransform: (L) -> NewLeft,
    _ rightTransform: (R) -> NewRight)
    -> Either<NewLeft,NewRight> {
        either.biMap(leftTransform, rightTransform)
}

@discardableResult
public func flatMap<T,L,R>(
    _ either: Either<L,R>,
    _ transform: (R) -> Either<L,T>)
    -> Either<L,T> {
        either.flatMap(transform)
}

@discardableResult
public func flatMapRight<NewRight,L,R>(
    _ either: Either<L,R>,
    _ transform: (R) -> Either<L,NewRight>)
    -> Either<L,NewRight> {
        flatMap(either, transform)
}

@discardableResult
public func flatMapLeft<NewLeft,L,R>(
    _ either: Either<L,R>,
    _ transform: (L) -> Either<NewLeft,R>)
    -> Either<NewLeft,R> {
        either.flatMapLeft(transform)
}
