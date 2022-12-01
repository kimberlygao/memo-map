//
//  PromptController.swift
//  memoMap
//
//  Created by Chloe Chan on 12/1/22.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

class PromptController: ObservableObject {
  @Published var promptRepository: PromptRepository = PromptRepository()
  @Published var prompts: [Prompt] = []
  
  init() {
    // get all prompts
    self.prompts = promptRepository.prompts
  }
  
  func getRandomPrompt() -> String {
    let prompt = self.prompts.randomElement()!
    return String(prompt.description)
  }

}
