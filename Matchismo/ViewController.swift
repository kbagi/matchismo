//
//  ViewController.swift
//  Matchismo
//
//  Created by Karol Baginski on 10/08/2014.
//  Copyright (c) 2014 Karol Baginski. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let TWO_CARDS = 0;
    let THREE_CARDS = 1;
    
    @IBOutlet var cardButtons: [UIButton]!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var modeButton: UIView!
    @IBOutlet weak var considerationLabel: UILabel!
    @IBOutlet weak var historySlider: UISlider!
    var _game:CardMatchingGame?;
    var game:CardMatchingGame{
        get{
            if _game == nil
            {
                _game = CardMatchingGame(cardCount: self.cardButtons.count, deck: createDeck());
            }
            return _game!;
        }
    }
    var currentMessage = "Welcome to Matchismo!";
    var messageHistory = [String]();
    
    @IBAction func historySliderChanged(sender: UISlider) {
        var index = Int(sender.value);
        if index < messageHistory.count {
            considerationLabel.text = messageHistory[index];
        }
    }
    @IBAction func touchCardButton(sender: UIButton) {
        var chosenButtonIndex = find(cardButtons!, sender)!;
        currentMessage = game.chooseCardAtIndex(chosenButtonIndex);
        messageHistory.append(currentMessage);
        historySlider.maximumValue = Float(messageHistory.count);
        historySlider.value = historySlider.maximumValue;
        modeButton.userInteractionEnabled = false;
        updateUI();
    }
    @IBAction func redealButton(sender: UIButton) {
        resetGame();
    }
    @IBAction func changeMode(sender: UISegmentedControl) {
        resetGame();
        game.mode = sender.selectedSegmentIndex;
    }
    
    func createDeck() -> Deck{
        return PlayingCardDeck()
    }
    func updateUI(){
        for cardButton in cardButtons{
            var cardButtonIndex = find(cardButtons!, cardButton)!;
            var card = game.cardAtIndex(cardButtonIndex)!;
            cardButton.setTitle(titleForCard(card), forState: UIControlState.Normal);
            cardButton.setBackgroundImage(backgroundImageForCard(card), forState: UIControlState.Normal);
            cardButton.enabled = !card.matched;
            scoreLabel.text = "Score \(self.game.score)"
            considerationLabel.text = currentMessage;
        }
    }
    func titleForCard(card:Card) -> String{
        return card.chosen ? card.contents : "";
    }
    func backgroundImageForCard(card:Card) -> UIImage{
        return UIImage(named: card.chosen ? "cardfront" : "cardback");
    }
    func resetGame(){
        _game = nil;
        modeButton.userInteractionEnabled = true;
        updateUI();
    }
    
}

