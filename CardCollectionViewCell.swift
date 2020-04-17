//
//  CardCollectionViewCell.swift
//  Matching Game
//
//  Created by Tony Cao on 4/10/20.
//  Copyright © 2020 Tony Cao. All rights reserved.
//

import UIKit

class CardCollectionViewCell: UICollectionViewCell {
   
   // IBOutlet properties for front and back of UIImageView from Main.storyboard
   @IBOutlet weak var frontImageView: UIImageView!
   @IBOutlet weak var backImageView: UIImageView!
   
   
   var card:Card?
   
   func setCard(_ card:Card) {
      
      //keep track of cards that gets passed in
      self.card = card
      
      if card.isMatched {
         
         // if the card is matched, make the image view invisible --> .alpha
         backImageView.alpha = 0
         frontImageView.alpha = 0
         
         // return --> do not run any code below
         return
      }
      else
      {
         
         // if the card hasn't been matched make the image view visible --> .alpha
         backImageView.alpha = 1
         frontImageView.alpha = 1
      }
      
      frontImageView.image = UIImage(named: card.imageName)
      
      //determine if the card is in flipped upstate or flipped downstate
      if card.isFlipped {
         
         // make sure front image view is on top
         UIView.transition(from: backImageView, to: frontImageView, duration: 0.3, options: [.transitionFlipFromLeft,.showHideTransitionViews ], completion: nil)
      }
      else {
         
         // make sure back image view is on top
         UIView.transition(from: frontImageView, to: backImageView, duration: 0, options: [.transitionFlipFromRight, .showHideTransitionViews], completion: nil)
      }
      
      
   } // end of setCard()
   
   func flip() {
      
      UIView.transition(from: backImageView, to: frontImageView, duration: 0.3, options: [.transitionFlipFromLeft, .showHideTransitionViews], completion: nil)
      
   } // end of flip()
   
   func flipBack() {
      
      DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
         UIView.transition(from: self.frontImageView, to: self.backImageView, duration: 0.3, options: [.transitionFlipFromRight, .showHideTransitionViews], completion: nil)
         
      }
      
   } // end of flipBack()
   
   func remove() {
      //remove both image views from being visible
      backImageView.alpha = 0
      
      // animate the removal of two matched cards
      UIView.animate(withDuration: 0.3, delay: 0.5, options: .curveEaseIn, animations: {
         self.frontImageView.alpha = 0
      }, completion: nil)
      
   } // end of remove()
   
} // end of CardCollectionViewCell class 
