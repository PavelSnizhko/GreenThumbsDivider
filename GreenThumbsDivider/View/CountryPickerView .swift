//
//  CountryPickerView .swift
//  GreenThumbsDivider
//
//  Created by Павло Сніжко on 05.05.2023.
//

import SwiftUI

class CountryPickerViewModel: ObservableObject {
    let countries: [String] = ["Estonia", "France", "Germany", "Ireland", "Italy", "Monaco", "Nigeria", "Poland", "Spain", "UK", "US", "Ukraine"]
    
    @Published var selectedImageIndex = 0
    
    var selectedImage: UIImage {
        UIImage(named: countries[selectedImageIndex])!
    }
    
}

struct CountryPickerView: View {
    @ObservedObject var vm: CountryPickerViewModel

    var body: some View {
        Picker(selection: $vm.selectedImageIndex, label: Text("")) {
            ForEach(0..<vm.countries.count, id: \.self) { index in
                Image(vm.countries[index])
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 50, height: 50)
            }
        }
        .pickerStyle(.wheel)
        .onChange(of: vm.selectedImageIndex, perform: { newValue in
            print("Index is changed \(vm.selectedImageIndex)")
        })
    }
}

struct CountryPickerView__Previews: PreviewProvider {
    static var previews: some View {
        CountryPickerView(vm: CountryPickerViewModel())
    }
}
