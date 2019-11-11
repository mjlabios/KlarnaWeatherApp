//
//  TemperatureView.swift
//  KlarnaWeatherApp
//
//  Created by Mark Labios on 11/11/19.
//  Copyright © 2019 Mark Labios. All rights reserved.
//

import SwiftUI

struct TemperatureView: View {
    var temperature: Int = 0
    
    var body: some View {
        ZStack{
            Circle()
                .overlay(Circle().stroke(Color.white,lineWidth: 4))
                .frame(width:100,height:100)
            Text("\(temperature)°F")
                .font(Font.custom("Helvetica-Neue",size: 30))
                .foregroundColor(.white)
                .padding(.leading,10)
        }.edgesIgnoringSafeArea(.all)
  
    }
    
    init(temp: Int) {
        self.temperature = temp
    }
}


struct Temp_Previews: PreviewProvider {
    static var previews: some View {
        TemperatureView(temp: 21).previewLayout(.sizeThatFits)
    }
}
