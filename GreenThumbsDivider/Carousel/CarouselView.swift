//
//  CarouselView.swift
//  GreenThumbsDivider
//
//  Created by Павло Сніжко on 11.04.2023.
//

import SwiftUI

//struct CarouselView: View {
//    @StateObject var viewModel: CarouselViewModel
//        
//    var body: some View {
//        ScrollViewReader { scrollViewProxy in
//            ScrollView(.horizontal, showsIndicators: false) {
//                HStack(spacing: 10) {
//                    ForEach(viewModel.members, id: \.id) { member in
//                        VStack(spacing: 5) {
//                            if let image = member.image {
//                                Image(uiImage: image)
//                                    .resizable()
//                                    .aspectRatio(contentMode: .fill)
//                                    .frame(width: viewModel.selectedMember == member ? 200 : 100,
//                                           height: viewModel.selectedMember == member ? 200 : 100)
//                                    .clipShape(Circle())
//                                    .id(member.id)
//                                    .onTapGesture {
//                                        viewModel.selectMember(member)
//                                    
//                                        withAnimation {
//                                            scrollViewProxy.scrollTo(member.id, anchor: .center)
//                                        }
//                                    }
//                            }
//                            Text(member.name)
//                        }
//                        //looks not good(some lags)
////                        .animation(.easeInOut, value: viewModel.selectedMember)
//                    }
//                }
//                .frame(minHeight: 230)
//            }
//            .onAppear {
//                viewModel.fetchImages()
//            }
//        }
//    }
//}

