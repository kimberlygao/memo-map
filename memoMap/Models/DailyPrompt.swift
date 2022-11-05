//
//  DailyPrompt.swift
//  memoMap
//
//  Created by Chloe Chan on 11/4/22.
//

import Foundation
import FirebaseFirestoreSwift

struct DailyPrompt: Identifiable, Codable {
  
  // MARK: Fields
  @DocumentID var id: String?
  var memory: [Memory]
  
  // MARK: Codable
  enum CodingKeys: String, CodingKey {
    case id = "username"
    case memory
  }
}
