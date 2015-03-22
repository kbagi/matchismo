//
//  SetViewController.swift
//  Matchismo
//
//  Created by Karol Baginski on 16/08/2014.
//  Copyright (c) 2014 Karol Baginski. All rights reserved.
//

import UIKit

class SetViewController: ViewController {
//    
    override var game:CardMatchingGame{
        get{
            if _game == nil
            {
                _game = SetFindingGame(cardCount: 81, deck: createDeck());
            }
            return _game!;
        }
    }
    
    var _symbol : SetCard.Symbol?;
    var symbol : SetCard.Symbol{
        get{
            if(_symbol == nil){
                _symbol = SetCard.Symbol();
            }
            return _symbol!;
        }
        set(newValue){
            _symbol = newValue;
        }
    }

    
    override func setupGrid(){
        
    }
    
    override func createCards(animated: Bool = true){
        
    }
    
    override func dealCards(){
        
    }
//
//    //    override func touchCardButton(sender: UIButton) {
//    //        var chosenButtonIndex = find(cardButtons!, sender)!;
//    //        var message = game.chooseCardAtIndex(chosenButtonIndex);
//    //        messageHistory.append(currentMessage);
//    //        updateUI();
//    //    }
//    
//    override func resetGame() {
//        super.resetGame()
//        for cardButton in cardButtons{
//            var cardButtonIndex = find(cardButtons!, cardButton)!;
//            setCardContents(cardButton, card: game.cards[cardButtonIndex] as SetCard)
//        }
//    }
//    
//    override func updateUI() {
//        redrawCards();
//        scoreLabel.text = "Score \(self.game.score)"
//        considerationLabel.attributedText = currentMessage;
//        var m = currentMessage.string;
//        
//    }
//    
    override func createDeck() -> Deck{
        return SetDeck()
    }
//    override func viewWillAppear(animated: Bool) {
//        redrawCards()    }
//    
//    func redrawCards(){
//        for cardButton in cardButtons{
//            var cardButtonIndex = find(cardButtons!, cardButton)!;
//            var card  = game.cards[cardButtonIndex];
//            setCardContents(cardButton, card: card as SetCard)
//            if card.chosen && !card.matched
//            {
//                cardButton.layer.borderColor = UIColor.blackColor().CGColor;
//                cardButton.layer.borderWidth = 3;
//            }else if card.matched{
//                cardButton.enabled = false;
//                cardButton.layer.borderWidth = 0;
//            }else{
//                cardButton.layer.borderWidth = 0;
//            }
//        }
//    }
//    
//    func setCardContents(button:UIButton, card : SetCard){
//        var symbols = getCardContents(card)
//        button.setAttributedTitle(symbols, forState: UIControlState.Normal)
//    }
//    
//    override func getMessage(flipResult : FlipResult) -> NSMutableAttributedString{
//        var string = NSMutableAttributedString()
//        var stringRaw = String()
//        switch flipResult.type{
//        case .Flip:
//            for c in flipResult.cards{
//                string.appendAttributedString(getCardContents(c as SetCard))
//            }
//        case .None:
//            stringRaw = "Flipped back ";
//            string.appendAttributedString(NSAttributedString(string: stringRaw));
//        case .UnsuccesfullMatch:
//            for c in flipResult.cards{
//                string.appendAttributedString(getCardContents(c as SetCard))
//                 string.appendAttributedString(NSMutableAttributedString(string: " "))
//            }
//            stringRaw = " don’t match! \(flipResult.points) point penalty!"
//            string.appendAttributedString(NSAttributedString(string: stringRaw));
//        case .SuccessfulMatch:
//            stringRaw = "Matched "
//            string.appendAttributedString(NSAttributedString(string: stringRaw));
//            for c in flipResult.cards{
//                string.appendAttributedString(getCardContents(c as SetCard))
//                 string.appendAttributedString(NSMutableAttributedString(string: " "))
//            }
//            stringRaw = " for \(flipResult.points) points."
//            string.appendAttributedString(NSAttributedString(string: stringRaw));
//        }
//        //string = NSMutableAttributedString(string: stringRaw);
//        return string;
//    }
//    
//    func getCardContents(setCard : SetCard) -> NSMutableAttributedString{
//        var dic:NSMutableDictionary = NSMutableDictionary()
//        var symbolRaw:String = ""
//        var colour = UIColor.greenColor();
//        
//        for index in 1...setCard.count! {
//            switch setCard.symbol! {
//            case .Diamond:
//                symbolRaw += "▲"
//            case .Oval:
//                symbolRaw += "●"
//            case .Squiggle:
//                symbolRaw += "■"
//            }
//        }
//        
//        switch setCard.colour! {
//        case .Green:
//            colour = UIColor.greenColor()
//        case .Purple:
//            colour = UIColor.purpleColor();
//        case .Red:
//            colour = UIColor.redColor();
//        }
//        
//        switch setCard.shading! {
//        case .Open:
//            dic[NSForegroundColorAttributeName] = colour.colorWithAlphaComponent(0);
//            dic[NSStrokeColorAttributeName] = colour;
//            dic[NSStrokeWidthAttributeName] = -5;
//        case .Solid:
//            dic[NSForegroundColorAttributeName] = colour.colorWithAlphaComponent(1);
//            dic[NSStrokeColorAttributeName] = colour;
//            dic[NSStrokeWidthAttributeName] = -5;
//        case .Striped:
//            dic[NSForegroundColorAttributeName] = colour.colorWithAlphaComponent(0.3);
//            dic[NSStrokeColorAttributeName] = colour;
//            dic[NSStrokeWidthAttributeName] = -5;
//        }
//        
//        var symbols:NSMutableAttributedString = NSMutableAttributedString(string: symbolRaw, attributes: dic)
//        
//        return symbols
//    }
//    
}
