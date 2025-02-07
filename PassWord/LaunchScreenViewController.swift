//
//  LaunchScreenViewController.swift
//  PassWord
//
//  Created by cmStudent on 2020/09/24.
//  Copyright © 2020 20cm0119. All rights reserved.
//

import UIKit

class LaunchScreenViewController: UIViewController {
    let userDefaults = UserDefaults.standard
    let lockScreenPass = UserDefaults.standard.string(forKey: "LockScreenPass")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
                
       override func viewDidAppear(_ animated: Bool) {
            //passがないならture
            if !userDefaults.bool(forKey: "switchStatus") || lockScreenPass == "" || lockScreenPass == nil {
                
                print(userDefaults.bool(forKey: "switchStatus"))
                //遷移先のStoryboardを設定
                let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                //遷移先のNavigationControllerを設定
                let navigationController = storyboard.instantiateViewController(withIdentifier: "Navigation") as! UINavigationController
                //モーダルをfullscreenに変更
                navigationController.modalPresentationStyle = .fullScreen
                print("go navigation")
                //遷移する
                self.present(navigationController, animated: true, completion: nil)

            } else {
                //遷移先のStoryboardをMainStorybordに設定
                let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                //遷移先をLockScreenViewControllerに設定
                let LockScreen = storyboard.instantiateViewController(withIdentifier: "LockScreen")
                //モーダルをfullscreenに変更
                LockScreen.modalPresentationStyle = .fullScreen
                print("go lockscreen")
                //遷移する
                self.present(LockScreen, animated: true, completion: nil)
                
            }
        }
    }



