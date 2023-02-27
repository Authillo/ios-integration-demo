//
//  ViewController.swift
//  ios-integration-demo
//
//  Created by James Grom on 2/25/23.
//

import UIKit
let AuthilloInstance = Authillo(clientId: "CffyNFDb5MDQTVCkOeCyzMyMTEE1hh7SGBAQjeMmFz4")

class ViewController: UIViewController {
    @IBAction func LoginButtonClicked(_ sender: UIButton) {
//        AuthilloInstance.AuthorizeUser(scopes: [.license], state: "")
        AuthilloInstance.AuthorizeUser(scopes: [.license], state: nil, codeChallenge: nil, redirectURI: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

