//
//  MainViewModel.swift
//  WTest
//
//  Created by Nuno Ferro on 30/09/2022.
//

import Foundation

class MainViewModel: ObservableObject {
    
    @Published var openSetup: Bool = false
    
    init() {
        if !UserDefaults.standard.bool(forKey: "fileLoaded") || !UserDefaults.standard.bool(forKey: "databaseLoaded") {
            self.openSetup = true
        }
    }
}
