//
//  CarouselView.swift
//  GreenThumbsDivider
//
//  Created by Павло Сніжко on 11.04.2023.
//

import SwiftUI

struct CarouselView: View {
    @StateObject var viewModel: CarouselViewModel
    
    @State private var show: Bool = false
    
    var body: some View {
        ScrollViewReader { scrollViewProxy in
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    ForEach(viewModel.members, id: \.id) { member in
                        VStack(spacing: 5) {
                            Image(member.imageName)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: viewModel.selectedMember == member ? 200 : 100,
                                       height: viewModel.selectedMember == member ? 200 : 100)
                                .clipShape(Circle())
                                .id(member.id)
                                .onTapGesture {
                                    viewModel.selectMember(member)
                                }
                            Text(member.name)
                            
                        }
                        .animation(.spring(), value: viewModel.selectedMember)
                    }
                }
                .frame(minHeight: 230)
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)) // Add padding for spacing
            }
            .onChange(of: viewModel.selectedMember, perform: { image in
                guard let image else {
                    return
                }
                withAnimation {
                    scrollViewProxy.scrollTo(image.id, anchor: .trailing)
                }
            })
            .onAppear {
                viewModel.fetchImages()
            }
        }
    }
}

