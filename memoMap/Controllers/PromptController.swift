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
  @Published var currPrompt: String = ""

  init() {
    // get all prompts
    promptRepository.get({ (prompts) -> Void in
      self.prompts = prompts
      self.currPrompt = self.getRandomPrompt()
    })
  }

  func getRandomPrompt() -> String {
    let prompt = self.prompts.randomElement()!
    return String(prompt.description)
  }

}