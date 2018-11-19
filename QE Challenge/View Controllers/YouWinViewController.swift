//
//  YouWinViewController.swift
//  QE Challenge
//
//  Created by Austin Feight on 11/19/18.
//  Copyright © 2018 JOOR. All rights reserved.
//

import UIKit

class YouWinViewController: UIViewController {
  convenience init() { self.init(nibName: nil, bundle: nil) }
  
  
  @IBAction func okTapped(_ sender: Any)
  {
    dismiss(animated: true, completion: nil)
  }
}
