//
//  Prompt.swift
//  memoMap
//
//  Created by Chloe Chan on 11/4/22.
//

import Foundation
import FirebaseFirestoreSwift

struct Prompt: Identifiable, Codable {
  
  // MARK: Fields
  @DocumentID var id: String?
  var description: String
  
  // MARK: Codable
  enum CodingKeys: String, CodingKey {
    case id
    case description
  }
}
