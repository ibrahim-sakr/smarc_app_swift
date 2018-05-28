//
//  HomeSidebarVC.swift
//  SmarcHome
//
//  Created by Ibrahim Saqr on 5/6/18.
//  Copyright © 2018 Ibrahim Saqr. All rights reserved.
//

import UIKit

class HomeSidebarVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var sidebarProfileView: SidebarProfileView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.sidebarProfileView.origin = self
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // return tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        return UITableViewCell()
    }

}
