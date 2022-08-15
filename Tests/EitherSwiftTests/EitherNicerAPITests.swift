import XCTest
import EitherSwift

final class EitherNicerAPITests: XCTestCase {

    func test_isLeft() {
        XCTAssertTrue( sutLeftEitherIntNever.isLeft )
        XCTAssertFalse( sutRightEitherNeverInt.isLeft )
    }

    func test_isRight() {
        XCTAssertTrue( sutRightEitherNeverInt.isRight )
        XCTAssertFalse( sutLeftEitherStringInt.isRight )
    }

    func test_right() {
        XCTAssertNotNil( sutRightEitherStringInt.right )
        XCTAssertNil( sutLeftEitherStringInt.right )

        // Forces correct overload to get triggerd
        let _: Int = sutRightEitherNeverInt.right
    }

    func test_left() {
        XCTAssertNil( sutRightEitherStringInt.left )
        XCTAssertNotNil( sutLeftEitherStringInt.left )

        // Forces correct overload to get triggerd
        let _: Error = sutLeftEitherErrorNever.left
    }

    func test_getLeftOr() {
        XCTAssertEqual(
            sutLeftEitherIntNever.getLeft(or: 69),
            sutLeftEitherIntNever.left!,
            "For left case should return assosiated value!"
        )

        XCTAssertEqual(
            sutRightEitherStringInt.getLeft(or: "new default"),
            "new default",
            "For right case should return injected value!"
        )
    }

    func test_getRightOr() {
        XCTAssertEqual(
            sutLeftEitherStringInt.getRight(or: 69),
            69,
            "For left case should return injected value!"
        )

        XCTAssertEqual(
            sutRightEitherStringInt.getRight(or: 69),
            sutRightEitherStringInt.right!,
            "For right case should return assosiated value!"
        )
    }

    func test_asOptional() {
        XCTAssertNotNil( sutRightEitherStringInt.asOptional )
        XCTAssertNil( sutLeftEitherStringInt.asOptional )
    }

    func test_asResult_whenLeftIsNever() {
        // Not an assert but still checks if API works ;)
        let _: Result<Int,Never> = sutRightEitherNeverInt.asResult
    }

    func test_asResult_whenLeftIsError() {

        switch sutLeftEitherErrorInt.asResult {
        case .success:
            XCTFail("Should report error!")
        case .failure(let error):
            XCTAssert(error is SutError)
        }

        switch sutRightEitherErrorInt.asResult {
        case .success(let value):
            XCTAssertEqual(value, sutRightEitherErrorInt.right!)
        case .failure:
            XCTFail("Should be a success case!")
        }

        switch sutLeftEitherErrorNever.asResult {
        case .failure(let error):
            XCTAssert(error is SutError)
        }

    }
}
