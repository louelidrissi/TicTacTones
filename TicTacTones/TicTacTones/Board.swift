//
//  Board.swift
//  TicTacToe
//
//  Created by Lou El Idrissi on 1/28/25.
//
import SwiftUI

struct GameView: View  {
    
@StateObject var gameState = GameState()
    let borderSize = CGFloat(1)

var body: some View
{
    /*
        Text(gameState.turnText())
            .font(.title)
            .bold()
            .padding()
        Spacer()
        
  
    
        Text(String(format: "Crosses: %d", gameState.crossesScore))
            .font(.title)
            .bold()
            .padding()
     */
        
        VStack(spacing: borderSize)
        {
            ForEach(0...2, id: \.self)
            {
                row in HStack(spacing: borderSize)
                {
                    ForEach(0...2, id: \.self)
                    {
                        column in
                        
                        let cell = gameState.board[row][column]
                        
                        Text(cell.displayTile())
                            .font(.system(size: 55))
                            .foregroundColor(cell.tileColor())
                            .bold()
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .aspectRatio(1, contentMode: .fit)
                            .background(Color.white)
                            .overlay( /// Add this line for borders
                                    Rectangle()
                                        .stroke(Color.black, lineWidth: 5)) // 5-pixel black border
                            //.onTapGesture {
                              //  gameState.placeTile(row, column)
                            //}
                    }
                }
                
            }
        }
        .background(Color.black)
        .padding()
        .alert(isPresented: $gameState.showAlert)
        {
            Alert(
                title: Text(gameState.alertMessage),
                dismissButton: .default(Text("Okay"))
                {
                    gameState.resetBoard()
                }
            )
        }
     
        
        /*Text(String(format: "Noughts: %d", gameState.noughtsScore))
            .font(.title)
            .bold()
            .padding()
        Spacer()
         */
    }
     
}


