/*:
 # Inspiration

 https://hackage.haskell.org/package/base-4.12.0.0/docs/Data-Either.html
 */

import Foundation

public enum Either<Left, Right> {
    case left(Left)
    case right(Right)
}

extension Either: Equatable where Left: Equatable, Right: Equatable {}
