//
//  SetFindingGame.swift
//  Matchismo
//
//  Created by Karol Baginski on 16/08/2014.
//  Copyright (c) 2014 Karol Baginski. All rights reserved.
//

class SetFindingGame : CardMatchingGame {
    let SET_MATCH_BONUS = 2
    let SET_COST_TO_CHOOSE = 0
    let SET_MISMATCH_PENALTY = 10
    
    override func chooseCardAtIndex(index:Int) -> FlipResult {
        var card = cards[index]
        var message = card.contents;
        if !card.matched{
            if card.chosen{
                card.chosen = false;
                message = "";
            }else{
                var cardsToMatch:[Card] = [Card]();
                for otherCard in cards{
                    if otherCard.chosen && !otherCard.matched{
                        cardsToMatch.append(otherCard)
                    }
                }
                if(cardsToMatch.count > 1){
                    var matchScore = card.match(cardsToMatch);
                    message = "";
                    if matchScore > 0 {
                        score += matchScore * SET_MATCH_BONUS;
                        card.matched = true;
                        message += "Matched \(card.contents)"
                        for card in cardsToMatch
                        {
                            card.matched = true;
                            message += "\(card.contents) "
                        }
                        message += "for \(matchScore * SET_MATCH_BONUS) points."
                    }else{
                        score -= SET_MISMATCH_PENALTY
                        message += "\(card.contents) ";
                        for card in cardsToMatch
                        {
                            card.chosen = false;
                            message += "\(card.contents) ";
                        }
                        message += "don’t match! \(SET_MISMATCH_PENALTY) point penalty!"                        
                    }
                }
                score -= SET_COST_TO_CHOOSE;
                card.chosen = true;
            }
        }
        return FlipResult();
    }
}
