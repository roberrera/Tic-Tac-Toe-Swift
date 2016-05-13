//
//  ViewController.swift
//  Tic-Tac-Toe
//
//  Created by Robert M. Errera on 11/7/15.
//  Copyright © 2015 Robert M. Errera. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // 1 = o's; 2 = x's
    var activePlayer = 1
    // This is the current game's spaces to be checked against the arrays of winning combinations.
    var gameState = [0, 0, 0, 0, 0, 0, 0, 0, 0]
    let winningCombination = [[0,1,2], [3,4,5], [6,7,8], [0,4,8], [2,4,6], [0,3,6], [1,4,7], [2,5,8]]
    var gameActive = true
    
    @IBOutlet weak var gameOverLabel: UILabel!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var playAgain: UIButton!
    
    @IBAction func playAgainButton(sender: AnyObject) {
        // If the game is active, hide the "Game over" label and "play again" button.
        gameState = [0, 0, 0, 0, 0, 0, 0, 0, 0]
        gameActive = true
        gameOverLabel.hidden = true
        gameOverLabel.center = CGPointMake(gameOverLabel.center.x - 500, gameOverLabel.center.y)
        
        playAgain.hidden = true
        playAgain.center = CGPointMake(playAgain.center.x - 500, playAgain.center.y)
        
        var buttonToClear : UIButton
        
        // This is the new way to write For loops in Swift, as it is moving away from the C-based syntax.
        for i in 0 ..< 9 {
            // If "play again" is pressed, clear all of the squares.
            buttonToClear = view.viewWithTag(i) as! UIButton
            buttonToClear.setImage(nil, forState: .Normal)
        }
    }
    
    @IBAction func buttonPressed(sender: AnyObject) {
        
        if (gameState[sender.tag] == 0 && gameActive) {
            gameState[sender.tag] = activePlayer

            // Sets whether an X or O is marked in the box tapped.
            if activePlayer == 1 {
                sender.setImage(UIImage(named: "nought.png"), forState: .Normal)
                activePlayer = 2
            } else {
                sender.setImage(UIImage(named: "cross.png"), forState: .Normal)
                activePlayer = 1
            }
            
            // Check for winning combinations after each turn.
            for combination in winningCombination {
                if (gameState[combination[0]] != 0 && gameState[combination[0]] == gameState[combination[1]] && gameState[combination[1]] == gameState[combination[2]]) {
                    
                    gameActive = false
                    
                    if gameState[combination[0]] == 1 {
                        print("O's have won!")
                        gameOverLabel.text = "O's have won!"
                    } else {
                        print("X's have won!")
                        gameOverLabel.text = "X's have won!"
                    }
                endGame()
                }
            }
            
            if gameActive == true {
                gameActive = false

                for buttonState in gameState {
                
                    if buttonState == 0 {
                        gameActive = true
                    }
                }
            
                if gameActive == false {
                    gameOverLabel.text = "It's a draw!"
                    print("It's a draw!")
                    endGame()
                }
            }
        }
    }

    func endGame() {
        gameOverLabel.hidden = false
        playAgain.hidden = false
        
        UIView.animateWithDuration(0.05, animations: { () -> Void in
        self.gameOverLabel.center = CGPointMake(self.gameOverLabel.center.x + 500, self.gameOverLabel.center.y)
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gameOverLabel.hidden = true
        gameOverLabel.center = CGPointMake(gameOverLabel.center.x - 500, gameOverLabel.center.y)
        
        playAgain.hidden = true
        playAgain.center = CGPointMake(playAgain.center.x - 500, playAgain.center.y)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

