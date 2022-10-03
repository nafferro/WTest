//
//  MainView.swift
//  WTest
//
//  Created by Nuno Ferro on 30/09/2022.
//

import SwiftUI
import Combine

struct MainView: View {
    
    @ObservedObject private var viewModel = MainViewModel()
    @State private var searchFilter = ""

    var body: some View {
        NavigationView {
            List {}
            .searchable(text: $searchFilter) {
                ForEach(LocalStorage().changeFilter(searchFilter)) { item in
                    MainViewCell(zipcode: item.zipcode, city: item.city)
                        .listRowSeparator(.hidden)
                }
            }
            .navigationTitle("Códigos Postal")
        }
        .fullScreenCover(isPresented: $viewModel.openSetup, content: IntroView.init)
    }
}
