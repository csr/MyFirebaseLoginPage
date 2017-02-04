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

class MessagesController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        // Creates logout button at the top left of the navigation controller.
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(handleLogout))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(handleNewMessage))
        
        checkIfUserIsLoggedIn()
    }
    
    func handleNewMessage() {
        let newMessageController = NewMessageController()
        let navController = UINavigationController(rootViewController: newMessageController)
        present(navController, animated: true, completion: nil)
    }
    
    func checkIfUserIsLoggedIn() {
        let UserUid = FIRAuth.auth()?.currentUser?.uid
        
        if UserUid == nil {
            performSelector(onMainThread: #selector(handleLogout), with: nil, waitUntilDone: true)
        } else {
            // Fetch of a single value.
            FIRDatabase.database().reference().child("users").child(UserUid!).observe(.value, with: {
            (snapshot) in
                
                if let dictionary = snapshot.value as? [String: AnyObject] {
                    self.navigationItem.title = dictionary["name"] as? String
                } else {
                    print("error! snapshot value: \(snapshot.value)")
                }
                print(snapshot)
            })
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

