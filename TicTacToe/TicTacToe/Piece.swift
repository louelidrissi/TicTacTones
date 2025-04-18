//
//  Untitled.swift
//  TicTacToe
//
//  Created by Lou El Idrissi on 2/19/25.
//

import SwiftUI

struct Piece : Hashable{
    
    var angle: CGFloat
    var row: Int
    var column: Int
    var color: Color
    var tile: Tile
}
