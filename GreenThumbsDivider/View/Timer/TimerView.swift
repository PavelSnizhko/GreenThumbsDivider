//
//  TimerView.swift
//  GreenThumbsDivider
//
//  Created by Павло Сніжко on 17.05.2023.
//

import SwiftUI

struct TimerView: View {
    @StateObject private var model = TimerViewModel()

    var body: some View {
        VStack {
            if model.state == .cancelled {
                timePickerControl
            } else {
                progressView
            }

            timerControls
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.black)
        .foregroundColor(.white)
    }
    
    var timerControls: some View {
        HStack(spacing: 50) {
            Button("Cancel") {
                model.state = .cancelled
            }
            .buttonStyle(CircleButtonStyle(color: Color("TimerButtonCancel")))
            
//            Spacer()
            
            switch model.state {
            case .cancelled:
                Button("Start") {
                    model.state = .active //.startTimer()
                }
                .buttonStyle(CircleButtonStyle(color: Color("TimerButtonStart")))
            case .paused:
                Button("Resume") {
                    model.state = .resumed //.resumeTimer()
                }
                .buttonStyle(CircleButtonStyle(color: Color("TimerButtonPause")))
            case .active, .resumed:
                Button("Pause") {
                    model.state = .paused //.pauseTimer()
                }
                .buttonStyle(CircleButtonStyle(color: Color("TimerButtonPause")))
            }
        }
    }
        
}
    
extension TimerView {
    var timePickerControl: some View {
        HStack() {
            TimePickerView(title: "hours", range: model.hoursRange, binding: $model.selectedHoursAmount)
            TimePickerView(title: "min", range: model.minutesRange, binding: $model.selectedMinutesAmount)
            TimePickerView(title: "sec", range: model.secondsRange, binding: $model.selectedSecondsAmount)
        }
        .frame(width: 360, height: 255)
        .padding(.all, 32)
    }
    
    var progressView: some View {
        ZStack {
            withAnimation {
                CircularProgressView(progress: $model.progress)
            }
            
            VStack {
                Text(model.secondsToCompletion.asTimestamp)
                    .font(.largeTitle)
                HStack {
                    Image(systemName: "bell.fill")
                    Text(model.completionDate, format: .dateTime.hour().minute())
                }
            }
        }
        .frame(width: 360, height: 255)
        .padding(.all, 32)
    }
}
                                 
struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView()
    }
}
