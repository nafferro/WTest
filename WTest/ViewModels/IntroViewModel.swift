//
//  ContentViewModel.swift
//  WTest
//
//  Created by Nuno Ferro on 28/09/2022.
//

import Foundation
import Combine
class IntroViewModel: ObservableObject {
   
    @Published var readyToDismiss: Bool = false

    var dataService = DataService()
    private lazy var cancellables: Set<AnyCancellable> = []
    
    init() {
        dataService.processingDataState
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [self] result in
                UserDefaults.standard.set(true, forKey: "databaseLoaded")
                print("processsed")
                readyToDismiss = true
            }, receiveValue: { _ in
            })
            .store(in: &cancellables)
        
    }
    func loadData() {
      //  DispatchQueue.main.async {
            self.dataService.setup()
       // }
    }
}
