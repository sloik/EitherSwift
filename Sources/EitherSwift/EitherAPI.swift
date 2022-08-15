
import Foundation

// MARK: - Nicer APIs

public extension Either {

    /// `true` when is `left`
    var isLeft: Bool {
        switch self {
        case .left: return true

        default: return false
        }
    }

    /// `true` when is `left`
    var isRight: Bool {
        switch self {
        case .right: return true

        default: return false
        }
    }

    var right: Right? {
        switch self {
        case .right(let r): return r
        default: return .none
        }
    }

    var left: Left? {
        switch self {
        case .left(let l): return l
        default: return .none
        }
    }

    /// Return the contents of a Left-value or a default value otherwise.
    /// - Parameter defaultLeft: Value of type `Left` to be returned when self is `Right`
    @discardableResult
    func getLeft(or defaultLeft: Left) -> Left { left ?? defaultLeft }

    /// Return the contents of a Right-value or a default value otherwise.
    /// - Parameter defaultLeft: Value of type `Right` to be returned when self is `Left`
    @discardableResult
    func getRight(or defaultRight: Right) -> Right { right ?? defaultRight }

    // Right is a bit special in this type 🤓
    var asOptional: Right? { right }
}

// MARK: - Never

public extension Either where Left == Never {
    var right: Right {
        switch self {
        case .right(let r): return r
        }
    }

    var asResult: Result<Right, Never> {
        .success(right)
    }
}

public extension Either where Left == Error {
    var asResult: Result<Right, Left> {
        switch self {
        case .left(let l):
            return .failure(l)

        case .right(let r):
            return .success(r)
        }
    }
}

public extension Either where Right == Never, Left == Error {
    var left: Left {
        switch self {
        case .left(let l): return l
        }
    }

    var asResult: Result<Never, Left> {
        .failure(left)
    }
}
