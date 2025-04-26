
import Combine

class GameViewModel: ObservableObject {
    @Published private(set) var gameState = GameModel.GameState()
    
    func makeMove(at index: Int) {

        guard gameState.board[index].isEmpty && !gameState.isGameOver else {
            return
        }
        

        gameState.board[index] = gameState.currentPlayer.rawValue
        

        if checkForWin() {
            gameState.isGameOver = true
            gameState.resultMessage = "Player \(gameState.currentPlayer.rawValue) wins!"
            return
        }
        

        if checkForDraw() {
            gameState.isGameOver = true
            gameState.resultMessage = "It's a draw!"
            return
        }
        

        gameState.currentPlayer = gameState.currentPlayer.next
    }
    
    func resetGame() {
        gameState = GameModel.GameState()
    }
    
    private func checkForWin() -> Bool {
        for pattern in GameModel.winPatterns {
            if gameState.board[pattern[0]] != "" &&
               gameState.board[pattern[0]] == gameState.board[pattern[1]] &&
               gameState.board[pattern[1]] == gameState.board[pattern[2]] {
                gameState.winningCombination = pattern
                return true
            }
        }
        return false
    }
    
    private func checkForDraw() -> Bool {
        return !gameState.board.contains("")
    }
}
