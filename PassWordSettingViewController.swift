//
//  PassWordSettingViewController.swift
//  PassWord
//
//  Created by cmStudent on 2020/09/18.
//  Copyright © 2020 20cm0119. All rights reserved.
//

import UIKit

class PassWordSettingViewController: UIViewController,UITextFieldDelegate {
    
    @IBOutlet weak var EnterPassWord: UITextField!
    
    //UserDefaultsのインスタンス生成
    let userDefaults = UserDefaults.standard
    let lockScreenPass = UserDefaults.standard.string(forKey: "LockScreenPass")
    
    
    
    var inputUserPass:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //枠線の太さ
        EnterPassWord.layer.borderWidth = 2
        //枠線の色
        EnterPassWord.layer.borderColor = UIColor.blue.cgColor
        
        self.EnterPassWord.layer.cornerRadius = 5.0
        self.EnterPassWord.clipsToBounds = true
        
        EnterPassWord.delegate = self
        
        userDefaults.register(defaults: ["LockScreenPass":""])
        EnterPassWord.text = readData()
        
        //NumberPadにreturnKeyを付与
        let toolbar: UIToolbar = UIToolbar()
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                                    target: nil,
                                    action: nil)
        let done = UIBarButtonItem(title: "保存",
                                   style: .done,
                                   target: self,
                                   action: #selector(barButtonTapped(_:)))
        toolbar.items = [space, done]
        toolbar.sizeToFit()
        self.EnterPassWord.inputAccessoryView = toolbar
        //キーボードの入力を数字のみにする
        self.EnterPassWord.keyboardType = UIKeyboardType.numberPad
    }
    
        @objc func onDidBecomeActive(_ notification: Notification?) {
        //observerの呼び出し
        if !userDefaults.bool(forKey: "switchStatus") || lockScreenPass == "" || lockScreenPass == nil{
            print("don't call observer")
        }
        else
        {
            print("call observer")
        ///遷移先のStoryboardをMainStorybordに設定
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        ///遷移先をLockScreenViewControllerに設定
        let LockScreen = storyboard.instantiateViewController(withIdentifier: "LockScreen")
        //モーダルをfullscreenに変更
        LockScreen.modalPresentationStyle = .fullScreen
        print("go lockScreen from PassWordSetting")
        //遷移する
        self.present(LockScreen, animated: true, completion: nil)
    }
    }
    
    @objc func barButtonTapped(_ sender: UIBarButtonItem) -> Bool {
        inputUserPass = EnterPassWord.text!
        // 各textFieldのキーボードを閉じる
        EnterPassWord.resignFirstResponder()
        saveData(str: inputUserPass)
        return true
    }
    
    
    //ユーザーのロック画面用のパスワードデータの保存
    func  saveData(str: String){
        
        userDefaults.set(str, forKey: "LockScreenPass")
    }
    
    ///ユーザーのロック画面用のパスワードデータの呼び出し
    func readData() -> String{
        
        let str: String = userDefaults.object(forKey: "LockScreenPass")as! String
        return str
    }
    ///ユーザーのロック画面用のパスワードデータを削除
    @IBAction func removeData(_ sender: Any) {
        //userDefaultsの削除
        userDefaults.removeObject(forKey: "LockScreenPass")
        EnterPassWord.text = ""
        
        
    }
}



