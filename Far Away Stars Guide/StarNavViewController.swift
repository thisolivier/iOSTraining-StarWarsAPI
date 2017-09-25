//
//  StarNavViewController.swift
//  Far Away Stars Guide
//
//  Created by Olivier Butler on 24/09/2017.
//  Copyright © 2017 Olivier Butler. All rights reserved.
//

import UIKit

class StarNavViewController: UINavigationController{
    override func viewDidLoad() {
        let barAppearence = UINavigationBar.appearance()
        barAppearence.largeTitleTextAttributes = [NSAttributedStringKey.foregroundColor:UIColor.yellow]
    }
}
