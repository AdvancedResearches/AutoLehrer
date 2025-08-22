//
//  PausableTimer.swift
//  AutoLehrer
//
//  Created by Алексей Хурсевич on 22.08.25.
//
import CoreData

class PausableTimer {
    private var timer: Timer?
    private let interval: TimeInterval
    private let handler: () -> Void
    private var isRunning = false
    private var isPaused = false
    
    init(interval: TimeInterval, handler: @escaping () -> Void) {
        self.interval = interval
        self.handler = handler
    }
    
    func start() {
        guard !isRunning else { return }
        schedule()
        isRunning = true
        isPaused = false
    }
    
    func pause() {
        guard isRunning, !isPaused else { return }
        timer?.invalidate()
        isPaused = true
    }
    
    func resume() {
        guard isRunning, isPaused else { return }
        schedule()
        isPaused = false
    }
    
    func invalidate() {
        timer?.invalidate()
        timer = nil
        isRunning = false
        isPaused = false
    }
    
    private func schedule() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: interval, repeats: true) { _ in
            self.handler()
        }
    }
}
