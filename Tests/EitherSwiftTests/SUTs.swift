
import Foundation

import EitherSwift

// MARK: - Transforms

/// Adds 1 to passed in argument.
func increment(_ i: Int) -> Int { i + 1 }

/// Adds 1 to passed in argument and returns `.right`.
func incrementRightStringInt(_ i: Int) -> Either<String,Int> { .right( i + 1 ) }

/// Apends `!` to input string.
func shout(_ s: String) -> String { s + "!" }

/// Apends `!` to input string and returns `.left`.
func shoutLeftStringInt(_ s: String) -> Either<String,Int> { .left( s + "!") }

// MARK: - Error

enum SutError: Error {
    case defaultError
}

// MARK: - Values

/// "lorem ipsum"
let loremIpsum = "lorem ipsum"

let meaningOfLife = 42

// MARK: - SUTs

/// .left(42)
let sutLeftEitherIntNever: Either<Int,Never> = .left(meaningOfLife)

/// .left("lorem ipsum")
let sutLeftEitherStringInt: Either<String,Int> = .left(loremIpsum)

/// .left( SutError.defaultError )
let sutLeftEitherErrorInt: Either<Error,Int> = .left( SutError.defaultError )

/// .left( SutError.defaultError )
let sutLeftEitherErrorNever: Either<Error,Never> = .left( SutError.defaultError )

/// .right(42)
let sutRightEitherNeverInt: Either<Never,Int> = .right(meaningOfLife)

/// .right(42)
let sutRightEitherErrorInt: Either<Error,Int> = .right(meaningOfLife)

/// .right(42)
let sutRightEitherStringInt: Either<String,Int> = .right(meaningOfLife)

/// [.left("a"), .left("b"), .left("c"), .right(1), .left("d"), .right(2), .right(3)]
let sutArrayEitherStringInt: [Either<String,Int>] = [
    .left("a"), .left("b"), .left("c"), .right(1), .left("d"), .right(2), .right(3)
]
