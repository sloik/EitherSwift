import XCTest
import EitherSwift

/*:

 "Free" vesrions of the map function delegate to instance implementation.

 */

final class EitherMapTests: XCTestCase {

    func test_mapRight_forRightCase_shouldPerformTransformation() {

        let expectedResult = sutRightEitherNeverInt.right + 1
        let result: Int = mapRight( sutRightEitherNeverInt, increment).right

        XCTAssertEqual(result, expectedResult)
    }

    func test_mapRight_forLeftCase_shouldNotChangeTheInstance() {

        let result: Either<String, Int> = mapRight( sutLeftEitherStringInt, increment)
        XCTAssertEqual(
            result,
            sutLeftEitherStringInt,
            "Free function inmplementation should not change the instnace!"
        )

        XCTAssertEqual(
            sutLeftEitherStringInt.mapRight(increment),
            sutLeftEitherStringInt,
            "Instance implementation should not change the instance!"
        )
    }

    func test_mapLeft_forRightCase_shouldNotChangeTheInstance() {

        let result = mapLeft( sutRightEitherStringInt, shout )

        XCTAssertEqual(result, sutRightEitherStringInt)
    }

    func test_mapLeft_forLeftCase_performTheTranformation() {

        let expectedResult = sutLeftEitherIntNever.left! + 1
        let result: Int = mapLeft( sutLeftEitherIntNever, increment).left!

        XCTAssertEqual(result, expectedResult)
    }

    func test_biMap() {

        XCTAssertEqual(
            biMap(sutRightEitherStringInt, shout, increment),
            sutRightEitherStringInt.map( increment ),
            "For `right` case biMap should use right transform function!"
        )

        XCTAssertEqual(
            biMap(
                sutLeftEitherStringInt,
                shout,
                increment
            ),
            sutLeftEitherStringInt.mapLeft( shout ),
            "For `left` case biMap should use left transform function!"
        )
    }

    /// `Right` case by convention is a bit special and should be
    /// treaded as plain `flatMap`.
    func test_flatMapRight() {

        XCTAssertEqual(
            flatMapRight(
                sutRightEitherStringInt,
                incrementRightStringInt
            ),
            sutRightEitherStringInt.map(increment),
            "Should flatten structure and apply the transform!"
        )

        XCTAssertEqual(
            sutRightEitherStringInt.flatMapRight(incrementRightStringInt),
            sutRightEitherStringInt.map(increment),
            "Should flatten structure and apply the transform!"
        )

        XCTAssertEqual(
            flatMapRight(
                sutLeftEitherStringInt,
                incrementRightStringInt
            ),
            sutLeftEitherStringInt,
            "Should flatten structure and do not touch the instance!"
        )

    }

    func test_flatMapLeft() {
        XCTAssertEqual(
            flatMapLeft(
                sutLeftEitherStringInt,
                shoutLeftStringInt
            ),
            sutLeftEitherStringInt.mapLeft(shout),
            "Should flatten structure and apply the transform!"
        )

        XCTAssertEqual(
            flatMapLeft(
                sutRightEitherStringInt,
                shoutLeftStringInt
            ),
            sutRightEitherStringInt,
            "Should flatten structure and do nothing with `right` instance!"
        )
    }
}
