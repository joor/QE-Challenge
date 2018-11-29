//
//  LoginViewController.swift
//  QE Challenge
//
//  Created by Austin Feight on 11/19/18.
//  Copyright © 2018 JOOR. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
  @IBOutlet private weak var usernameField: UITextField!
  @IBOutlet private weak var passwordField: UITextField!
  
  convenience init() { self.init(nibName: nil, bundle: nil) }
  
  var onComplete: (() -> Void)?
}

// MARK: - UI Actions
extension LoginViewController {
  @IBAction func loginTapped(_ sender: Any)
  {
    guard let username = usernameField.text,
          let password = passwordField.text
      else { return showEnterUsernameAndPasswordError() }
    
    let validLogins = [
      "Austin": "super_secret_password",
      "Pooja": "test_password1"
    ]
    
    if validLogins[username] == password {
      onComplete?()
    }
    else {
      showIncorrectCredentialsError()
    }
    
    usernameField.text = nil
    passwordField.text = nil
  }
}

// MARK: - Helpers
private extension LoginViewController {
  private func login()
  {
    UserDefaults.standard.set(true, forKey: UserDefaultsKeys.isLoggedIn)
    present(HomeViewController(), animated: true, completion: nil)
  }
  
  private func showEnterUsernameAndPasswordError()
  {
    let alert = UIAlertController(title: nil,
                                  message: "Please fill in a value for both username and password",
                                  preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
    present(alert, animated: true, completion: nil)
  }
  
  private func showIncorrectCredentialsError()
  {
    let alert = UIAlertController(title: "Incorrect credentials",
                                  message: nil,
                                  preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
    present(alert, animated: true, completion: nil)
  }
}
