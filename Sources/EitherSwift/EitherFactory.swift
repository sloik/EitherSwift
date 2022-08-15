
import Foundation

public extension Either where Left: Error {

    init(result: Result<Right,Left>)  {
        switch result {
        case .success(let a):
            self = .right( a )
        case .failure(let e):
            self = .left( e )
        }
    }
}

public extension Either where Left == Void {

    init(optional: Right?) {
        switch optional {
        case .some(let w):
            self = .right( w )
        case .none:
            self = .left(())
        }
    }
}

public extension Either where Left == Never {

    init(value: Right) {
        self = .right( value )
    }


}
