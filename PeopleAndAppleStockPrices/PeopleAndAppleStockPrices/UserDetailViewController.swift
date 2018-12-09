//
//  PoepleDetailViewController.swift
//  PeopleAndAppleStockPrices
//
//  Created by Ibraheem rawlinson on 12/7/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import UIKit

class UserDetailViewController: UIViewController {
    //Outlets
    @IBOutlet weak var userImg: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userEmail: UILabel!
    @IBOutlet weak var userLocation: UILabel!
    //variables
    var usersIExpect: UserInfo!
    override func viewDidLoad() {
        super.viewDidLoad()
        do {
            let imgData = try Data(contentsOf: usersIExpect.picture.large)
            userImg.image = UIImage(data: imgData)
        } catch {
            print("error is: \(error)")
        }
        userName.text = "\(usersIExpect.name.first) \(usersIExpect.name.last)"
        userEmail.text = usersIExpect.email
        userLocation.text = usersIExpect.location.city
        
        
    }
    
    
   
}
