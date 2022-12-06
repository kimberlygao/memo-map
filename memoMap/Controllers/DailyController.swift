//
//  DailyController.swift
//  memoMap
//
//  Created by Chloe Chan on 12/1/22.
//
import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

class DailyPromptController: ObservableObject {
  @Published var dailyRepository: DailyPromptRepository = DailyPromptRepository()
  @Published var memoryController: MemoryController = MemoryController()
  @Published var dailys: [DailyPrompt] = []

  init() {
    // get all daily prompt answers
    self.dailys = dailyRepository.dailys
  }

  func selectAnswer(user: User, memory: Memory) {
    let ans = DailyPrompt(id: user.id!, memory: memory.id!)
    dailyRepository.update(ans)
  }

}
