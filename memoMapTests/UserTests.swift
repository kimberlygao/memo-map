//
//  UserTests.swift
//  memoMapTests
//
//  Created by Chloe Chan on 12/7/22.
//

import XCTest
@testable import memoMap

final class UserTests: XCTestCase {
  
  let userController = UserController()
  
  let user1 = User(email: "email1", friends: ["user2", "user3"], memories: ["1a", "1b"], name: "name1", password: "pw1", requests: [], pfp: "pfp1")
  let user2 = User(email: "email2", friends: ["user1"], memories: ["2a"], name: "name2", password: "pw2", requests: ["user3"], pfp: "pfp2")
  let user3 = User(email: "email3", friends: ["user1"], memories: ["3a"], name: "name3", password: "pw3", requests: ["user2"], pfp: "pfp3")
  
  func test_getFriends() {
    let friends = userController.getFriends(user: user1)
    XCTAssertEqual(friends, [user2, user3])
    
  }

}
