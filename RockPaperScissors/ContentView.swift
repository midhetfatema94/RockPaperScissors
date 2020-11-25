//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Waveline Media on 11/25/20.
//

import SwiftUI

struct ContentView: View {
    
    @State private var allMoves = ["Rock", "Paper", "Scissors"]
    @State private var currentMove = "Rock"
    @State private var totalMatches = 0
    @State private var playerScore = 0
    @State private var computerScore = 0
    @State private var showingScore = false
    @State private var currentMoveIndex = Int.random(in: 0...2)
    
    var body: some View {
        VStack(spacing: 30) {
            HStack() {
                Text("Computer's Move is: ")
                Image(currentMove.lowercased())
                    .gameImageStyle()
            }
            Text("Player, What is your move?")
            HStack() {
                ForEach(0 ..< allMoves.count) {eachMoveIndex in
                    let playerMove = allMoves[eachMoveIndex]
                    Button(action: {
                        //Declare result for this match and update total score
                        if hasPlayerWon(computerMove: currentMoveIndex, playerMove: eachMoveIndex) {
                            playerScore += 1
                        } else {
                            computerScore += 1
                        }
                        totalMatches += 1
                        if totalMatches == 10 {
                            showingScore = true
                        }
                    }, label: {
                        Image(playerMove.lowercased())
                            .gameImageStyle()
                    })
                }
            }
            Text("Player Score: \(playerScore)")
            Button(action: {
                //Next move from the computer
                currentMoveIndex = Int.random(in: 0 ..< allMoves.count)
                currentMove = allMoves[currentMoveIndex]
            }, label: {
                Text("Present Next Move")
            })
            .alert(isPresented: $showingScore) {
                Alert(title: Text("WINNER DECLARED"), message: Text("The winner is: \(playerScore > computerScore ? "Player" : "Computer")"), dismissButton: .default(Text("Continue")) {
                    totalMatches = 0
                    playerScore = 0
                    computerScore = 0
                })
            }
        }
    }
    
    func hasPlayerWon(computerMove: Int, playerMove: Int) -> Bool {
        var move = computerMove
        if computerMove == 2 { move = -1 }
        if move + 1 == playerMove {
            return true
        }
        return false
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension Image {
    func gameImageStyle() -> some View {
        self
            .resizable()
            .frame(width: 60, height: 60)
   }
}
