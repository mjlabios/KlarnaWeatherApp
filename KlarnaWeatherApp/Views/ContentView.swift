//
//  ContentView.swift
//  KlarnaWeatherApp
//
//  Created by Mark Labios on 11/11/19.
//  Copyright © 2019 Mark Labios. All rights reserved.
//

import SwiftUI

struct ContentView: View, WeatherDelegate {
    @ObservedObject var weatherManager = WeatherManager()
    @State var progress: Int = 0
  
    var body: some View {
        ZStack {
            Color(.systemTeal).edgesIgnoringSafeArea(.all)
            VStack(){
                WeatherLabel("\(weatherManager.weatherModel.timezone)")
                Divider()
                TemperatureView(temp: self.progress)
                Divider()
                WeatherLabel("\(weatherManager.weatherModel.summary)")
                Divider()
            }
            } .onAppear {
                self.weatherManager.delegate = self
                self.weatherManager.fetchWeather()
            }
    }
    
    func weatherDidChange() {
        self.progress = 0
        Timer.scheduledTimer(withTimeInterval: 0.03, repeats: true) {
            timer in
            
            self.progress += 1
    
            if (self.progress >= self.weatherManager.weatherModel.temperature) {
                timer.invalidate()
            }
        }
    }
}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
