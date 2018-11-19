//
//  HomeViewController.swift
//  QE Challenge
//
//  Created by Austin Feight on 11/19/18.
//  Copyright © 2018 JOOR. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
  @IBOutlet private weak var valueLabel: UILabel!
  @IBOutlet private weak var stepper: UIStepper!
  
  var bug = false
  
  convenience init() { self.init(nibName: nil, bundle: nil) }
  
  override func viewDidLoad()
  {
    super.viewDidLoad()
    
    setCurrentValue()
  }

  @IBAction private func stepperTapped(_ sender: UIStepper)
  {
    let value = Int(sender.value)
    UserDefaults.standard.set(value, forKey: UserDefaultsKeys.currentValue)
    
    if value == 5 {
      bug = !bug
      if bug {
        return
      }
    }
    
    if value == 10 {
      youWin()
      return
    }
    
    valueLabel.text = "\(value)"
  }
}

// MARK: - Helpers
private extension HomeViewController {
  func setCurrentValue()
  {
    let value = UserDefaults.standard.integer(forKey: UserDefaultsKeys.currentValue)
    stepper.value = Double(value)
  }
  
  func youWin()
  {
    UserDefaults.standard.set(0, forKey: UserDefaultsKeys.currentValue)
    stepper.value = 0
    valueLabel.text = "0"
    
    present(YouWinViewController(), animated: true, completion: nil)
  }
}
