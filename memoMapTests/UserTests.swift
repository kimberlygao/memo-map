//
//  UserTests.swift
//  memoMapTests
//
//  Created by Chloe Chan on 12/7/22.
//

import XCTest
@testable import memoMap

final class UserTests: XCTestCase {

  func test_userController() async {
    let userController = await UserController()
//    let curr = await userController.currentUser
    XCTAssertEqual(userController.currentUser.pfp, "default.jpeg")
    XCTAssertEqual(userController.currentUser.name, "kimberly")
    XCTAssertEqual(userController.currentUser.password, "pwkimmi")
    
  }

}
