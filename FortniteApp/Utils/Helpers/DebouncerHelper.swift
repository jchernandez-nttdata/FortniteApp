//
//  DebouncerHelper.swift
//  FortniteApp
//
//  Created by Juan Carlos Hernandez Castillo on 6/09/24.
//

import Foundation

/// A helper class that provides debouncing functionality.
final class DebouncerHelper {
    private let delay: TimeInterval
    private var workItem: DispatchWorkItem?
    
    init(delay: TimeInterval) {
        self.delay = delay
    }
    
    /// Debounces the given action, delaying its execution until a specified time interval has passed since the last call.
    /// - Parameter action: A closure to be executed after the delay.
    func run(action: @escaping (() -> Void)) {
        workItem?.cancel()
        workItem = DispatchWorkItem { [weak self] in
            action()
            self?.workItem = nil
        }
        if let workItem {
            DispatchQueue.main.asyncAfter(deadline: .now() + delay, execute: workItem)
        }
    }
}
