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
                    .frame(width: 30, height: 30)
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
        VStack{
            PickerView(vm: ImagePickerViewModel(source: ["Arsenal", "Barcelona", "Chelsea", "Dynamo", "Milan", "Real Madrid", "Shakhtar", "Green Thumbs"]), pickerStyle: .wheel)
            PickerView(vm: ImagePickerViewModel(source: ["Estonia", "France", "Ukraine", "Germany", "Ireland", "Italy", "Monaco", "Nigeria", "Poland", "Spain", "UK", "US"], initialSelectedIndex: 2), pickerStyle: .wheel)
        }
        
    }
}
