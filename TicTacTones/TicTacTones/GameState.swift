//
//  GameState.swift
//  TicTacToe
//
//  Created by Lou El Idrissi on 1/27/25.
//

import Foundation

class GameState: ObservableObject {
    
    @Published var board = [[Cell]]()
    @Published var turn = Tile.Nought
    @Published var noughtsScore = 0
    @Published var crossesScore = 0
    @Published var showAlert = false
    @Published var alertMessage = "Draw"
    @Published var selectedTurn = Tile.Nought

    
    @Published var pieces: [Piece] = [
        Piece(angle: 20, row: 0, column: 0, color: .blue, tile: Tile.Cross),
        Piece(angle: 40, row: 0, column: 0, color: .red, tile: Tile.Nought),
        Piece(angle: 60, row: 0, column: 1, color: .blue, tile: Tile.Cross),
        Piece(angle: 80, row: 0, column: 1, color: .red, tile: Tile.Nought),
        Piece(angle: 100, row: 0, column: 2, color: .blue, tile: Tile.Cross),
        Piece(angle: 120, row: 0, column: 2, color: .red, tile: Tile.Nought),
        Piece(angle: 140, row: 1, column: 0, color: .blue, tile: Tile.Cross),
        Piece(angle: 160, row: 1, column: 0, color: .red, tile: Tile.Nought),
        Piece(angle: 180, row: 1, column: 1, color: .blue, tile: Tile.Cross),
        Piece(angle: 200, row: 1, column: 1, color: .red, tile: Tile.Nought),
        Piece(angle: 220, row: 1, column: 2, color: .blue, tile: Tile.Cross),
        Piece(angle: 240, row: 1, column: 2, color: .red, tile: Tile.Nought),
        Piece(angle: 260, row: 2, column: 0, color: .blue, tile: Tile.Cross),
        Piece(angle: 280, row: 2, column: 0, color: .red, tile: Tile.Nought),
        Piece(angle: 300, row: 2, column: 1, color: .blue, tile: Tile.Cross),
        Piece(angle: 320, row: 2, column: 1, color: .red, tile: Tile.Nought),
        Piece(angle: 340, row: 2, column: 2, color: .blue, tile: Tile.Cross),
        Piece(angle: 360, row: 2, column: 2, color: .red, tile: Tile.Nought)
    ]
    
    init()
    {
        resetBoard()
    }
    
    func turnText() -> String
    {
        return turn == Tile.Cross ? "Turn: X" : "Turn: O"
    }
    
    func placeTile(_ row: Int,_ column: Int, _ selectedTurn: Tile)
    {
        if (board[row][column].tile != Tile.Empty) { return }
        
        print("tileplace", board[row][column].tile)
        board[row][column].tile = selectedTurn //== Tile.Cross ? Tile.Cross : Tile.Nought
        
        
        if(checkForVictory())
        {
            if(turn == Tile.Cross)
            {
                crossesScore += 1
            }
            else
            {
                noughtsScore += 1
            }
            let winner = turn == Tile.Cross ? "Crosses" : "Noughts"
            alertMessage = winner + " Win!"
            showAlert = true
        }
        else
        {
            turn = turn == Tile.Cross ? Tile.Nought : Tile.Cross
        }
        
        if(checkForDraw())
        {
            alertMessage = "Draw"
            showAlert = true
        }
    }
    
    func checkForDraw() -> Bool
    {
        for row in board
        {
            for cell in row
            {
                if cell.tile == Tile.Empty
                {
                    return false
                }
            }
        }
        
        return true
    }
    
    func checkForVictory() -> Bool
    {
        // vertical victory
        if isTurnTile(0, 0) && isTurnTile(1, 0) && isTurnTile(2, 0)
        {
            return true
        }
        if isTurnTile(0, 1) && isTurnTile(1, 1) && isTurnTile(2, 1)
        {
            return true
        }
        if isTurnTile(0, 2) && isTurnTile(1, 2) && isTurnTile(2, 2)
        {
            return true
        }
        
        // horizontal victory
        if isTurnTile(0, 0) && isTurnTile(0, 1) && isTurnTile(0, 2)
        {
            return true
        }
        if isTurnTile(1, 0) && isTurnTile(1, 1) && isTurnTile(1, 2)
        {
            return true
        }
        if isTurnTile(2, 0) && isTurnTile(2, 1) && isTurnTile(2, 2)
        {
            return true
        }
        
        // diagonal victory
        if isTurnTile(0, 0) && isTurnTile(1, 1) && isTurnTile(2, 2)
        {
            return true
        }
        if isTurnTile(0, 2) && isTurnTile(1, 1) && isTurnTile(2, 0)
        {
            return true
        }
        
        
        return false
    }
    
    func isTurnTile(_ row: Int,_ column: Int) -> Bool
    {
        return board[row][column].tile == turn
    }
    
    func resetBoard()
    {
        var newBoard = [[Cell]]()
        
        for _ in 0...2
        {
            var row = [Cell]()
            for _ in 0...2
            {
                row.append(Cell(tile: Tile.Empty))
            }
            newBoard.append(row)
        }
        board = newBoard
    }
    
    
}
