//
//  Tabs.swift
//  GreenThumbsDivider
//
//  Created by Павло Сніжко on 08.06.2023.
//

import SwiftUI

struct Tab {
    var icon: Image?
    var title: String
}

struct Tabs: View {
    var fixed = true
    var tabs: [Tab]
    var geoWidth: CGFloat
    
    let selectionColor = Color(red: 33.0/255.0, green: 41.0/255.0, blue: 92.0/255.0)
    let scrollViewColor = UIColor(red: 0.576, green: 0.639, blue: 0.694, alpha: 1)
    
    @Binding var selectedTab: Int
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            ScrollViewReader { proxy in
                VStack(spacing: 0) {
                    HStack(spacing: 0) {
                        ForEach(0 ..< tabs.count, id: \.self) { row in
                            Button(action: {
                                withAnimation {
                                    selectedTab = row
                                }
                            }, label: {
                                ZStack {
                                    // Bar Indicator
                                    Rectangle().fill(selectedTab == row ? selectionColor : Color.clear)
                                        .frame(height: 55)
                                        .cornerRadius(50)
                                    HStack {
                                        // Image
                                        AnyView(tabs[row].icon)
                                            .padding(EdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 0))
                                        // Text
                                        Text(tabs[row].title)
                                            .font(Font.system(size: 16, weight: .semibold))
                                            .padding(EdgeInsets(top: 10, leading: 3, bottom: 10, trailing: 0))
                                    }
                                    .foregroundColor(selectedTab == row ? Color.white :  selectionColor)
                                    .frame(width: fixed ? (geoWidth / CGFloat(tabs.count)) : .none, height: 52)
                                }.fixedSize()
                            })
                            .buttonStyle(PlainButtonStyle())
                            .foregroundColor(selectedTab == row ? Color.white : selectionColor)
                        }
                    }
                    .onChange(of: selectedTab) { target in
                        withAnimation {
                            proxy.scrollTo(target)
                        }
                    }
                }
            }
        }
        .frame(height: 55)
        .cornerRadius(50)
        .onAppear(perform: {
            UIScrollView.appearance().bounces = fixed ? false : true
        })
        .onDisappear(perform: {
            UIScrollView.appearance().bounces = true
        })
    }
}
struct Tabs_Previews: PreviewProvider {
    static var previews: some View {
        Tabs(fixed: true,
             tabs: [.init(icon: Image(systemName: "star.fill"), title: "Players"),
                    .init(icon: Image(systemName: "star.fill"), title: "Teams"),
                    .init(icon: Image(systemName: "star.fill"), title: "Stat")],
             geoWidth: 375,
             selectedTab: .constant(0))
    }
}
