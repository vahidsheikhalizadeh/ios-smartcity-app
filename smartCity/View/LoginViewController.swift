//
//  LoginViewController.swift
//  smartCity
//
//  Created by shick on 28.05.18.
//  Copyright © 2018 vahid. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

class LoginViewController: UIViewController {

    
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginButtonPressed(_ sender: Any) {
        
        SVProgressHUD.show()
        
        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) {
            (user, error) in
            
            if error != nil {
                
                print(error!)
                let alert = UIAlertController(title: "Error", message: "login was not successful", preferredStyle: .alert)
                let action = UIAlertAction(title: "try again", style: .default, handler: { (alert) in
                    SVProgressHUD.dismiss()
                })
                alert.addAction(action)
                self.present(alert, animated: true, completion:nil)
            }
            else {
                
                print("login was successful")
                
                SVProgressHUD.dismiss()
                self.performSegue(withIdentifier: "goToSensors", sender: self)
                
            }
        }
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
