import SwiftUI


struct ContentView: View {
    @StateObject private var viewModel = GameViewModel()
    
    var body: some View {
        VStack(spacing: 20) {
            HeaderView(currentPlayer: viewModel.gameState.currentPlayer.rawValue,
                      isGameOver: viewModel.gameState.isGameOver)
            
            BoardView(board: viewModel.gameState.board,
                     winningCombination: viewModel.gameState.winningCombination,
                     onCellTap: viewModel.makeMove)
            
            if viewModel.gameState.isGameOver {
                ResultView(message: viewModel.gameState.resultMessage,
                          isWin: !viewModel.gameState.winningCombination.isEmpty)
            }
            
            RestartButton(action: viewModel.resetGame)
        }
        .padding()
        .animation(.spring(), value: viewModel.gameState.isGameOver)
        .animation(.spring(), value: viewModel.gameState.winningCombination)
    }
}

struct HeaderView: View {
    let currentPlayer: String
    let isGameOver: Bool
    
    var body: some View {
        VStack {
            Text("Tic-Tac-Toe")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()
            
            Text("Current Player: \(currentPlayer)")
                .font(.title2)
                .fontWeight(.semibold)
                .padding(.bottom)
                .opacity(isGameOver ? 0 : 1)
        }
    }
}

struct BoardView: View {
    let board: [String]
    let winningCombination: [Int]
    let onCellTap: (Int) -> Void
    
    var body: some View {
        VStack(spacing: 5) {
            ForEach(0..<3) { row in
                HStack(spacing: 5) {
                    ForEach(0..<3) { col in
                        let index = row * 3 + col
                        CellView(value: board[index],
                                isWinningCell: winningCombination.contains(index))
                            .onTapGesture {
                                onCellTap(index)
                            }
                    }
                }
            }
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(10)
    }
}

struct CellView: View {
    let value: String
    let isWinningCell: Bool
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .fill(isWinningCell ? Color.green.opacity(0.3) : Color.white)
                .shadow(color: isWinningCell ? .green : .gray.opacity(0.4), radius: isWinningCell ? 3 : 1)
                .frame(width: 80, height: 80)
            
            Text(value)
                .font(.system(size: 50, weight: .bold))
                .foregroundColor(value == "X" ? .blue : .red)
                .scaleEffect(value.isEmpty ? 0.1 : 1.0)
                .animation(.spring(), value: value)
        }
    }
}

struct ResultView: View {
    let message: String
    let isWin: Bool
    
    var body: some View {
        Text(message)
            .font(.title)
            .fontWeight(.bold)
            .foregroundColor(isWin ? .green : .orange)
            .padding()
            .transition(.scale)
    }
}

struct RestartButton: View {
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text("Restart Game")
                .font(.title3)
                .fontWeight(.medium)
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
