//
//  HomeVC.swift
//  SmarcHome
//
//  Created by Ibrahim Saqr on 4/2/18.
//  Copyright © 2018 Ibrahim Saqr. All rights reserved.
//

import UIKit

class HomeVC: UIViewController, UIPopoverPresentationControllerDelegate, UICollectionViewDelegate, UICollectionViewDataSource {
    
    private let homeButtons: [String] = ["lights", "users", "options", "cams", "Access Control"];

    @IBOutlet weak var homeButtonsCV: UICollectionView!
    @IBOutlet weak var testCommonView: SidebarUserSectionV!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Home VC Loaded");
        
        self.homeButtonsCV.delegate = self
        self.homeButtonsCV.dataSource = self
    }
    
    @IBAction func onLightBtnClicked(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Light", bundle: nil)
        let nextVC = storyBoard.instantiateViewController(withIdentifier: "LightIndex")
        self.present(nextVC, animated: true, completion: nil)
    }

    @IBAction func onUsersBtnClicked(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "User", bundle: nil)
        let nextVC = storyBoard.instantiateViewController(withIdentifier: "UserIndexList")
        self.present(nextVC, animated: true, completion: nil)
    }

    @IBAction func onLogoutBtmClicked(_ sender: Any) {
        AuthService.instance.logout();

        let storyBoard: UIStoryboard = UIStoryboard(name: "Core", bundle: nil)
        let nextVC = storyBoard.instantiateViewController(withIdentifier: "MainPage")
        self.present(nextVC, animated: true, completion: nil)
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
        let cell = self.homeButtonsCV.dequeueReusableCell(withReuseIdentifier: "homeButton", for: indexPath) as! HomeButtonCell
        cell.updateView(name: HomeButtonsData[indexPath.row]["name"] as! String, background: HomeButtonsData[indexPath.row]["background"] as! UIColor)
        return cell
    }

    // when item selected handle it's action
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyBoard: UIStoryboard = UIStoryboard(name: HomeButtonsData[indexPath.row]["storyBoard"] as! String, bundle: nil)
        let nextVC = storyBoard.instantiateViewController(withIdentifier: HomeButtonsData[indexPath.row]["page"] as! String)
        self.present(nextVC, animated: true, completion: nil)
    }
}
