import SwiftUI
import Combine

struct GameModel {
    enum Player: String {
        case x = "X"
        case o = "O"
        
        var next: Player {
            self == .x ? .o : .x
        }
        
        var color: Color {
            self == .x ? .blue : .red
        }
    }
    
    struct GameState {
        var board: [String] = Array(repeating: "", count: 9)
        var currentPlayer: Player = .x
        var winningCombination: [Int] = []
        var isGameOver: Bool = false
        var resultMessage: String = ""
    }
    
    static let winPatterns: [[Int]] = [
        [0, 1, 2], [3, 4, 5], [6, 7, 8], // rows
        [0, 3, 6], [1, 4, 7], [2, 5, 8], // columns
        [0, 4, 8], [2, 4, 6]             // diagonals
    ]
}
