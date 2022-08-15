import XCTest
import EitherSwift

final class EitherUtilsTests: XCTestCase {

    func test_either() {

        let sut: (Either<String,Int>) -> Int = either( { $0.count } , increment )

        XCTAssertEqual(
            sut(sutRightEitherStringInt),
            meaningOfLife + 1,
            "Shold use right transform to colapse to expected Int!"
        )

        XCTAssertEqual(
            sut(sutLeftEitherStringInt),
            loremIpsum.count,
            "Shold use left transform to colapse to expected Int!"
        )
    }

    func test_lefts() {
        XCTAssertEqual(
            lefts( sutArrayEitherStringInt ),
            ["a", "b", "c", "d"]
        )
    }

    func test_rights() {
        XCTAssertEqual(
            rights( sutArrayEitherStringInt ),
            [1, 2, 3]
        )
    }

    func test_partitionEithers() {
        let (lefts, rights) = partitionEithers( sutArrayEitherStringInt )

        XCTAssertEqual(lefts, ["a", "b", "c", "d"])
        XCTAssertEqual(rights, [1, 2, 3])
    }

}
