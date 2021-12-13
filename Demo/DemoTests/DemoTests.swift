//
//  DemoTests.swift
//
//  Created by onsissond on 13.12.2021.
//

import Quick
import Nimble
import Combine
import NSObject_Combine

class DisposeBagTest: HasCancellable {
    var cancellable: Set<AnyCancellable>
    
    init(cancellable: Set<AnyCancellable>) {
        self.cancellable = cancellable
    }
}

class Test: QuickSpec {
    override func spec() {
        
        it("should respects the setter") {
            let subject = NSObject()
            let cancellable = Set<AnyCancellable>()
            subject.cancellable = cancellable
            let subjectProtocol = DisposeBagTest(cancellable: cancellable)
            subjectProtocol.cancellable = cancellable
            expect(subject.cancellable) === cancellable
            expect(subjectProtocol.cancellable) === cancellable
        }

        it("should dispose when the object is deallocated") {
            var executed = false
            var executedProtocol = false

            let variable = PassthroughSubject<Int, Never>()
            let variableProtocol = PassthroughSubject<Int, Never>()

            // Force the bag to deinit (and dispose itself).
            do {
                let subject = NSObject()
                let cancellable = Set<AnyCancellable>()
                let subjectProtocol = DisposeBagTest(cancellable: cancellable)

                variable.sink { _ in executed = true }
                .store(in: &subject.cancellable)
                
                variableProtocol.sink { _ in executedProtocol = true }
                    .store(in: &subjectProtocol.cancellable)
            }

            // Force a new value through the subscription to test its been disposed of.
            variable.send(1)
            variableProtocol.send(1)
            expect(executed) == false
            expect(executedProtocol) == false
        }

        it("should disposes using cancellable") {
            var executed = false
            let variable = PassthroughSubject<Int, Never>()

            do {
                let subject = NSObject()

                variable.sink { _ in executed = true }
                    .store(in: &subject.cancellable)
            }

            variable.send(1)
            expect(executed) == false
        }
    }
}
