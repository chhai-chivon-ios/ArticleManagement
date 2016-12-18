//
//  ArticleManagementTests.swift
//  ArticleManagementTests
//
//  Created by sophatvathana on 9/12/16.
//  Copyright © 2016 sophatvathana. All rights reserved.
//

import XCTest
@testable import ArticleManagement

class ArticleManagementTests: XCTestCase {
    var userService:UserService? = nil
    override func setUp() {
        super.setUp()
       userService = UserService()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testGetUsers() {
        XCTAssert(true, "Should be true")
        userService?.getUsers(callBack: {
            user in
            XCTAssertNotNil(user, "User is not nil")
            for us in user{
                print(us.email)
                XCTAssert(us.email == "sovathana.phat@gmail.com", "Should be can retrieve")
            }
        })
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
