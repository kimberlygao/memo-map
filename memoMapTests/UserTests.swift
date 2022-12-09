////
////  UserTests.swift
////  memoMapTests
////
////  Created by Chloe Chan on 12/7/22.
////
//
//import XCTest
//@testable import memoMap
//
//import Combine
//import FirebaseFirestore
//import FirebaseFirestoreSwift
//import FirebaseCore
//
//
//final class UserTests: XCTestCase {
//
//  let expired: TimeInterval = 10
//  var expectation: XCTestExpectation!
//
//
//  override func setUp() {
//    expectation = expectation(description: "Able to parse the repo data received")
//  }
//
//  let userController = UserController()
//
//  //  let user1 = User(email: "email1", friends: ["user2", "user3"], memories: ["1a", "1b"], name: "name1", password: "pw1", requests: [], pfp: "pfp1", id: "user1")
//  //  let user2 = User(email: "email2", friends: ["user1"], memories: ["2a"], name: "name2", password: "pw2", requests: ["user3"], pfp: "pfp2", id: "user2")
//  //  let user3 = User(email: "email3", friends: ["user1"], memories: ["3a"], name: "name3", password: "pw3", requests: ["user2"], pfp: "pfp3", id: "user3")
//
//  func test_init() {
//    let path: String = "users"
//    let store = Firestore.firestore()
//    let userController = UserController()
//
//    defer { waitForExpectations(timeout: expired) }
//
//    store.collection(path)
//      .addSnapshotListener { querySnapshot, error in
//        //        if let error = error {
//        //          print("Error getting place: \(error.localizedDescription)")
//        //          return
//        //        }
//
//        XCTAssertEqual(userController.currentUser.pfp, "default.jpeg")
//        XCTAssertEqual(userController.currentUser.name, "kimberly")
//        XCTAssertEqual(userController.currentUser.password, "pwkimmi")
//
//        self.expectation.fulfill()
//      }
//
//
//  }
//
//  //  func test_getFriends() {
//  //    let friends = userController.getFriends(user: user1)
//  //    XCTAssertEqual(friends, [user2, user3])
//  //
//  //  }
//
//}
