//
//  ViewController.swift
//  ios-integration-demo
//
//  Created by James Grom on 2/25/23.
//

import UIKit

let AuthilloInstance = Authillo(clientId: "CffyNFDb5MDQTVCkOeCyzMyMTEE1hh7SGBAQjeMmFz4")

let ScopesInstance = ScopesManager()

class MainViewController: UIViewController {
    
    
    @IBOutlet weak var codeChallengeLabel: UILabel!
    @IBOutlet weak var userInfoLabel: UILabel!
    
    @IBAction func GetCodeButtonClicked(_ sender: UIButton) {
        AuthilloInstance.GetCodeChallenge(uiCallback: { codeChallengeTxt in
            self.codeChallengeLabel.text = "Got Code Challenge:\n\(codeChallengeTxt)"
        })
    }
    @IBAction func LogInClicked(_ sender: UIButton) {
        //        AuthilloInstance.AuthorizeUser(scopes: [.license], state: "")
                AuthilloInstance.AuthorizeUser(scopes: ScopesInstance.getActiveScopes(), state: nil, redirectURI: nil)
    }
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        codeChallengeLabel.text = ""
    }


    @IBAction func goToConfigurationsPressed(_ sender: Any) {
        performSegue(withIdentifier: "MainVCToTogglersVC", sender: self)
        
    }
    
//
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "MainVCToTogglersVC" {
//            let togglersVC = segue.destination as! TogglersViewController
//        }
//    }
}

