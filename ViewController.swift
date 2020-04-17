//
//  ViewController.swift
//  Matching Game
//
//  Created by Tony Cao on 4/10/20.
//  Copyright © 2020 Tony Cao. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
   
   @IBOutlet weak var timerLabel: UILabel!
   @IBOutlet weak var collectionView: UICollectionView!
   
   var model = CardModel()
   var cardArray =  [Card]()
   
   var firstFlippedCardIndex: IndexPath?
   
   var timer:Timer?
   var milliseconds:Float = 10 * 1000 // 10 seconds
   
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      collectionView.delegate = self
      collectionView.dataSource = self
      
      // create a new card array of 16 cards -- getCards()
      cardArray = model.getCards()
      
      // create a timer
      timer = Timer.scheduledTimer(timeInterval: 0.001, target: self, selector: #selector(timerElapsed), userInfo: nil, repeats: true)
      
      RunLoop.main.add(timer! , forMode: .common)
   
   } // end of ViewController()
   
   override func viewDidAppear(_ animated: Bool) {
      
      soundManager.playSound(.shuffle)
   
   } // end of viewDidAppear()
   
   override func didReceiveMemoryWarning() {
      
      super.didReceiveMemoryWarning()
      
   } // end of didReceiveMemoryWarning()
   
   // Timer method
   @objc func timerElapsed() {
      
      milliseconds -= 1
      
      //convert to seconds
      let seconds = String(format: "%.2f", milliseconds/1000)
      
      // set label
      timerLabel?.text = "Time remaining \(seconds)"
      
      // when the timer has reached 0
      if milliseconds <= 0 {
         
         
         //stop timer
         timer?.invalidate()
         
         // timerLabel.text = UIColor.red
         
         // check if there are any cards unmatched
         
      } // end of timer reaching 0 ms condition
      
   } // end of timerElapsed()
   
   // UICollectionView Protocol Method
   
   func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      return cardArray.count
   }
   
   func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      
      //get the card collection view object
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cardCell", for: indexPath) as! CardCollectionViewCell
      
      //get the card that collection view is trying to dispaly
      let card = cardArray[indexPath.row]
      
      //set that card for the cell
      cell.setCard(card)
      
      return cell
   }
   
   func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
      
      //check if there is any time left
      if milliseconds<=0{
         return
      }
      
      //get the cell that user selected
      let cell = collectionView.cellForItem(at: indexPath) as! CardCollectionViewCell
      
      //get the card that user selecterd
      let card = cardArray[indexPath.row]
      
      
      if card.isFlipped == false {
         // flip the card
         cell.flip()
         
         //play flip sound
         soundManager.playSound(.flip)
         
         //set the status of the card
         card.isFlipped = true
         
         //determine whether its first card or the second card that is flipped over
         if firstFlippedCardIndex == nil {
            
            //there is the first card is being flipped
            firstFlippedCardIndex = indexPath
         }
         else {
            
            // this is the second card that is being flipped
            
            // perform matching logic
            checkForMatches(indexPath)
         }
      }
      
   } //end of did select item at method
   
   // game logic methods
   
   func checkForMatches(_ secondFlippedCardndex:IndexPath) {
      
      // get the cells of the two cards that were revealed
      let cardOneCell = collectionView.cellForItem(at: firstFlippedCardIndex!) as? CardCollectionViewCell
      let cardTwoCell = collectionView.cellForItem(at: secondFlippedCardndex) as? CardCollectionViewCell
      
      // get the cards for the two cards that were revealed
      let cardOne = cardArray [firstFlippedCardIndex!.row]
      let cardTwo = cardArray [secondFlippedCardndex.row]
      
      // compare the two cards
      if cardOne.imageName == cardTwo.imageName {
         
         // if they both match..
         // play sound
         soundManager.playSound(.match)
         
         
         // set the status of the card
         cardOne.isMatched = true
         cardTwo.isMatched = true
         
         
         // remove the cards from the grid
         cardOneCell!.remove()
         cardTwoCell!.remove()
         
         // check if the game has ended
         checkGameEnded()
         
      }
      else{
         
         //its not a match
         
         //play sound
         soundManager.playSound(.nomatch)
         
         //set the statuses of the card
         cardOne.isFlipped = false
         cardTwo.isFlipped = false
         
         
         //flip both cards back
         //changedbyme
         cardOneCell?.flipBack()
         cardTwoCell?.flipBack()
      }
      
      //tell the collection view to reload the cell of first card if it is nil
      
      if cardOneCell == nil{
         collectionView.reloadItems(at: [firstFlippedCardIndex!])
      }
      
      // Reset the property that track the first card flipped
      firstFlippedCardIndex = nil
   
   } // end of checkForMatches()
   
   
   func checkGameEnded() {
      // determine if there are any cards unmatched
      var isWon = true
      
      // for loop through all the cards in the card to check if nay is still not matched
      for card in cardArray {
         if card.isMatched == false {
            isWon = false
            break
         }
      } // end of for loop
      
      // messaging variables
      var title = ""
      var message = ""
      
      // if isWon was not changed to false, then player has won...
      // check if the player won before the timer ran out
      if isWon {
         if milliseconds > 0
         {
            timer?.invalidate()
         }
         
         title = "Congratulations"
         message = "You have won"
      }
      else{
         
         // if there are unmatched cards check if there any time left
         if milliseconds > 0 {
            return
         }
         title = "Game Over"
         message = "You lost"
         
      } // end of isWon condition
      
      
      // show won or lost message
      showAlert(title, message)
   
   } // end of checkGameEnded()
   
   // function to display win/lose messages
   func showAlert(_ title: String,_ message: String ) {
      let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
      let  alertaction = UIAlertAction(title: "OK", style: .default, handler: nil)
      
      alert.addAction(alertaction)
      
      present(alert,animated:true ,completion: nil)
   } // end of showAlert()
   
} // end of view controller
