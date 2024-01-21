
public extension Either {

    @discardableResult
    func fold<R>( _  leftTransform:  (Left) -> R,
                  _ rightTransform: (Right) -> R)
        -> R {
            switch self {
            case .left (let l) : return  leftTransform(l)
            case .right(let r): return rightTransform(r)
            }
    }

}
