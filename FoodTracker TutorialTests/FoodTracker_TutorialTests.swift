//
//  FoodTracker_TutorialTests.swift
//  FoodTracker TutorialTests
//
//  Created by Geoffrey Caven on 2017-02-24.
//  Copyright © 2017 Geoffrey Caven. All rights reserved.
//

import XCTest
@testable import FoodTracker_Tutorial

class FoodTracker_TutorialTests: XCTestCase {
  
  //MARK: Meal Class Tests
  
  // Confirm that the Meal initializer returns a Meal object when passed valid parameters.
  func testMealInitializationSucceeds() {
    // Zero rating
    let zeroRatingMeal = Meal.init(name: "Zero", photo: nil, rating: 0)
    XCTAssertNotNil(zeroRatingMeal)
    
    // Highest positive rating
    let positiveRatingMeal = Meal.init(name: "Positive", photo: nil, rating: 5)
    XCTAssertNotNil(positiveRatingMeal)
  }
  
  // Confirm that the Meal initialier returns nil when passed a negative rating or an empty name.
  func testMealInitializationFails() {
    // Negative rating
    let negativeRatingMeal = Meal.init(name: "Negative", photo: nil, rating: -1)
    XCTAssertNil(negativeRatingMeal)
    
    // Rating exceeds maximum
    let largeRatingMeal = Meal.init(name: "Large", photo: nil, rating: 6)
    XCTAssertNil(largeRatingMeal)
    
    // Empty String
    let emptyStringMeal = Meal.init(name: "", photo: nil, rating: 0)
    XCTAssertNil(emptyStringMeal)
  }
  
    
}
