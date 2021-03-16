//
//  OthelloData.swift
//  Othello
//
//  Created by Michael Camp on 2/24/21.
//

import Foundation
struct OthelloData {
    
    var turn = true
    var currentTile = Int()
    var numBoard = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 1, 0, 0, 0, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    let resetBoard = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 1, 0, 0, 0, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    
    let rightTilesIgnore = [7, 15, 23, 31, 39, 47, 55, 63]
    let leftTilesIgnore = [0, 8, 16, 24, 32, 40, 48, 56]
    
    var pointsWhite = 2
    var pointsBlack = 2
    var pointsAdded = Int()
    var whiteTilesLeft = 30
    var blackTilesLeft = 30
    
    
    mutating func placeChip(tag: Int) {
        if turn == true {
            if numBoard[tag] == 0 {
            numBoard[tag] = 1
        }
            if numBoard[tag] == 1 {
                numBoard[tag] = 2
            }
            else {
                numBoard[tag] = 1
            }
        }
    }
    func isOnBlank(tag: Int) -> Bool {
        if numBoard[tag] == 0  {
            return true
        } else {
            return false
        }
    }
    func isAdjacent(tag: Int) {
        var adjacents = 0
        let tag = tag
        if tag >= 8 && tag >= 53 {
            if numBoard[tag - 9] > 0 {
                adjacents += 1
            }
            if numBoard[tag - 8] > 0 {
                adjacents += 1
            }
            if numBoard[tag - 7] > 0 {
                adjacents += 1
            }
        }
    }
    
    
    mutating func startOver() {
        numBoard = resetBoard
        turn = true
        pointsWhite = 2
        pointsBlack = 2
        whiteTilesLeft = 30
        blackTilesLeft = 30
    }
    
    mutating func flipTile(tag: Int) {
        if turn == true {
            if numBoard[tag] == 0 {
            numBoard[tag] = 1
            }
            else if numBoard[tag] == 1 {
                numBoard[tag] = 2
            }
            else if numBoard[tag] == 2 {
                numBoard[tag] = 1
            }
        }
        if turn == false {
            if numBoard[tag] == 0 {
            numBoard[tag] = 2
            }
            else if numBoard[tag] == 2 {
                numBoard[tag] = 1
            }
            else if numBoard[tag] == 1 {
                numBoard[tag] = 2
            }
        }
    
    }


  


  
    
    
    
    
    
    
   // MAKE DATA ******************
    
    
    var arrayRight = [Int]()
    var arrayLeft = [Int]()
    var arrayDown = [Int]()
    var arrayUp = [Int]()
    var arrayUL = [Int]()
    var arrayUR = [Int]()
    var arrayDL = [Int]()
    var arrayDR = [Int]()
    var distTop = 0
    var distBottom = 0
    var distLeft = 0
    var distRight = 0
    
    var allFlips = [Int]()
    
    var masterArray2 = [[Int]]()
    
   
    
    
    
    mutating func masterArrayBuilder(tag: Int, turn: Bool) {
        
    let tag = tag - 1
        
        
        if isOnBlank(tag: tag) == false {
            print("not on blank")
            return
        }
        arrayUp.removeAll()
        arrayDown.removeAll()
        arrayRight.removeAll()
        arrayLeft.removeAll()
        arrayUL.removeAll()
        arrayUR.removeAll()
        arrayDL.removeAll()
        arrayDR.removeAll()
        
        arrayBuilderUp(tag: tag)
        arrayBuilderDown(tag: tag)
        arrayBuilderLeft(tag: tag)
        arrayBuilderRight(tag: tag)
        arrayBuilderUL(tag: tag)
        arrayBuilderUR(tag: tag)
        arrayBuilderDL(tag: tag)
        arrayBuilderDR(tag: tag)
        
        if isAdjacent(up: arrayUp, down: arrayDown, left: arrayLeft, right: arrayRight, UL: arrayUL, UR: arrayUR, DL: arrayDL, DR: arrayDR) == false {
            print("not adjacent")
//            print(arrayDR, arrayDR, arrayUL, arrayUR, arrayLeft, arrayRight, arrayUp, arrayDown)
            return
        }
        
        masterArray2.removeAll()
        allFlips.removeAll()
        
        masterArray2 = [arrayUp, arrayDown, arrayLeft, arrayRight, arrayUL, arrayUR, arrayDL, arrayDR]

        checkTiles(turn: turn, array: arrayUp)
        checkTiles(turn: turn, array: arrayDown)
        checkTiles(turn: turn, array: arrayLeft)
        checkTiles(turn: turn, array: arrayRight)
        checkTiles(turn: turn, array: arrayUL)
        checkTiles(turn: turn, array: arrayUR)
        checkTiles(turn: turn, array: arrayDL)
        checkTiles(turn: turn, array: arrayDR)
        allFlips.append(tag)
        flipFlips(array: allFlips)
        pointsAdded = allFlips.count
        
       pointsUpdater(numBoard: numBoard)
        if turn == true {
            whiteTilesLeft -= 1
        } else {
            blackTilesLeft -= 1
        }
        self.turn.toggle()
        
        }
   
    
    
    
    mutating func arrayBuilderUp(tag: Int) {
           var newtag = tag
        if tag < 8 {
            return
        }
               for _ in 0...7 {
               newtag -= 8
               if newtag >= 0 {
                   arrayUp.append(newtag)
                distTop += 1
               } } }
    
    
    
  
    
    
    mutating func arrayBuilderRight(tag: Int) {
        var newTag = tag
        var reduce = tag
        for i in 0..<rightTilesIgnore.count {
            if tag == rightTilesIgnore[i] {
                return
            }
        }
        
        
        while reduce >= 7 {
            reduce -= 8
        }
        for _ in (reduce + 1)...7 {
            newTag += 1
            arrayRight.append(newTag)
            distRight += 1
        } }
    
    mutating func arrayBuilderLeft(tag: Int) {
        var newTag = tag
        var reduce = tag
        
        for i in 0..<leftTilesIgnore.count {
            if tag == leftTilesIgnore[i] {
                return
            }
        }
        while reduce > 7 {
            reduce -= 8
        }
        for _ in 0...(reduce - 1) {
            newTag -= 1
            arrayLeft.append(newTag)
            distLeft += 1
        } }
    
   
        
        
    mutating func arrayBuilderDown(tag: Int) {
        var newtag = tag
            for _ in 1...7 {
            newtag += 8
            if newtag <= 63 {
                arrayDown.append(newtag)
                distBottom += 1
            } } }
        
    mutating func arrayBuilderUL(tag: Int) {
        var newtag = tag
        for _ in 0...7 {
            newtag -= 9
            if arrayUL.count < arrayUp.count && arrayUL.count < arrayLeft.count {
                arrayUL.append(newtag)
            } } }
        
    mutating func arrayBuilderUR(tag: Int) {
        var newtag = tag
            for _ in 0...7 {
            newtag -= 7
                if arrayUR.count < arrayUp.count && arrayUR.count < arrayRight.count {
                arrayUR.append(newtag)
            } } }
        
    mutating func arrayBuilderDL(tag: Int) {
        var newtag = tag
            for _ in 1...7 {
            newtag += 7
                if arrayDL.count < arrayDown.count && arrayDL.count < arrayLeft.count {
                arrayDL.append(newtag)
            } } }
    
    mutating func arrayBuilderDR(tag: Int) {
        var newtag = tag
            for _ in 1...7 {
            newtag += 9
                if arrayDR.count < arrayDown.count && arrayDR.count < arrayRight.count {
                arrayDR.append(newtag)
            } } }
    
    
    //
    
  
    
    // SORT DATA *********************
    

    
    mutating func checkTiles(turn: Bool, array: [Int]) {
         
        let count = array.count
        var countPoint2 = 0
        var color = 1
       
    
        if turn == false {
            color = 2
        }
        for i in 0..<count {
            if numBoard[array[i]] == 0 {
                break
            }
            if numBoard[array[i]] == color {
                countPoint2 = i
                break
            } }
        
        for i in 0..<countPoint2 {
            allFlips.append(array[i])
        } }
    
    

    
    mutating func flipFlips(array: [Int]) {
        var color = 1
        if turn == false {
            color = 2
        }
        for i in 0..<array.count {
            numBoard[(array[i])] = color
            } }
  
    
    mutating func pointsUpdater(numBoard: [Int]) {
       var whites = 0
        var blacks = 0
        
        for i in 0..<numBoard.count {
            if numBoard[i] == 1 {
                whites += 1
            }
            if numBoard[i] == 2 {
                blacks += 1
            } }
        pointsWhite = whites
        pointsBlack = blacks
        }
    mutating func isAdjacent(up: [Int], down: [Int], left: [Int], right: [Int], UL: [Int], UR: [Int], DL: [Int], DR: [Int]) -> Bool {
        var adjacent = false
        if up.count > 0 {
            if numBoard[(up[0])] > 0 {
            adjacent = true
        } }
        if left.count > 0 {
            if numBoard[left[0]] > 0 {
            adjacent = true
        } }
        if down.count > 0 {
            if numBoard[down[0]] > 0 {
            adjacent = true
        } }
        if right.count > 0 {
            if numBoard[right[0]] > 0 {
            adjacent = true
        } }
        if UL.count > 0 {
            if numBoard[UL[0]] > 0 {
            adjacent = true
        } }
        if UR.count > 0 {
            if numBoard[UR[0]] > 0 {
            adjacent = true
        } }
        if DL.count > 0 {
            if numBoard[DL[0]] > 0 {
            adjacent = true
        } }
        if DR.count > 0 {
            if numBoard[DR[0]] > 0 {
            adjacent = true
        } }
        return adjacent
    }
    
    
    func checkSurorund(array: [Int]) {
        
    }
    
}
