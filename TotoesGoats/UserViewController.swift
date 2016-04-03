//
//  UserViewController.swift
//  TotoesGoats
//
//  Created by Paviya Tojaroon on 4/3/16.
//  Copyright © 2016 Daniel Hauagge. All rights reserved.
//

import UIKit
import RealmSwift

class UserViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    
    var user = User()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.usernameTextField.delegate = self
        self.passwordTextField.delegate = self
        
        doneButton.enabled = false
        saveButton.enabled = false
        
        validateValues()
    }
    
    func validateValues() {
        let username = usernameTextField.text!
        let password = passwordTextField.text!
        
        print("validateValues is called")
        
        print("username = \(!username.isEmpty)")
        print("password = \(!password.isEmpty)")
        
        
        if (!username.isEmpty) && (!password.isEmpty) {
            doneButton.enabled = true
            saveButton.enabled = true
        }
        
    }
    
    func exitView() { // need to move to the next view
        self.performSegueWithIdentifier("cameraSegue", sender: nil)
    }
    
    
    // MARK: - Actions
    @IBAction func doneButtonClicked(sender: AnyObject) {
        let realm = try! Realm()
        
        try! realm.write {
            user.username = usernameTextField.text!
            user.password = passwordTextField.text!
            realm.add(user, update: true)
        }
        print("\(realm.objects(User).count) users in DB")
        
        exitView()
    }
    
    @IBAction func signInButtonClicked(sender: AnyObject) {
        let realm = try! Realm()
        
        for object in realm.objects(User) {
            if usernameTextField.text! == object.username && passwordTextField.text! == object.password {
                exitView()
            }
        }
        
        self.showAlert("ERROR", description: "Wrong username or password!")
        
    }
    
    func showAlert(message: String?, description: String?) {
        let alertController = UIAlertController(title: message, message: description, preferredStyle: .Alert) // . is the short for UIAlertControll.Alert
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: { (action) -> Void in
        }))
        alertController.view.frame = CGRect(x: 0, y: 0, width: 340, height: 450)
        presentViewController(alertController, animated: true, completion: nil) //idc if it completes
    }
    
    
    // MARK: - Dismissing the keyboard
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        usernameTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        print("updating validateValues")
        validateValues()
    }
    
    @IBAction func unwindToMainView (sender: UIStoryboardSegue) {
        
    }
    
}
