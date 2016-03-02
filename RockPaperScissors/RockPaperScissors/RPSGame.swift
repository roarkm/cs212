//
//  RPSGame.swift
//  RockPaperScissors
//
//  Created by m on 3/1/16.
//  Copyright © 2016 mr. All rights reserved.
//

import Foundation

enum GameResult : String {
  case UserWon = "You Win!"
  case ComputerWon = "You lose!"
  case Draw = "Draw!"
}

enum GameMove : Int {
  case Rock     = 1
  case Paper    = 2
  case Scissors = 3
  func description() -> String {
    switch self {
      case .Rock:
        return "Rock"
      case .Paper:
        return "Paper"
      case .Scissors:
        return "Scissors"
    }
  }
}

class RPSGame: NSObject {
  
  var userMove:GameMove?
  var computerMove:GameMove?
  
  func playComputerMove() {
    computerMove = GameMove(rawValue:Int(arc4random_uniform(3) + 1))
  }
  
  func outcomeDescription() -> String {
    if let userMoveDescription = userMove?.description() {
      if let computerMoveDescription = computerMove?.description() {
        return "\(userMoveDescription) vs \(computerMoveDescription) - \(gameResult().rawValue)"
      }
      return "Computer Hasn't moved yet!"
    }
    return "User Hasn't moved yet!"
  }
  
  func gameResult() -> GameResult {
    if userMove == computerMove {
      return .Draw
    }
    if (userMove == .Rock && computerMove == .Scissors) || (userMove == .Paper && computerMove == .Rock) || (userMove == .Scissors && computerMove == .Paper) {
        return .UserWon
    }
    return .ComputerWon
  }
  
}