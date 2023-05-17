//
//  TimerViewModel.swift
//  GreenThumbsDivider
//
//  Created by Павло Сніжко on 17.05.2023.
//

import SwiftUI

final class TimerViewModel: ObservableObject {
    
    // Represents the different states the timer can be in
    enum TimerState {
        case active
        case paused
        case resumed
        case cancelled
    }
    
    // MARK: Private Properties
    private var timer = Timer()
    private var totalTimeForCurrentSelection: Int {
        (selectedHoursAmount * 3600) + (selectedMinutesAmount * 60) + selectedSecondsAmount
    }
    
    // MARK: Public Properties
    
    @Published var selectedHoursAmount = 0
    @Published var selectedMinutesAmount = 0
    @Published var selectedSecondsAmount = 10
    
    let hoursRange = 0...23
    let minutesRange = 0...59
    let secondsRange = 0...59
    
    @Published var state: TimerState = .cancelled {
        didSet {
            // Modeled as a state machine for easier testing and
            // a cleaner / more readable implementation
            switch state {
            case .cancelled:
                // Cancel the timer and reset all progress properties
                timer.invalidate()
                secondsToCompletion = 0
                progress = 0

            case .active:
                // Starts the timer and sets all progress properties
                // to their initial values
                startTimer()

                secondsToCompletion = totalTimeForCurrentSelection
                progress = 1.0

                updateCompletionDate()

            case .paused:
                // We want to pause the timer, but we
                // don't want to change the state of our progress
                // properties (secondsToCompletion and progress)
                timer.invalidate()

            case .resumed:
                // Resumes the timer
                startTimer()
                
                // We don't know how long we've been paused for, so
                // we need to update our ETA
                updateCompletionDate()
            }
        }
    }
    
    // Powers the ProgressView
    @Published var secondsToCompletion = 0
    @Published var progress: Float = 0.0
    @Published var completionDate = Date.now
    
    private func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { [weak self] _ in
            guard let self else { return }

            self.secondsToCompletion -= 1
            self.progress = Float(self.secondsToCompletion) / Float(self.totalTimeForCurrentSelection)

            // We can't do <= here because we need to ensure the animation
            // has time to finish running (see .linear(duration: 1.0))
            if self.secondsToCompletion < 0 {
                self.state = .cancelled
            }
        })
    }

    private func updateCompletionDate() {
        completionDate = Date.now.addingTimeInterval(Double(secondsToCompletion))
    }
}
