//
//  ContentView.swift
//  TestTicTacToe
//
//  Created by Lou El Idrissi on 2/3/25.
//


// look into .wave

import SwiftUI
import SwiftUIPausableAnimation

struct ContentView: View {
    @State private var showButton = true // Controls button visibility
    
    @StateObject var audioPlayerViewModel = AudioPlayerViewModel()
    
    @StateObject var gameState = GameState()
    
    @State private var useRedColor = false
    @State private var hasUserClicked = false
    @State private var timeToChoose = false
    @State private var showMessage = ""
    
    @State private var angle = 0.0
    @State private var isPaused = true
    
    private let duration: TimeInterval = 60
    private let startAngle = 0.0
    private let endAngle = 3600.0
    private var remainingDuration: RemainingDurationProvider<Double> {
        { currentAngle in
            duration * (1 - (currentAngle - startAngle) / (endAngle - startAngle))
        }
    }
    private let animation: AnimationWithDurationProvider = { duration in
            .linear(duration: duration)
    }
    
    func deg2rad(_ number: CGFloat) -> CGFloat {
        return number * .pi / 180
    }
    
    func fillGrid(_ piece: Piece) {
        hasUserClicked = true
        if timeToChoose && hasUserClicked {
            isPaused = true
            showMessage = "That was fast, great job!"
            gameState.placeTile(piece.row, piece.column, piece.tile)
            gameState.pieces.removeAll { $0.row  == piece.row &&  $0.column == piece.column }
        }
        if !timeToChoose && hasUserClicked {
            showMessage = "Not yet!"
        }
    }
    
    func createMovingPiece(_ piece: Piece,_ boardSize: CGFloat) -> some View{
        
        let pieceSize = boardSize * 0.15 // Circle size is 15% of the board size
        let maxOffset = boardSize * 0.56 // Adjust offsets proportionally
        
        return ZStack { Image(systemName: "music.note")//Circle()
            //.fill(piece.color)
                .resizable()
                .scaledToFit()
                .frame(width: pieceSize, height: pieceSize)
                .foregroundColor(piece.color)
                .frame(width: pieceSize, height: pieceSize)
               
                .offset(x: cos(deg2rad(piece.angle)) * maxOffset,
                          y: sin(deg2rad(piece.angle)) * maxOffset)
                .pausableAnimation(binding: $angle,
                                   targetValue: endAngle,
                                   remainingDuration: remainingDuration,
                                   animation: animation,
                                   paused: $isPaused)
                .onTapGesture(count: 1) {
                    fillGrid(piece)
                }
                .padding(12)
        }.rotationEffect(.degrees(angle), anchor: .center)
    }
    
    func startGame() {
        if isPaused {
            hasUserClicked = false
            isPaused = false
            audioPlayerViewModel.playSound()
            showButton = false
            let randomNumber = Int.random(in: 3...5)
            print(randomNumber)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(randomNumber)) {
                audioPlayerViewModel.pauseSound()
                timeToChoose = true
                if timeToChoose {
                    showMessage = "Choose a spot now!"
                }
                // Start the 2-second countdown for the user to pick a circle
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    //timeToChoose = true
                    
                    if !hasUserClicked {
                        showMessage = "You haven't selected any piece!"
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        showButton = true
                        timeToChoose = false
                        showMessage = ""
                    }
                }
            }
        }
    }
    
    
    func showGoButton() -> some View {
        Button(action: startGame ){
            Text("Go!")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .padding()
                .frame(width: 200, height: 60)
                .background(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]), startPoint: .leading, endPoint: .trailing))
                .cornerRadius(30)
                .shadow(color: Color.purple.opacity(0.6), radius: 10, x: 0, y: 5)
                .overlay(
                    RoundedRectangle(cornerRadius: 30)
                        .stroke(Color.white.opacity(0.8), lineWidth: 2)
                )
                .scaleEffect(hasUserClicked ? 0.9 : 1.0)
                .animation(.easeInOut(duration: 0.2), value: hasUserClicked)
            
        }
        .buttonStyle(PlainButtonStyle())
    }
    
    func showMessageView() -> some View {
        Text(showMessage)
            .font(.system(size: 28, weight: .bold))
            .foregroundColor(.black)
            .padding()
            .transition(.opacity)
            .animation(.easeInOut, value: showMessage)
    }
    
    var body: some View {
        GeometryReader { geo in
            let boardSize = min(geo.size.width * 0.8, geo.size.height * 0.8)
            ZStack {
                VStack{
                    Spacer()
                    GameView(gameState: gameState)
                        .frame(width: boardSize * 0.75, height: boardSize * 0.75)
                    //                        .frame(width: min(geo.size.width, 500), height: min(geo.size.height, 500))
                    Spacer()
                }
                ZStack {
                    ForEach(gameState.pieces, id: \.self) { piece in
                        createMovingPiece(piece, boardSize)
                    }
                }
                .frame(width: boardSize * 1.2, height: boardSize * 1.2)
                
               
            }
            .frame(width: geo.size.width, height: geo.size.height)
            
            
            VStack{
                if showButton {
                    showGoButton()
                        .frame(maxWidth: .infinity)
                        .position(x: geo.size.width / 2, y: geo.size.height / 2)
                }
            }
            
            VStack{
                Spacer()
                if !showMessage.isEmpty {
                    showMessageView()
                    .background(Color.white.opacity(1))
                    .position(x: geo.size.width / 2, y: geo.size.height / 2)
                }
            }
            .frame(maxHeight: .infinity, alignment: .bottom)
            //.background(Color.white.opacity(0.3))
            
        }
    }
}

#Preview {
    ContentView()
}

