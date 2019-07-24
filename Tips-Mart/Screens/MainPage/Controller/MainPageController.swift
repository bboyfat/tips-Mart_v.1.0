//
//  MainPageControllerViewController.swift
//  Tips-Mart
//
//  Created by Andrey Petrovskiy on 7/8/19.
//  Copyright © 2019 Andrey Petrovskiy. All rights reserved.
//

import UIKit

class MainPageController: UIViewController {
    //MARK: Properties
    @IBOutlet weak var mainView: MainPageView!
    @IBOutlet weak var collectionBanerView: UICollectionView!
    
    //MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionBanerView.delegate = self
        collectionBanerView.dataSource = self
        addGesturetoStack()
        
    }
    
    //MARK: Methods
    func addGesturetoStack(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(handlePresent))
        mainView.profileStackView.addGestureRecognizer(tap)
    }
    // presenting of profile screen
    @objc func handlePresent(){
    
        let vc = UIStoryboard(name: "Profile", bundle: nil).instantiateViewController(withIdentifier: "ProfileNavigation") 
        present(vc, animated: true, completion: nil)
        
        
    }
}
extension MainPageController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) 
        
        return cell
    }
    
    
}

extension MainPageController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.collectionBanerView.frame.width, height: self.collectionBanerView.frame.height)
    }
}
