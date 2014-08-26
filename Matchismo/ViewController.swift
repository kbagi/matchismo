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
    
    @IBOutlet var cards: [PlayingCardView]!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var modeButton: UIView!
    @IBOutlet weak var cardsView: UIView!
    var grid = Grid();
    
    var _game:CardMatchingGame?;
    var game:CardMatchingGame{
        get{
            if _game == nil
            {
                _game = CardMatchingGame(cardCount: self.cards.count, deck: createDeck());
            }
            return _game!;
        }
    }
    
    @IBAction func touchCardButton(sender: UIButton) {
        var chosenButtonIndex = find(cardButtons!, sender)!;
        var flipResult = game.chooseCardAtIndex(chosenButtonIndex);
        if(modeButton != nil){
            modeButton.userInteractionEnabled = false;
        }
        updateUI();
    }
    
    @IBAction func redealButton(sender: UIButton) {
        resetGame();
    }
    
    @IBAction func changeMode(sender: UISegmentedControl) {
        resetGame();
        game.mode = sender.selectedSegmentIndex;
    }
    
    override func viewDidLoad() {
        setupGrid()
        var numberOfRows = Int(grid.rowCount);
        var numberOfColumns = Int(grid.columnCount);
        for var i = 0; i < numberOfRows; i++ {
            for var j = 0; j < numberOfColumns; j++ {
                var frame = grid.frameOfCellAtRow(UInt(i), inColumn: UInt(j));
                var center = grid.centerOfCellAtRow(UInt(i), inColumn: UInt(j));
                var cardView = PlayingCardView(frame: frame)
                var tapGesture = UITapGestureRecognizer(target: cardView, action: Selector("tap:"))
                tapGesture.delegate = self
                //cardView.gestureRecognizers.append()
                cardsView.addSubview(cardView)
            }
        }
        cardsView.contentMode = UIViewContentMode.ScaleToFill
    }
    
    func tap(){
        
    }
    
    func setupGrid(){
        grid = Grid();
        grid.cellAspectRatio = 0.65;
        grid.size = cardsView.bounds.size;
        var sizeView = cardsView.bounds.size;
        var superViewSize = cardsView.superview?.bounds.size
        grid.minimumNumberOfCells = 12;
        
    }
    
    override func didRotateFromInterfaceOrientation(fromInterfaceOrientation: UIInterfaceOrientation) {
        setupGrid();
        updateUI();
    }
    
    func createDeck() -> Deck{
        return PlayingCardDeck()
    }
    
    func updateUI(){
        var numberOfRows = Int(grid.rowCount);
        var numberOfColumns = Int(grid.columnCount);
        for var i = 0; i < numberOfRows; i++ {
            for var j = 0; j < numberOfColumns; j++ {
                var frame = grid.frameOfCellAtRow(UInt(i), inColumn: UInt(j));
                var center = grid.centerOfCellAtRow(UInt(i), inColumn: UInt(j));
                var cardView = PlayingCardView(frame: frame)
                
                
                cardsView.addSubview(cardView)
            }
        }
        scoreLabel.text = "Score \(self.game.score)"
        
    }
    
    func titleForCard(card:Card) -> String{
        return card.chosen ? card.contents : "";
    }
    
    func backgroundImageForCard(card:Card) -> UIImage{
        return UIImage(named: card.chosen ? "cardfront" : "cardback");
    }
    
    func resetGame(){
        _game = nil;
        if(modeButton != nil){
            modeButton.userInteractionEnabled = true;
        }
        updateUI();
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
}

