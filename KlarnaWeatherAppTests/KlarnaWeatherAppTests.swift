//
//  KlarnaWeatherAppTests.swift
//  KlarnaWeatherAppTests
//
//  Created by Mark Labios on 11/11/19.
//  Copyright © 2019 Mark Labios. All rights reserved.
//

import XCTest
@testable import KlarnaWeatherApp


class KlarnaWeatherAppTests: XCTestCase {
    
    func testUserLocation() {
        let userLocation = UserLocation()
        let locationTest = UserLocationDelegateTest()
        
        userLocation.delegate = locationTest
        userLocation.startUpdating()
        
        let exp = expectation(description: "locationTest calls the delegate as the result of an async method completion")
        locationTest.asyncExpectation = exp
        
        waitForExpectations(timeout: 5) {
            error in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error). Waited too long.")
            }
            
            guard let _ = locationTest.delegateAsyncLatitude else {
                XCTFail("Expected latitude is nil")
                return
            }
            
            guard let _ = locationTest.delegateAsyncLongitude else {
                XCTFail("Expected longitude is nil")
                return
            }
            
            // Latitude and Longitude not nil
            XCTAssertTrue(true)
        }
    }

    func testDataFetched() {
        let weatherManager = WeatherManager()
        let delegateTest = WeatherDelegateTest()
        
        weatherManager.delegate = delegateTest
        weatherManager.fetchWeather()

        let exp = expectation(description: "delegateTest calls the delegate as the result of an async method completion")
        delegateTest.asyncExpectation = exp

       
        waitForExpectations(timeout: 5) { error in
          if let error = error {
            XCTFail("waitForExpectationsWithTimeout errored: \(error). Waited too long.")
          }

          guard let result = delegateTest.delegateAsyncResult else {
            XCTFail("Expected delegate to be called")
            return
          }

            XCTAssertTrue(result && weatherManager.weatherModel.objectID != "init")
        }
       
    }
    
}



//MARK: Delegate Test Classes
class WeatherDelegateTest: WeatherDelegate {
    
    var delegateAsyncResult: Bool?
    
    var asyncExpectation: XCTestExpectation?
    
    func weatherDidChange() {
        guard let expectation = asyncExpectation else {
             XCTFail("Delegate was not setup correctly. Missing XCTExpectation reference")
             return
           }

           delegateAsyncResult = true
           expectation.fulfill()
    }
}

class UserLocationDelegateTest: UserLocationDelegate {
 
    var delegateAsyncLongitude: Double?
    var delegateAsyncLatitude: Double?
    
    var asyncExpectation: XCTestExpectation?
    
    func onUserLocationUpdate(latitude: Double, longitude: Double) {
        guard let expection = asyncExpectation else {
            XCTFail("Delegate was not setup correctly. Missing XCTExpectation reference")
            return
        }
        
        delegateAsyncLatitude = latitude
        delegateAsyncLongitude = longitude
        expection.fulfill()
        
     }
    
    
}
