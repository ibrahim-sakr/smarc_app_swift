//
//  HomeVC.swift
//  SmarcHome
//
//  Created by Ibrahim Saqr on 4/2/18.
//  Copyright © 2018 Ibrahim Saqr. All rights reserved.
//

import UIKit

class HomeVC: UIViewController, UIPopoverPresentationControllerDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var homeButtonsCV: UICollectionView!
    @IBOutlet weak var menuBtn: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = CoreConst.gray

        self.homeButtonsCV.delegate = self
        self.homeButtonsCV.dataSource = self

        // register open sidebar event to the button
        self.menuBtn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
    }

    /**
     * Collection View Methods
     */
    // Specifying the number of sections in the CollectionView
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    // Specifying the number of cells in given section
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return HomeButtonsData.count
    }

    // Display a Cell after init it
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.homeButtonsCV.dequeueReusableCell(withReuseIdentifier: CoreConst.HOME_BUTTONS_CELL_ID, for: indexPath) as! HomeButtonCell
        cell.updateView(name: HomeButtonsData[indexPath.row]["name"] as! String, background: HomeButtonsData[indexPath.row]["background"] as! UIColor)
        return cell
    }

    // when item selected handle it's action
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyBoard: UIStoryboard = UIStoryboard(name: HomeButtonsData[indexPath.row]["storyBoard"] as! String, bundle: nil)
        let nextVC = storyBoard.instantiateViewController(withIdentifier: HomeButtonsData[indexPath.row]["page"] as! String)
        self.present(nextVC, animated: true, completion: nil)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width / 2, height: self.view.frame.width / 2)
    }
}
