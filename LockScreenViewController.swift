//
//  LockScreenViewController.swift
//  PassWord
//
//  Created by cmStudent on 2020/09/21.
//  Copyright © 2020 20cm0119. All rights reserved.
//

import UIKit
import AudioToolbox
import LocalAuthentication

class LockScreenViewController: UIViewController {
    
    @IBOutlet weak var EnterLockPassLabel: UILabel!
    
    let userDefaults = UserDefaults.standard
    
    
    var Inputstr: String = ""
    var Inputast: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //Dataの呼び出し
        func readData() -> String{
            
            let str: String = userDefaults.object(forKey: "DataStore")as! String
            return str
            
        }
        
        self.EnterLockPassLabel.text = "\(Inputstr)"
        
        self.EnterLockPassLabel.layer.cornerRadius = 5.0
        self.EnterLockPassLabel.clipsToBounds = true
        
    }
        
    @IBAction func OneButton(_ sender: Any) {
        Inputstr += "1"
        Inputast += "●"
        self.EnterLockPassLabel.text =  "\(Inputast)"
    }
    @IBAction func TwoButton(_ sender: Any) {
        Inputstr += "2"
        Inputast += "●"
        self.EnterLockPassLabel.text =  "\(Inputast)"
    }
    @IBAction func ThreeButton(_ sender: Any) {
        Inputstr += "3"
        Inputast += "●"
        self.EnterLockPassLabel.text =  "\(Inputast)"
    }
    @IBAction func FourButton(_ sender: Any) {
        Inputstr += "4"
        Inputast += "●"
        self.EnterLockPassLabel.text =  "\(Inputast)"
    }
    @IBAction func FiveButton(_ sender: Any) {
        Inputstr += "5"
        Inputast += "●"
        self.EnterLockPassLabel.text =  "\(Inputast)"
    }
    @IBAction func SixButton(_ sender: Any) {
        Inputstr += "6"
        Inputast += "●"
        self.EnterLockPassLabel.text =  "\(Inputast)"
    }
    @IBAction func SevenButton(_ sender: Any) {
        Inputstr += "7"
        Inputast += "●"
        self.EnterLockPassLabel.text =  "\(Inputast)"
    }
    @IBAction func EightButton(_ sender: Any) {
        Inputstr += "8"
        Inputast += "●"
        self.EnterLockPassLabel.text =  "\(Inputast)"
    }
    @IBAction func NineButton(_ sender: Any) {
        Inputstr += "9"
        Inputast += "●"
        self.EnterLockPassLabel.text =  "\(Inputast)"
    }
    @IBAction func ZeroButton(_ sender: Any) {
        Inputstr += "0"
        Inputast += "●"
        self.EnterLockPassLabel.text =  "\(Inputast)"
    }
    
    @IBAction func DeleteButton(_ sender: Any) {
        
        Inputstr = String(Inputstr.dropLast())
        Inputast = String(Inputast.dropLast())
        self.EnterLockPassLabel.text =  "\(Inputast)"
        print(Inputstr)
        
    }
    @IBAction func DecideButton(_ sender: Any) {
        
        let PassKey = UserDefaults.standard.string(forKey: "DataStore")
        
        if Inputstr == PassKey{
            
            let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)//遷移先のStoryboardを設定
            
            let navigationController = storyboard.instantiateViewController(withIdentifier: "Navigation") as! UINavigationController//遷移先のNavigationControllerを設定
            //モーダルをfullscreenに変更
            navigationController.modalPresentationStyle = .fullScreen
            self.present(navigationController, animated: true, completion: nil)//遷移する
            
            print("OK")
            
        }else{
            //どのバイブレーションか
            let systemSoundID = SystemSoundID(kSystemSoundID_Vibrate)
            //くり返し用のコールバック
            AudioServicesAddSystemSoundCompletion(systemSoundID, nil, nil, {(systemSoundID, nil) -> Void in}, nil)
            AudioServicesPlaySystemSound(systemSoundID)
            
            let alertController = UIAlertController(title: "パスワードが違います。", message: "もう一度入力してください。", preferredStyle: .alert)
            //OkButton
            let okAction = UIAlertAction(title: "OK", style: .default, handler: {(action:UIAlertAction!)in
                self.Inputstr = ""
                self.Inputast = ""
                self.EnterLockPassLabel.text =  "\(self.Inputast)"
            }
            )
            alertController.addAction(okAction)
            //alertを表示
            present(alertController, animated: true, completion: nil)
            
            print("NO")
        }
    }
}

/*
 // MARK: - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 // Get the new view controller using segue.destination.
 // Pass the selected object to the new view controller.
 }
 */

