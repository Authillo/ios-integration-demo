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
    
    
    @IBOutlet weak var requestUserInfoButton: UIButton!
    @IBOutlet weak var userInfoLabel: UILabel!
    
    @IBAction func LogInClicked(_ sender: UIButton) {
        print("CHOSEN SCOPES: \(ScopesInstance.getActiveScopes())");
        AuthilloInstance.RunLogin(scopes: ScopesInstance.getActiveScopes(), state: nil, redirectURI: nil);
    }
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        requestUserInfoButton.isHidden = true
        
        if let scene = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
            scene.initialCallback = {
                message in DispatchQueue.main.async {
                    self.userInfoLabel.text = message
                }
            }
            
            scene.responseCallback = {
                responseDict in DispatchQueue.main.async {
                    var wholeResponse = "";
                    for (key, value) in responseDict {
                        wholeResponse += "\(key) : \(value)\n"
                    }
                    self.userInfoLabel.text = wholeResponse
                    self.requestUserInfoButton.isHidden = false
                }
            }
        }
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

