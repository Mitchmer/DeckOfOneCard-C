//
//  MMCardViewController.swift
//  DeckOfOneCard-C
//
//  Created by Mitch Merrell on 8/20/19.
//  Copyright © 2019 Mitch Merrell. All rights reserved.
//

import UIKit

class MMCardViewController: UIViewController {

    @IBOutlet weak var cardLabel: UILabel!
    @IBOutlet weak var cardImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func newCardButtonTapped(_ sender: Any) {
        updateViews()
    }
    
    func updateViews() {
        MMCardController.shared()?.drawNewCard(1, completion: { (cards) in
            guard let cardsArray = cards else { return }
            let card = cardsArray[0]
            DispatchQueue.main.async {
                self.cardLabel.text = card.suit
            }
            
            MMCardController.shared()?.fetchImage(card, completion: { (cardToShow) in
                guard let newCard = cardToShow else { return }
                
                DispatchQueue.main.async {
                    self.cardImageView.image = newCard
                }
            })
        })
        
    }
}
