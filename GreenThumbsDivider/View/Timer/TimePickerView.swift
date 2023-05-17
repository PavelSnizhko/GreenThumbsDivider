//
//  TimePickerView.swift
//  GreenThumbsDivider
//
//  Created by Павло Сніжко on 17.05.2023.
//

import SwiftUI

struct TimePickerView: View {
    private let pickerViewTitlePadding: CGFloat = 4.0

    let title: String
    let range: ClosedRange<Int>
    let binding: Binding<Int>
    
    var body: some View {
        HStack(spacing: -pickerViewTitlePadding) {
            Picker(title, selection: binding) {
                ForEach(range, id: \.self) { timeIncrement in
                    HStack {
                        // Forces the text in the Picker to be
                        // right-aligned
                        Spacer()
                        Text("\(timeIncrement)")
                            .foregroundColor(.white)
                            .multilineTextAlignment(.trailing)
                    }
                }
            }
            .pickerStyle(InlinePickerStyle())
            .labelsHidden()

            Text(title)
                .fontWeight(.bold)
        }
    }
}

struct TimePickerView_Previews: PreviewProvider {
    static var previews: some View {
        TimePickerView(title: "min", range: ClosedRange(uncheckedBounds: (lower: 0, upper: 59)), binding: .constant(0)).frame(width: 100)
    }
}
