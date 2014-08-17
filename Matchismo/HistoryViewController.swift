//
//  HistoryViewController.swift
//  Matchismo
//
//  Created by Karol Baginski on 17/08/2014.
//  Copyright (c) 2014 Karol Baginski. All rights reserved.
//

import Foundation
import UIKit

class HistoryViewController : UIViewController {
    @IBOutlet var textView: UITextView!
    var messageHistory = [NSMutableAttributedString]();
    
    override func viewDidAppear(animated: Bool) {
        var counter : Int = 1;
        var ats = NSMutableAttributedString();
        for txt in messageHistory {
            ats.appendAttributedString(NSAttributedString(string: "\(counter)) "))
            ats.appendAttributedString(txt);
            ats.appendAttributedString(NSAttributedString(string: "\n"))
            counter++;
        }
        textView.attributedText = ats
    }
    
}