//
//  ViewController.swift
//  Othello
//
//  Created by Michael Camp on 2/24/21.
//

import UIKit

class ViewController: UIViewController {
    var color = UIColor.white
  
  var newBoard = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 1, 0, 0, 0, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    @IBOutlet weak var whiteTilesLabel: UILabel!
    @IBOutlet weak var blackTilesLabel: UILabel!
    
    
    
    var othelloData = OthelloData()
    var controllerArray = [Int]()

    
  
    
    
    @IBOutlet weak var pointsPlusCounter: UILabel!
    @IBOutlet weak var whitePointsCounter: UILabel!
    @IBOutlet weak var blackPointsCounter: UILabel!
    
    
    
    
    
    
    @IBAction func restartGame(_ sender: UIButton) {
        othelloData.startOver()
        restart()
        whitePointsCounter.text = "WHITE: 0"
        blackPointsCounter.text = "BLACK: 0"
        pointsPlusCounter.text = "POINTS ADDED"
        whiteTilesLabel.text = "WHITE TILES LEFT: 30"
        blackTilesLabel.text = "BLACK TILES LEFT: 30"
    }
    
    
    
    @IBOutlet weak var itsYourTurn: UILabel!
   
    @IBAction func actionButtonPressed(_ sender: UIButton) {
        
    
        print(sender.tag)
        othelloData.masterArrayBuilder(tag: sender.tag, turn: othelloData.turn)
        
        updateChangedData()
//
       
        
       
        }

    
    
    
    
    
    
    
    

    override func viewDidLoad() {
        
        // Do any additional setup after loading the view.
        }
    
    func flipButton(_ sender: UIButton.Type, tag: Int) {
        if othelloData.turn == true {
            if othelloData.numBoard[tag] == 0 {
                othelloData.numBoard[tag] = 1

            }
            if othelloData.numBoard[tag] == 1 {
                othelloData.numBoard[tag] = 2
        }
            if othelloData.numBoard[tag] == 2 {
                othelloData.numBoard[tag] = 1
            } }

        else {
            if othelloData.numBoard[tag] == 0 {
                othelloData.numBoard[tag] = 2
            }
            if othelloData.numBoard[tag] == 1 {
                othelloData.numBoard[tag] = 2
        }
            if othelloData.numBoard[tag] == 2 {
                othelloData.numBoard[tag] = 1
        }
    }

        }
    
    func updateChangedData() {
        
        print(othelloData.allFlips)
        for i in 0..<othelloData.allFlips.count {
            if othelloData.turn == false {
                 color = UIColor.white
                itsYourTurn.text = "It's your turn, Black"
            }
            else {
                color = UIColor.black
                itsYourTurn.text = "It's your turn, White"
            }
            let button = view.viewWithTag(othelloData.allFlips[i] + 1) as? UIButton
            button?.tintColor = color
            blackPointsCounter.text = "BLACK: \(othelloData.pointsBlack)"
            whitePointsCounter.text = "WHITE: \(othelloData.pointsWhite)"
            pointsPlusCounter.text = "+\(othelloData.pointsAdded)"
            whiteTilesLabel.text = "WHITE TILES LEFT: \(othelloData.whiteTilesLeft)"
            blackTilesLabel.text = "BLACK TILES LEFT: \(othelloData.blackTilesLeft)"
            
        }
    }
    
    //MARK: - Future Funtionality 
    func updateUI() {
        for i in 0..<othelloData.numBoard.count {
            if othelloData.numBoard[i] == 0 {
                color = UIColor(red: 40, green: 144, blue: 0, alpha: 1)
            }
            if othelloData.numBoard[i] == 1 {
                color = UIColor.white
            }
            if othelloData.numBoard[i] == 2 {
                color = UIColor.black
            }
            if othelloData.numBoard[i] == 4 {
                color = UIColor.gray
            }
            let button = view.viewWithTag(i) as! UIButton
            button.tintColor = color
        }
    }
    func restart() {
        for i in 0..<newBoard.count {
            if newBoard[i] == 0 {
                color = #colorLiteral(red: 0.1568627451, green: 0.5663939714, blue: 0, alpha: 1)
            }
            if newBoard[i] == 1 {
                color = UIColor.white
            }
            if newBoard[i] == 2 {
                color = UIColor.black
            }
            if newBoard[i] == 4 {
                color = UIColor.gray
            }
            let button = view.viewWithTag(i + 1) as! UIButton
            button.tintColor = color
        }
    }

}
