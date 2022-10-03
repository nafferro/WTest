//
//  ContentView.swift
//  WTest
//
//  Created by Nuno Ferro on 28/09/2022.
//

import SwiftUI

struct IntroView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject private var viewModel = IntroViewModel()

    var body: some View {
        VStack {
            ProgressView("A processar dados…")
        }
        .padding()
        .onAppear {
            viewModel.loadData()
        }
        .alert(isPresented:$viewModel.readyToDismiss) {
            Alert(title: Text("Dados Carregados"), message: Text("Dados Carregados com sucesso"), dismissButton: .default(Text("OK"), action: {
                self.presentationMode.wrappedValue.dismiss()
            }))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        IntroView()
    }
}
