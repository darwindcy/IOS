//
//  HelpViewController.swift
//  CallBreak
//
//  Created by Yadav, Darwin on 12/4/19.
//  Copyright © 2019 Yadav, Darwin. All rights reserved.
//

import Foundation
import UIKit

class HelpViewController: UIViewController {
    
    @IBOutlet weak var MainText: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        MainText.text = "This game is Call Break.\nYou have to call how many hands you think you are going to win.\nThe player with maximum hands wins.\nYou have to call your score and try to break other's scores.\nGood Luck!"
        
    }
}

