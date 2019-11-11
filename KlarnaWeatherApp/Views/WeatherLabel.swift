//
//  WeatherLabel.swift
//  KlarnaWeatherApp
//
//  Created by Mark Labios on 11/11/19.
//  Copyright © 2019 Mark Labios. All rights reserved.
//

import SwiftUI

struct WeatherLabel: View {
    var text: String
    
    var body: some View {
        withAnimation {
        Text("\(text)")
            .font(Font.custom("Helvetica-Neue",size: 35))
            .foregroundColor(.white)
            .fixedSize()
        .edgesIgnoringSafeArea(.all)
        }
    }
    
    init(_ text: String) {
        self.text = text
    }
}

struct WeatherLabel_Previews: PreviewProvider {
    static var previews: some View {
        WeatherLabel("Cloudy").previewLayout(.sizeThatFits)
    }
}
