//
//  TogglersViewController.swift
//  ios-integration-demo
//
//  Created by Daniel Ziems on 2/28/23.
//

import UIKit

class TogglersViewController: UIViewController {
    
    var dismissHandler: ((ScopesManager) -> Void)?
    
    @IBOutlet weak var nameSwitch: UISwitch!
    @IBOutlet weak var ageSwitch: UISwitch!
    @IBOutlet weak var faceSwitch: UISwitch!
    @IBOutlet weak var selfieSwitch: UISwitch!
    @IBOutlet weak var idphotoSwitch: UISwitch!
    @IBOutlet weak var emailSwitch: UISwitch!
    @IBOutlet weak var phoneSwitch: UISwitch!
    @IBOutlet weak var licenseSwitch: UISwitch!
    @IBOutlet weak var sexSwitch: UISwitch!
    @IBOutlet weak var birthdateSwitch: UISwitch!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for (scope, val) in ScopesInstance.scopes {
            switch (scope) {
            case .age: ageSwitch.isOn = val
            case .birthdate: birthdateSwitch.isOn = val
            case .email: emailSwitch.isOn = val
            case .face: faceSwitch.isOn = val
            case .idphoto: idphotoSwitch.isOn = val
            case .license: licenseSwitch.isOn = val
            case .name: nameSwitch.isOn = val
            case .phone: phoneSwitch.isOn = val
            case .selfie: selfieSwitch.isOn = val
            case .sex: sexSwitch.isOn = val
            }
        }
    }
    
    
    @IBAction func dismissPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func savePressed(_ sender: UIButton) {
        ScopesInstance.scopes[.age] = ageSwitch.isOn
        ScopesInstance.scopes[.birthdate] = birthdateSwitch.isOn
        ScopesInstance.scopes[.email] = emailSwitch.isOn
        ScopesInstance.scopes[.face] = faceSwitch.isOn
        ScopesInstance.scopes[.idphoto] = idphotoSwitch.isOn
        ScopesInstance.scopes[.license] = licenseSwitch.isOn
        ScopesInstance.scopes[.name] = nameSwitch.isOn
        ScopesInstance.scopes[.phone] = phoneSwitch.isOn
        ScopesInstance.scopes[.selfie] = selfieSwitch.isOn
        ScopesInstance.scopes[.sex] = sexSwitch.isOn
        
        dismiss(animated: true, completion: nil)
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
