//
//  ViewController.swift
//  EggTimer
//
//  Created by Newarpunk on 3/10/20.
//  Copyright © 2020 Akash Stha. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var homeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for:.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.layoutIfNeeded()
        self.navigationController?.navigationBar.tintColor = UIColor.black
        
        
        
        let yourBackImage = UIImage(named: "left-arrow-angle")
        self.navigationController?.navigationBar.backIndicatorImage = yourBackImage
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = yourBackImage
        homeButton.layer.cornerRadius = 25
    }

    @IBAction func homeButtonClicked(_ sender: UIButton) {
        let vc = UIStoryboard(name: "MenuPage", bundle: nil).instantiateViewController(withIdentifier: "MenuPageViewController") as! MenuPageViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

