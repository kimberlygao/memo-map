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
  @Published var dailys: [DailyPrompt] = []
  @Published var blurredPrompt = true

  init() {
    // get all daily prompt answers
    dailyRepository.get({ (dailys) -> Void in
      self.dailys = dailys
    })
  }

  func selectAnswer(user: User, memory: Memory) {
    let ans = DailyPrompt(id: user.id!, memory: memory.memid)
    dailyRepository.update(ans)
  
    
  }

}
