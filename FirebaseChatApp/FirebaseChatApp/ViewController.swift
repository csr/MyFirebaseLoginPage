//
//  ViewController.swift
//  FirebaseChatApp
//
//  Created by Cesare de Cal on 01/02/17.
//  Copyright © 2017 Cesare de Cal. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class ViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        // Creates logout button at the top left of the navigation controller.
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(handleLogout))
        
        if FIRAuth.auth()?.currentUser?.uid == nil {
            performSelector(onMainThread: #selector(handleLogout), with: nil, waitUntilDone: true)
        }
    }
    
    func handleLogout() {
        
        do {
            try FIRAuth.auth()?.signOut()
        } catch let logoutError {
            print(logoutError)
        }
        
        let loginController = LoginController()
        present(loginController, animated: true, completion: nil)
    }
}

