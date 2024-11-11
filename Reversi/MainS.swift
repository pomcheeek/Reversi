//
//  MainS.swift
//  Reversi
//
//  Created by Рома Николаев on 07.11.2024.
//

import SwiftUI

struct MainS: View {
    
    @StateObject private var viewModel = GameViewModel()
        
        private let columns = Array(repeating: GridItem(.flexible()), count: 8)
        
        var body: some View {
            VStack {
                
                let message = viewModel.alert()
                Text("\(message)\n\(viewModel.blackCount):\(viewModel.whiteCount)")
                    .font(.title)
                    .multilineTextAlignment(.center)
                    .padding()
                
                LazyVGrid(columns: columns, spacing: 5) {
                    ForEach(0..<64, id: \.self) { index in
                        ZStack {
                            Rectangle()
                                .fill(Color.brown)
                                .frame(width: 40, height: 40)
                                .border(Color.black)
                            
                            if let move = viewModel.getPiece(index: index) {
                                Circle()
                                    .fill(move.player == .black ? Color.black : Color.white)
                                    .frame(width: 30, height: 30)
                            } else if viewModel.possibleMoves.contains(index) {
                                Rectangle()
                                    .fill(Color.green.opacity(0.4))
                                    .frame(width: 30, height: 30)
                            }
                        }
                        .onTapGesture {
                            viewModel.placePiece(index: index)
                        }
                    }
                }
                .padding()
                
                Button("Перезапустить игру") {
                    viewModel.resetGame()
                }
                .padding()
            }
            .padding()
        }
}

#Preview {
    MainS()
}
