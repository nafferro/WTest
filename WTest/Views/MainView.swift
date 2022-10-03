//
//  MainView.swift
//  WTest
//
//  Created by Nuno Ferro on 30/09/2022.
//

import SwiftUI
import RealmSwift

struct MainView: View {
    
    @ObservedObject private var viewModel = MainViewModel()
    @State private var searchFilter = ""

    @ObservedResults(
      ZipcodeModel.self
    ) var zipcodes
    
    var body: some View {
        NavigationView {
            List {}
            .searchable(text: $searchFilter) {
                ForEach(searchResults, id: \.self) { item in
                    MainViewCell(zipcode: item.zipcode, city: item.city)
                        .listRowSeparator(.hidden)
                }
            }
            .navigationTitle("Códigos Postal")
        }
        .fullScreenCover(isPresented: $viewModel.openSetup, content: IntroView.init)
    }
        
    var searchResults: Results<ZipcodeModel> {
        if searchFilter.count > 3 {
            return zipcodes.filter((NSPredicate(format: "city CONTAINS[cd] %@ OR zipcode CONTAINS %@", searchFilter, searchFilter)))
        } else {
            return zipcodes.filter((NSPredicate(format: "city == %@", "")))
        }
    }
}
