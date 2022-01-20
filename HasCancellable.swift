import Foundation
import Combine
import ObjectiveC

fileprivate var cancellableContext: UInt8 = 0

/// each HasCancellable offers a unique Combine Cancellable instance
public protocol HasCancellable: AnyObject {

    /// a unique Combine Cancellable instance
    var cancellable: Set<AnyCancellable> { get set }
}

extension HasCancellable {

    func synchronizedBag<T>( _ action: () -> T) -> T {
        objc_sync_enter(self)
        let result = action()
        objc_sync_exit(self)
        return result
    }

    public var disposeBag: Set<AnyCancellable> {
        get {
            synchronizedBag {
                if let disposeObject = objc_getAssociatedObject(self, &cancellableContext) as? CombineDisposeBag {
                    return disposeObject.cancellable
                }
                let disposeObject = CombineDisposeBag(Set<AnyCancellable>())
                objc_setAssociatedObject(self, &cancellableContext, disposeObject, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                return disposeObject.cancellable
            }
        }

        set {
            synchronizedBag {
                objc_setAssociatedObject(self, &cancellableContext, CombineDisposeBag(newValue), .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            }
        }
    }
}



