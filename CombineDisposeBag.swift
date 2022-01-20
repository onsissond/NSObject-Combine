import Combine

class CombineDisposeBag {
    var cancellable: Set<AnyCancellable>
    
    init(_ cancellable: Set<AnyCancellable>) {
        self.cancellable = cancellable
    }
}
