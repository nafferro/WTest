//
//  ContentView.swift
//  WTest
//
//  Created by Nuno Ferro on 28/09/2022.
//

import SwiftUI

struct IntroView: View {    
    @ObservedObject private var viewModel = IntroViewModel()

    var body: some View {
        VStack {
            viewModel.processingDataState ? ProgressView("A processar dados…") : ProgressView("A carregar ficheiro...")
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        IntroView()
    }
}
