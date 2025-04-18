//
//  Cell.swift
//  TicTacToe
//
//  Created by Lou El Idrissi on 1/27/25.
//

import Foundation
import SwiftUI

struct Cell
{
    var tile: Tile
    
    func displayTile() -> String
    {
        switch(tile)
        {
            case Tile.Nought:
                    return "O"
            case Tile.Cross:
                return "X"
            default:
                return ""
        }
    }
    
    func tileColor() -> Color
    {
        switch(tile)
        {
            case Tile.Nought:
                return Color.purple
            case Tile.Cross:
                return Color.black
            default:
                return Color.black
        }
    }
}

enum Tile
{
    case Nought
    case Cross
    case Empty
}

