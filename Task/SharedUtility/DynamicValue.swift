//
//  DynamicValue.swift
//  Task
//
//  Created by Hemalatha K on 22/06/2021.
//  Copyright © 2021 HackerFactory. All rights reserved.
//

import Foundation

public class Dynamic<T> {
    public typealias Listener = (T) -> Void
    public var listener: Listener?
    public var value: T {
        didSet {
            listener?(value)
        }
    }
    init(_ value: T) {
        self.value = value
    }
    public func bind(_ listener: @escaping Listener) {
        self.listener = listener
    }
}
