
import XCTest
import EitherSwift

final class EitherFactoryTests: XCTestCase {

    func test_initResult() {

        XCTAssertEqual(
            Either(result: Result<Int, FactoryTestError>.success(42) ),
            Either<FactoryTestError, Int>.right(42)
        )

        XCTAssertEqual(
            Either(result: Result<Int, FactoryTestError>.failure( .ups ) ),
            Either<FactoryTestError, Int>.left( .ups )
        )
    }

    func test_initOptional() {

        XCTAssertEqual(
            Either(optional: Int?.some(42)).right,
            Either<Void,Int>.right(42).right
        )

        XCTAssert( Either(optional: Int?.none).isLeft )
    }

    func test_initValue() {

        XCTAssertEqual(
            Either(value: 42),
            Either<Never,Int>.right(42)
        )
    }

}

fileprivate enum FactoryTestError: Error, Equatable {
    case ups
}
