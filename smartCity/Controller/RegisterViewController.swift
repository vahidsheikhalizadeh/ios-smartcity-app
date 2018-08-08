//
//  RegisterViewController.swift
//  smartCity
//
//  Created by shick on 28.05.18.
//  Copyright © 2018 vahid. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

class RegisterViewController: UIViewController {

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
    

    
    @IBAction func registerButtonPressed(_ sender: AnyObject) {
        
        SVProgressHUD.show()
        //TODO: Set up a new user on our Firbase database
        
        Auth.auth().createUser(withEmail: emailTextField.text! , password: passwordTextField.text!) {
            
            // closure code which passed as a input parameter to createUser(). input: (user,error) after in is the cloosure body
            (user, error) in
            if error != nil {
                print(error!)
            }
            else {
                //SUCCESS
                print("Registration Successfull")
                
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
