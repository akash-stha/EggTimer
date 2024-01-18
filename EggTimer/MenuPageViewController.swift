//
//  MenuPageViewController.swift
//  EggTimer
//
//  Created by Newarpunk on 3/10/20.
//  Copyright © 2020 Akash Stha. All rights reserved.
//

import UIKit

class MenuPageViewController: UIViewController {
    
    @IBOutlet weak var menuCollectionView: UICollectionView!
    @IBOutlet weak var customTimerButton: UIButton!
    
    var eggName = ["SOFT", "MEDIUM","HARD", "WELLDONE"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Hide navbar but keep the back button
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for:.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.layoutIfNeeded()
        self.navigationController?.navigationBar.tintColor = UIColor.black
        customTimerButton.layer.cornerRadius = 30
        menuCollectionView.delegate = self
        menuCollectionView.dataSource = self
    }
    
}

extension MenuPageViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return eggName.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "eggCell", for: indexPath) as! MenuCollectionViewCell
        cell.nameLabel.text = eggName[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = UIStoryboard(name: "Timer", bundle: nil).instantiateViewController(withIdentifier: "TimerViewController") as! TimerViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
