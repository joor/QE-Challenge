//
//  AppDelegate.swift
//  QE Challenge
//
//  Created by Austin Feight on 11/19/18.
//  Copyright © 2018 JOOR. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?
  
  private var homeVC: HomeViewController?
  
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
     let window = UIWindow(frame: UIScreen.main.bounds)
    
    if UserDefaults.standard.bool(forKey: UserDefaultsKeys.isLoggedIn) {
      window.rootViewController = homeViewController
    }
    else {
      let loginVC = LoginViewController()
      loginVC.onComplete = { [weak self, weak loginVC] in
        guard let strongSelf = self else { return }
        
        UserDefaults.standard.set(true, forKey: UserDefaultsKeys.isLoggedIn)
        loginVC?.present(strongSelf.homeViewController, animated: true, completion: nil)
      }

      window.rootViewController = loginVC
    }
    
    window.makeKeyAndVisible()
    self.window = window
    return true
  }
  
  func applicationWillResignActive(_ application: UIApplication) {
    exit(0)
  }
}

// MARK: - Helpers
private extension AppDelegate {
  var homeViewController: UIViewController {
    let homeVC = HomeViewController()
    self.homeVC = homeVC

    homeVC.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Log Out",
                                                              style: .plain,
                                                              target: self,
                                                              action: #selector(logout))
    
    return UINavigationController(rootViewController: homeVC)
  }
  
  @objc func logout()
  {
    homeVC?.reset()
    UserDefaults.standard.set(false, forKey: UserDefaultsKeys.isLoggedIn)
    
    if window?.rootViewController is LoginViewController {
      window?.rootViewController?.dismiss(animated: true, completion: nil)
    }
    else {
      let loginVC = LoginViewController()
      loginVC.onComplete = { [weak self] in
        UserDefaults.standard.set(true, forKey: UserDefaultsKeys.isLoggedIn)
        self?.window?.rootViewController?.dismiss(animated: true, completion: nil)
      }
      
      window?.rootViewController?.present(loginVC, animated: true, completion: nil)
    }
  }
}
