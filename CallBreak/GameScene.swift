    //
    //  GameScene.swift
    //  CallBreak
    //
    //  Created by Yadav, Darwin on 11/30/19.
    //  Copyright © 2019 Yadav, Darwin. All rights reserved.
    //  Card Images Retrieved from :
    //  http://acbl.mybigcommerce.com/52-playing-cards/
    
    import SpriteKit
    import GameplayKit
    
    enum CardLevel : CGFloat {
        case board = 10
        case moving = 100
        case enlarged = 200
    }
    
    struct scoreBoard {
        var player1Score:Int = 0
        var player2Score:Int = 0
        var player3Score:Int = 0
        var player4Score:Int = 0
    }
    
    class GameScene: SKScene {
        
        let slider = UISlider(frame: CGRect(x:250, y:250, width: 300, height: 100))
        var sliderLabel = UILabel(frame: CGRect(x: 565, y: 250, width: 50, height: 100))
        var sliderButton = UIButton(frame: CGRect(x:595, y: 277, width: 60, height: 40))
        
        let cardDeck = Deck()
        
        private var label : SKLabelNode?
        private var spinnyNode : SKShapeNode?
        private var roundCount: Int = 1
        var currentRound:Round = Round()
        var nextDelete:Card!
        var playerTurn:Int = 1
        var winnnerPlayer: Int = 0
        
        var player1: Player!
        var player2: Player!
        var player3: Player!
        var player4: Player!
        var currentPlayer: Player!
        var validCards = [Card]()
        
        var slidersHidden:Bool = true
        
        var callScores = scoreBoard()
        var actualRoundScores = scoreBoard()
        var finalScore = scoreBoard()
        
        var player1Label = SKLabelNode()
        var player2Label = SKLabelNode()
        var player3Label = SKLabelNode()
        var player4Label = SKLabelNode()
        
        func showSlider(){
            
            slidersHidden = false
            
            slider.minimumValue = 1
            slider.maximumValue = 8
            slider.tintColor = UIColor.red
            slider.thumbTintColor = UIColor.black
            slider.backgroundColor = UIColor.brown
            slider.addTarget(self, action: #selector(self.sliderValueChange(sender:)), for: .valueChanged)
            
            //sliderLabel.font.withSize(CGFloat(30))
            sliderLabel.textColor = UIColor.red
            sliderLabel.font = UIFont.boldSystemFont(ofSize: 30)
            sliderLabel.text = String(Int(slider.value))
            
            sliderButton.backgroundColor = UIColor.gray
            sliderButton.setTitleColor(UIColor.red, for: .normal)
            sliderButton.setTitle("Done", for: .normal)
            sliderButton.isEnabled = true
            sliderButton.addTarget(self, action: #selector(self.sliderButtonPressed(sender:)), for: .touchUpInside)
            
            view?.addSubview(slider)
            
            self.view?.addSubview(sliderLabel)
            
            view?.addSubview(sliderButton)
        }
        
        @IBAction func sliderValueChange(sender: UISlider){
            sliderLabel.text = String(Int(slider.value))
        }
        
        @IBAction func sliderButtonPressed(sender: UIButton){
            player1Label.removeFromParent()
            player1Label.text = String(Int(slider.value))
            
            callScores.player1Score = Int(slider.value)
            
            addChild(player1Label)
            print("Button Pressed")
            hideSliders()
        }
        
        func hideSliders(){
            slider.removeFromSuperview()
            sliderLabel.removeFromSuperview()
            sliderButton.removeFromSuperview()
            slidersHidden = true
            initializeLegalCards()
        }
        
        func setLabel(label:SKLabelNode ,value:Int){
            label.removeFromParent()
            label.text = String(value)
            label.fontSize = 36
            label.fontColor = UIColor.red
            label.fontName = "AvenirNext-Bold"
            addChild(label)
        }
        
        override func didMove(to view: SKView) {
            
            showSlider()
            self.view?.isMultipleTouchEnabled = false
            
            let d: Deck = Deck()
            
            player1 = Player(xPos:  Double(-self.frame.size.width/4) , yPos: Double(-(self.frame.size.height/2 - 250)), id: 1)
            player2 = Player(xPos: Double(self.frame.width/2 - 50), yPos: Double(self.frame.height/8), id: 2)
            player3 = Player(xPos:  Double(-self.frame.size.width/4) , yPos: Double(self.frame.size.height/2 - 250), id: 3)
            player4 = Player(xPos: Double(-(self.frame.width/2 - 50)), yPos: Double(self.frame.height/8), id: 4)
            
            d.shuffle()
            
            var cardSpace1:Double = 0
            var cardSpace2:Double = 0
            var cardSpace3:Double = 0
            var cardSpace4:Double = 0
            var zPos = 1
            
            for n in 1...13 {
                let tempCard1 = d.getTopCard()
                player1.giveCard(topCard: tempCard1)
                zPos += 1
                tempCard1.zPosition = CGFloat(zPos)
                addChild(tempCard1)
                
                let sendCard1 = SKAction.move(to: CGPoint(x: CGFloat(player1.xPosition + cardSpace1), y: CGFloat(player1.yPosition)), duration: 0.5)
                
                cardSpace1 += ((-player1.xPosition - player1.xPosition) / 13)
                
                
                let tempCard3 = d.getTopCard()
                player3.giveCard(topCard: tempCard3)
                zPos += 1
                tempCard3.zPosition = CGFloat(zPos)
                tempCard3.flip()
                addChild(tempCard3)
                let sendCard3 = SKAction.move(to: CGPoint(x: CGFloat(player3.xPosition + cardSpace3), y: CGFloat(player3.yPosition)), duration: 0.5)
                
                
                cardSpace3 += ((-player3.xPosition - player3.xPosition) / 13)
                
                
                let tempCard2 = d.getTopCard()
                player2.giveCard(topCard: tempCard2)
                zPos += 1
                tempCard2.zPosition = CGFloat(zPos)
                tempCard2.flip()
                addChild(tempCard2)
                let sendCard2 = SKAction.move(to: CGPoint(x: CGFloat(player2.xPosition ), y: CGFloat(player2.yPosition - cardSpace2)), duration: 0.5)
               
               
                cardSpace2 += ((player2.yPosition) / 10)
                
                
                
                let tempCard4 = d.getTopCard()
                player4.giveCard(topCard: tempCard4)
                zPos += 1
                tempCard4.zPosition = CGFloat(zPos)
                tempCard4.flip()
                addChild(tempCard4)
                let sendCard4 = SKAction.move(to: CGPoint(x: CGFloat(player4.xPosition ), y: CGFloat(player4.yPosition - cardSpace4)), duration: 0.5)
             
                
                cardSpace4 += ((player4.yPosition) / 10)
                
                tempCard1.run(sendCard1, completion: {
                    tempCard2.run(sendCard2, completion: {
                        tempCard3.run(sendCard3, completion: {
                            tempCard4.run(sendCard4)
                            })
                        })
                    })
                
                if(n == 13){
                    player1Label.position = CGPoint(x: CGFloat(player1.xPosition + cardSpace1 + 50), y: CGFloat(player1.yPosition))
                    player2Label.position = CGPoint(x: CGFloat(player2.xPosition ), y: CGFloat(player2.yPosition - cardSpace2 - 100))
                    player3Label.position = CGPoint(x: CGFloat(player3.xPosition + cardSpace3 + 50), y: CGFloat(player3.yPosition))
                    player4Label.position = CGPoint(x: CGFloat(player4.xPosition ), y: CGFloat(player4.yPosition - cardSpace4 - 100))
                    
                    callScores.player2Score = countCalls(player: player2)
                    callScores.player3Score = countCalls(player: player3)
                    callScores.player4Score = countCalls(player: player4)
                    
                    setLabel(label: player1Label, value: callScores.player1Score)
                    setLabel(label: player2Label, value: callScores.player2Score)
                    setLabel(label: player3Label, value: callScores.player3Score)
                    setLabel(label: player4Label, value: callScores.player4Score)
                }
            }
            
            currentPlayer = player1
            currentRound.startingPlayer = 1
            
            processAIMove()

        }
        
        func countCalls(player: Player) -> Int{
            var totalCall:Int = 1
            var spadeCount:Int = 0
            for eachCard in player.playerCards{
                if(eachCard.getSuit() == .spades){
                    spadeCount += 1
                } else if (eachCard.getValue() == .ace || eachCard.getValue() == .king){
                    totalCall += 1
                }
            }
            if(spadeCount > 3){
                totalCall = totalCall + spadeCount - 2
            }
            print("Total Calls ")
            print(totalCall)
            return totalCall
        }
        
        func initializeLegalCards(){

            for eachCard in currentPlayer.playerCards{
                if currentPlayer.isLegalCard(currentCard: eachCard, currentRound: currentRound) {
                    
                    //validCards.append(eachCard)
                    if(currentRound.roundCards.count != 0){
                        if(eachCard.compareCards(otherCard: currentRound.getHighestCard())){
                            validCards.append(eachCard)
                            
                            eachCard.setScale(1.3)
                            
                        }
                    }
                }
            }
            
            if(validCards.count == 0){
                for eachCard in currentPlayer.playerCards{
                    if currentPlayer.isLegalCard(currentCard: eachCard, currentRound: currentRound) {
                        validCards.append(eachCard)
                        eachCard.setScale(1.3)
                    }
                }
            }
            
            if(validCards.count == 0){
                for eachCard in currentPlayer.playerCards{
                    validCards.append(eachCard)
                    eachCard.setScale(1.3)
                }
            }
        }
        
        func touchDown(atPoint pos : CGPoint) {
            if let n = self.spinnyNode?.copy() as! SKShapeNode? {
                n.position = pos
                n.strokeColor = SKColor.green
                self.addChild(n)
            }
        }
        
        func touchMoved(toPoint pos : CGPoint) {
            if let n = self.spinnyNode?.copy() as! SKShapeNode? {
                n.position = pos
                n.strokeColor = SKColor.blue
                self.addChild(n)
            }
        }
        
        func touchUp(atPoint pos : CGPoint) {
            if let n = self.spinnyNode?.copy() as! SKShapeNode? {
                n.position = pos
                n.strokeColor = SKColor.red
                self.addChild(n)
            }
        }
        
        
        override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            if(!slidersHidden || currentPlayer != player1){
                return
            }
            for touch in touches {
                let location = touch.location(in: self)
                if let card = atPoint(location) as? Card {
                    move(card: card)
                }
            }
        }
        
        func move(card: Card){
            
            if(currentPlayer.playerCards.contains(card) && validCards.contains(card)){
                card.zPosition = CardLevel.moving.rawValue
                
                //currentPlayer.removeCard(theCard: card)
                
                if(!player1.playerCards.contains(card)){
                    card.removeFromParent()
                    card.flip()
                    addChild(card)
                }
                
                //touch.view?.isUserInteractionEnabled = false
                
                for eachMagnified in validCards {
                    eachMagnified.setScale(1)
                }
                
                var centerX: Int
                var centerY: Int
                
                switch playerTurn {
                    
                case 1:
                    centerX = 0
                    centerY = -50
                    
                case 2:
                    centerX = 100
                    centerY = 0
                    card.zRotation = CGFloat(1.571)
                case 3:
                    centerX = 0
                    centerY = 50
                case 4:
                    centerX = -100
                    centerY = 0
                    card.zRotation = CGFloat(1.571)
                default:
                    centerX = 0
                    centerY = 0
                }
                
                let moveCard = SKAction.move(to: CGPoint(x: centerX, y: centerY), duration: 0.5)
                card.run(moveCard)
                
                //currentRound.addCardToIndex(index: playerTurn, aCard: card)
                currentRound.addCard(aCard: card)
                
                if(currentRound.roundCards.count == 4){
                    let winnerCard:Card = currentRound.getHighestCard()
                    
                    winnnerPlayer = findWinnerPlayer(theCard: winnerCard)
                    //winnnerPlayer = (playerTurn - currentRound.getRunningWinner() + 1)
                    
                    var destinationX: Double = 0
                    var destinationY: Double = 0
                    
                    switch winnnerPlayer {
                    case 1:
                        destinationX = player1.xPos()
                        destinationY = player1.yPos() - 200
                    case 2:
                        destinationX = player2.xPos() + 200
                        destinationY = player2.yPos()
                    case 3:
                        destinationX = player3.xPos()
                        destinationY = player3.yPos() + 200
                    case 4:
                        destinationX = player4.xPos() - 200
                        destinationY = player4.yPos()
                    default:
                        destinationX = 0
                        destinationY = 0
                    }
                    
                    print(winnnerPlayer)
                    
                    let sendCard = SKAction.move(to: CGPoint(x: destinationX, y: destinationY), duration: 0.5)
                    let waitDuration = SKAction.wait(forDuration: 1)
                    
                    for eachCard in self.currentRound.roundCards{
                        eachCard.run(SKAction.sequence([waitDuration, sendCard]))
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        for eachCard in self.currentRound.roundCards {
                            eachCard.removeFromParent()
                        }
                    }
                }
                
                if(currentRound.roundCards.count == 4){
                    print("Winner player" + String(winnnerPlayer))
                    resetRound()
                    changePlayer(winner: winnnerPlayer)
                } else {
                    nextPlayer()
                }
                
                validCards.removeAll()
                initializeLegalCards()
                processAIMove()
                //touch.view?.isUserInteractionEnabled = true
                checkEndGame()
            }
            
        }
        func addScoreToWinner(winner: Int){
            if(winner == 1){
                actualRoundScores.player1Score += 1
            } else if (winner == 2){
                actualRoundScores.player2Score += 1
            } else if (winner == 3){
                actualRoundScores.player3Score += 1
            } else if (winner == 4){
                actualRoundScores.player4Score += 1
            }
        }
        
        func checkEndGame(){
            if player1.cardCount() == 0 && player2.cardCount() == 0 && player3.cardCount() == 0 && player4.cardCount() == 0{
                
                var scores = [Int]()
                
                if(callScores.player1Score > actualRoundScores.player1Score){
                    finalScore.player1Score = 0
                } else {
                    finalScore.player1Score = actualRoundScores.player1Score
                }
                
                scores.append(finalScore.player1Score)
                
                if(callScores.player2Score > actualRoundScores.player2Score){
                    finalScore.player2Score = 0
                } else {
                    finalScore.player1Score = actualRoundScores.player1Score
                }
                scores.append(finalScore.player2Score)
                
                if(callScores.player3Score > actualRoundScores.player3Score){
                    finalScore.player3Score = 0
                } else {
                    finalScore.player1Score = actualRoundScores.player1Score
                }
                scores.append(finalScore.player3Score)
                
                if(callScores.player4Score > actualRoundScores.player4Score){
                    finalScore.player4Score = 0
                } else {
                    finalScore.player4Score = actualRoundScores.player4Score
                }
                scores.append(finalScore.player4Score)
                
                let max = scores.max()
                let maxIndex = scores.firstIndex(of: max!)
                
                self.removeAllChildren()
                
                
                let scoreLabel = SKLabelNode()
                
                scoreLabel.fontSize = 36
                scoreLabel.fontColor = UIColor.red
                scoreLabel.fontName = "AvenirNext-Bold"
                scoreLabel.text = "Player \(maxIndex! + 1) wins"
                scoreLabel.position = CGPoint(x: -200, y: 0)
                addChild(scoreLabel)
                
            }
        }
        
        func processAIMove(){
            DispatchQueue.global().async {
                if(self.currentPlayer != self.player1){
                    if(self.validCards.count != 0){
                    self.move(card: self.validCards.randomElement()!)
                    }
                }
            }
        }
        
        func findWinnerPlayer(theCard: Card) -> Int{
            if player1.playerCards.contains(theCard){
                return 1
            } else if player2.playerCards.contains(theCard){
                return 2
            } else if player3.playerCards.contains(theCard){
                return 3
            } else if player4.playerCards.contains(theCard){
                return 4
            }
            return 0
        }
        
        func nextPlayer(){
            if(currentPlayer == player1) {
                currentPlayer = player2
                playerTurn = 2
            }else if (currentPlayer == player2){
                currentPlayer = player3
                playerTurn = 3
            }else if (currentPlayer == player3){
                currentPlayer = player4
                playerTurn = 4
            }else if (currentPlayer == player4){
                currentPlayer = player1
                playerTurn = 1
            }
        }
        
        func changePlayer(winner:Int){
            if(winner == 1){
                currentPlayer = player1
                playerTurn = 1
            }else if(winner == 2){
                currentPlayer = player2
                playerTurn = 2
            }else if(winner == 3){
                currentPlayer = player3
                playerTurn = 3
            }else if(winner == 4){
                currentPlayer = player4
                playerTurn = 4
            }
            currentRound.startingPlayer = winner
        }
        
        func resetRound(){
            for card in currentRound.roundCards {
                if(player1.playerCards.contains(card)){
                    player1.removeCard(theCard: card)
                } else if(player2.playerCards.contains(card)){
                    player2.removeCard(theCard: card)
                } else if(player3.playerCards.contains(card)){
                    player3.removeCard(theCard: card)
                } else if(player4.playerCards.contains(card)){
                    player4.removeCard(theCard: card)
                }
            }
            playerTurn = 1
            currentRound.clearCards()
        }
        
        func clearCards(){
            currentRound.clearCards()
        }
        
        override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
            //        for touch in touches {
            //            let location = touch.location(in: self)
            //            if let card = atPoint(location) as? Card {
            //                card.zPosition = CardLevel.board.rawValue
            //                card.removeFromParent()
            //                addChild(card)
            //            }
            //        }
        }
        
        override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
            
        }
        
        
        override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
            for t in touches { self.touchUp(atPoint: t.location(in: self)) }
        }
        
        
        override func update(_ currentTime: TimeInterval) {
            // Called before each frame is rendered
        }
    }
