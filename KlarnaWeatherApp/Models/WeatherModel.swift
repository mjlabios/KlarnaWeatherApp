//
//  WeatherModel.swift
//  KlarnaWeatherApp
//
//  Created by Mark Labios on 11/11/19.
//  Copyright © 2019 Mark Labios. All rights reserved.
//

struct WeatherModel: Decodable, Identifiable {
    var id: String {
        return objectID
    }
    
    let objectID: String
    
    let temperature: Int
    let summary: String
    let timezone: String
}
