//
//  CountryPickerView .swift
//  GreenThumbsDivider
//
//  Created by Павло Сніжко on 05.05.2023.
//

import SwiftUI

struct PickerView<Style: PickerStyle>: View {
    @ObservedObject var vm: ImagePickerViewModel
    let pickerStyle: Style

    var body: some View {
        Picker(selection: $vm.selectedImageIndex, label: Text("")) {
            ForEach(0..<vm.source.count, id: \.self) { index in
                Image(vm.source[index])
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 50, height: 50)
                    .padding([.top, .bottom], 10)
            }
        }
        .pickerStyle(pickerStyle)
        .onChange(of: vm.selectedImageIndex, perform: { newValue in
            print("Index is changed \(vm.selectedImageIndex)")
        })
    }
}

struct CountryPickerView__Previews: PreviewProvider {
    static var previews: some View {
        PickerView(vm: ImagePickerViewModel(source: ["Estonia", "France", "Germany", "Ireland", "Italy", "Monaco", "Nigeria", "Poland", "Spain", "UK", "US", "Ukraine"]), pickerStyle: .wheel)
    }
}
