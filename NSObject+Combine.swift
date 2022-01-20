import Combine
import Foundation
import ObjectiveC

private var cancellableContext: UInt8 = 0

extension NSObject {
    func synchronizedBag<T>(_ action: () -> T) -> T {
        objc_sync_enter(self)
        let result = action()
        objc_sync_exit(self)
        return result
    }
}

public extension NSObject {
    /// a unique DisposeBag that is related to the Reactive.Base instance only for Reference type
    var cancellable: Set<AnyCancellable> {
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
