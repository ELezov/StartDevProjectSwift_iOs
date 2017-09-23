

import XCTest

@testable import TestApp

class TestAppTests: XCTestCase {
    
    //MARK : Meal class testable

    func testMealInitializationSucceeds(){
        let zeroRatingMeal = Meal.init(name: "Zero", photo: nil, rating: 0)
        XCTAssertNotNil(zeroRatingMeal)
        let positiveRatingMeal = Meal.init(name: "Positive",photo: nil, rating: 5)
        XCTAssertNotNil(positiveRatingMeal)
    }

    func testMealInitializationFails(){
        let negativeRatingMeal = Meal.init(name: "Negative", photo: nil, rating: -1)
        XCTAssertNil(negativeRatingMeal)

        let largeRatingMeal = Meal.init(name: "Large", photo: nil, rating: 6)
        XCTAssertNil(largeRatingMeal)

        let emtyStringMeal = Meal.init(name: "", photo: nil, rating: 0)
        XCTAssertNil(emtyStringMeal)
    }

}
