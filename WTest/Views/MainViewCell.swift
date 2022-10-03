//
//  MainViewCell.swift
//  WTest
//
//  Created by Nuno Ferro on 30/09/2022.
//

import SwiftUI

struct MainViewCell: View {
    
    @State var zipcode: String = ""

    @State var city: String = ""
    
    var body: some View {
        HStack(alignment: .center, spacing: 0) {
            Text(zipcode)
                .bold()
            Text(city)
                .padding()
        }
    }
}

struct MainViewCell_Previews: PreviewProvider {
    static var previews: some View {
        MainViewCell(zipcode: "1500-000", city: "Lisboa")
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
