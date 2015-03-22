//
//  ViewController.swift
//  Matchismo
//
//  Created by Karol Baginski on 10/08/2014.
//  Copyright (c) 2014 Karol Baginski. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIGestureRecognizerDelegate {
    let TWO_CARDS = 0;
    let THREE_CARDS = 1;
    let CARD_COUNT = 32;
    
    var cards = [CardView]()
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var modeButton: UIView!
    @IBOutlet weak var cardsView: UIView!
    var grid = Grid();
    
    var _game:CardMatchingGame?;
    var game:CardMatchingGame{
        get{
            if _game == nil
            {
                _game = CardMatchingGame(cardCount: 81, deck: createDeck());
            }
            return _game!;
        }
    }
    
    @IBAction func redealButton(sender: UIButton) {
        resetGame();
    }
    
    @IBAction func changeMode(sender: UISegmentedControl) {
        game.mode = sender.selectedSegmentIndex;
    }
    
    override func viewDidAppear(animated: Bool) {
        setupGrid();
        createCards(animated: true)
        dealCards();
    }
    
    override func didRotateFromInterfaceOrientation(fromInterfaceOrientation: UIInterfaceOrientation) {
        refreshLayout();
    }
    
    
    func updateUI(){
        updateCardsState();
        scoreLabel.text = "Score \(self.game.score)"
    }
    
    func resetGame(){
        _game = nil;
        if(modeButton != nil){
            modeButton.userInteractionEnabled = true;
        }
        removeAllCards();
        createCards(animated: true);
        dealCards();
    }
    
    func setupGrid(){
        grid = Grid();
        grid.cellAspectRatio = 0.70;
        grid.size = cardsView.bounds.size;
        var sizeView = cardsView.bounds.size;
        var superViewSize = cardsView.superview?.bounds.size
        grid.minimumNumberOfCells = UInt(CARD_COUNT);
    }
    
    func createCards(animated:Bool = false){
        cards = [CardView]();
        var index = 0;
        for card in game.cards {
            var cardView = createCardView(card)
            cardView.cardIndex = index;
            index++;
            cardsView.addSubview(cardView)
            cardView.frame = grid.frameOfCellAtRow(0, inColumn: 0);
            cardView.setNeedsDisplay();
            cards.append(cardView);
        }
    }
    
    func refreshLayout(){
        setupGrid()
        var numberOfRows = Int(grid.rowCount);
        var numberOfColumns = Int(grid.columnCount);
        var column = 0;
        var row = 0;
        
        var frame = grid.frameOfCellAtRow(UInt(0), inColumn: UInt(0));
        
        for v in cardsView.subviews {
            var center = grid.centerOfCellAtRow(UInt(row), inColumn: UInt(column));
            var cardView = v as CardView
            cardView.frame = frame;
            cardView.center = center;
            cardView.setNeedsDisplay();
            
            if(column == numberOfColumns - 1){
                column = 0;
                row++;
            }
            else{
                column++;
            }
        }
    }
    
    func dealCards(){
        var numberOfRows = Int(grid.rowCount);
        var numberOfColumns = Int(grid.columnCount);
        var column = 0;
        var row = 0;
        
        var frame = grid.frameOfCellAtRow(UInt(0), inColumn: UInt(0));
        
        for v in cards {
            var center = grid.centerOfCellAtRow(UInt(row), inColumn: UInt(column));
            var cardView = v as CardView
            
            UIView.animateWithDuration(0.5,
                delay:0,
                options: nil,
                animations:{
                    cardView.frame = frame;
                    cardView.center = center;
                    cardView.setNeedsDisplay();
                },
                completion:{ (finished:Bool) in });
            
            if(column == numberOfColumns - 1){
                column = 0;
                row++;
            }
            else{
                column++;
            }
        }
    }
    
    
    func createCardView(card : Card) -> CardView{
        var cardView = PlayingCardView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        var playingCard = card as PlayingCard;
        
        cardView.rank = PlayingCard.rankStrings[playingCard.rank];
        cardView.suit = playingCard.suit;
        cardView.faceUp = false;
        
        var tapGesture = UITapGestureRecognizer(target: self, action: Selector("tap:"))
        tapGesture.delegate = self
        cardView.addGestureRecognizer(tapGesture)
        
        return cardView;
    }
    
    func updateCardsState(){
        for v in cardsView.subviews {
            var cardView = v as PlayingCardView
            var index  = cardView.cardIndex;
            var card = self.game.cardAtIndex(index) as PlayingCard;
            
            UIView.transitionWithView(cardView,
                duration:0.5,
                options: nil,
                animations:{
                    if (cardView.faceUp && !card.chosen) {
                        cardView.faceUp = false
                    }else if(!cardView.faceUp && card.chosen){
                        
                    }
                    cardView.setNeedsDisplay();
                },
                completion:{ (finished:Bool) in });
            if(card.matched){
                for gr in cardView.gestureRecognizers{
                    if(gr is UITapGestureRecognizer){
                        cardView.removeGestureRecognizer(gr as UIGestureRecognizer);
                    }
                }
                cardView.userInteractionEnabled = false;
                cardView.alpha = 0.6;
            }
        }
    }
    
    func collectAllCards(){
        UIView.animateWithDuration(1, delay: 0, options: nil, animations: {
            for cardView in self.cardsView.subviews {
                var c = cardView as PlayingCardView
                var center = self.grid.centerOfCellAtRow(0, inColumn: 0)
                c.center = center;
                c.faceUp = false;
                c.setNeedsDisplay();
            }
            }, completion: { (finished : Bool) -> Void in
                self.removeAllCards();
        })
    }
    
    func removeAllCards(){
        for cardView in cards {
            var c = cardView as PlayingCardView
            var center = self.grid.centerOfCellAtRow(0, inColumn: 0)
            
            UIView.animateWithDuration(1, delay: 0, options: nil, animations: {
                c.center = center;
                c.faceUp = false;
                c.setNeedsDisplay();
                }, completion: { (finished : Bool) -> Void in
                    c.removeFromSuperview();
            })
        }
    }
    
    func createDeck() -> Deck{
        return PlayingCardDeck()
    }
    
    func tap(sender:UITapGestureRecognizer){
        var v = sender.view as PlayingCardView
        if sender.state == UIGestureRecognizerState.Ended {
            var index = v.cardIndex;
            var card = self.game.cardAtIndex(index);
            
            if(!card!.matched){
                self.game.chooseCardAtIndex(index)
                UIView.transitionWithView(v,
                    duration:0.5,
                    options: UIViewAnimationOptions.TransitionFlipFromLeft,
                    animations:{
                        v.faceUp = !v.faceUp;
                        v.setNeedsDisplay();
                    },
                    completion:{ (finished:Bool) in
                        self.updateUI();
                });
            }
        }
    }
    
    func getMessage(flipResult : FlipResult) -> NSMutableAttributedString{
        var string = NSMutableAttributedString()
        var stringRaw = String()
        switch flipResult.type{
        case .Flip:
            for c in flipResult.cards{
                stringRaw += "Selected \(c.contents)"
            }
        case .None:
            stringRaw = "Flipped back"
        case .UnsuccesfullMatch:
            for c in flipResult.cards{
                stringRaw += "\(c.contents)"
            }
            stringRaw += "don’t match! \(flipResult.points) point penalty!"
        case .SuccessfulMatch:
            stringRaw += "Matched "
            for c in flipResult.cards{
                stringRaw += "\(c.contents)"
            }
            stringRaw += "for \(flipResult.points) points."
        }
        string = NSMutableAttributedString(string: stringRaw);
        return string;
    }
    
    func titleForCard(card:Card) -> String{
        return card.chosen ? card.contents : "";
    }
    
    func backgroundImageForCard(card:Card) -> UIImage{
        return UIImage(named: card.chosen ? "cardfront" : "cardback");
    }
    
}

