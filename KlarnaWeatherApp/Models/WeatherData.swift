//
//  WeatherData.swift
//  KlarnaWeatherApp
//
//  Created by Mark Labios on 11/11/19.
//  Copyright © 2019 Mark Labios. All rights reserved.
//

struct WeatherData: Codable {
    let currently: Currently
    let timezone: String
}

struct Currently: Codable {
    let summary: String
    let temperature: Double
    
}

