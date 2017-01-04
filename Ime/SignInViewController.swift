//
//  SignInViewController.swift
//  Ime
//
//  Created by Avinash Reddy on 12/26/16.
//  Copyright © 2016 Avinash Reddy. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class SignInViewController: UIViewController {
    
    // IBOutlets for the SignInVC
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    @IBAction func turnUpTapped(_ sender: Any) {
        // Action of statements
        
        FIRAuth.auth()?.signIn(withEmail: emailTextField.text!, password: passwordTextField.text!, completion: { (user, error) in
            if error != nil {
                print("Avinash error: \(error?.localizedDescription)")
                FIRAuth.auth()?.createUser(withEmail: self.emailTextField.text!, password: self.passwordTextField.text!, completion: { (user, error) in
                    if error != nil {
                        print("Avinash error: \(error?.localizedDescription)")
                    } else {
                        print("Avinash: Signed Up Successfully")
                        
                        FIRDatabase.database().reference().child("users").child(user!.uid).child("email").setValue(user!.email!)    
                        
                        self.performSegue(withIdentifier: signInSegue, sender: nil)
                    }
                })
            } else {
                print("Avinash: Signed In Successfully")
                self.performSegue(withIdentifier: signInSegue, sender: nil)
            }
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

