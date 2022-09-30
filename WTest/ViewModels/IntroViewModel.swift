//
//  ContentViewModel.swift
//  WTest
//
//  Created by Nuno Ferro on 28/09/2022.
//

import Foundation
import Combine

class IntroViewModel: ObservableObject {
    
    var dataService = DataService()
    private lazy var cancellables: Set<AnyCancellable> = []
    
    @Published var processingDataState: Bool = false
    @Published var setupCompleted: Bool = false
    
    init() {
        dataService.processingDataState
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [self] result in
                self.setupCompleted = true
                print("processsed")
            }, receiveValue: { value in
                self.processingDataState = value
            })
            .store(in: &cancellables)
        
        dataService.setup()
    }
}
