//
//  CardModel.swift
//  Matching Game
//
//  Created by Tony Cao on 4/10/20.
//  Copyright © 2020 Tony Cao. All rights reserved.
//

import Foundation

class CardModel {
   
   func getCards() -> [Card] {
      
      //declare an array of stored numbers we've already generated
      var generatedNumberArray = [Int]()
      
      // declare an array to store generated cards
      var generatedCardsArray = [Card]()
      
      // Randmoly generate pairs of cards -- 16 cards, 8 pairs
      while generatedNumberArray.count < 16 {
         
         // get random number -- 1...13
         let randomNumber = Int.random(in: 1...13)
         
         // ensure that the random number is not the one we already have
         if !generatedNumberArray.contains(Int(randomNumber)) {
            
            // store the number into generatedNumberarray
            generatedNumberArray.append(Int(randomNumber))
            
            // store the number into generated card array
            generatedNumberArray.append(Int(randomNumber))
            
            // create two card objects --> represents the one pair
            let cardOne = Card()
            let cardTwo = Card()
            
            // set the front image of the pair of cards
            cardOne.imageName = "card\(randomNumber)"
            cardTwo.imageName =  "card\(randomNumber)"
            
            // add the pair to generatedNumberArray
            generatedCardsArray.append(cardOne)
            generatedCardsArray.append(cardTwo)
         }
         
      } // end of "Randmoly generate pairs of cards" while loop
      
      // randomize the array
      for i in 0...generatedCardsArray.count-1 {
         
         //find a random index to swap with
         let randomNumber = Int(arc4random_uniform(UInt32(generatedCardsArray.count)))
         
         //swap the two cards
         let temporaryStorage = generatedCardsArray[i]
         generatedCardsArray[i] = generatedCardsArray[randomNumber]
         
         generatedCardsArray[randomNumber] = temporaryStorage
         
      } // end of randomizing for loop
      
      //Return the array
      return generatedCardsArray
      
   } // end of getCards()
   
} // end of cardModel class
