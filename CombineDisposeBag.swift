//
//  File.swift
//  NSObject-Combine
//
//  Created by Sukhanov Evgeny on 20.01.2022.
//

import Combine

public class CombineDisposeBag {
    public var cancellable: Set<AnyCancellable>
    
    init(_ cancellable: Set<AnyCancellable>) {
        self.cancellable = cancellable
    }
}
