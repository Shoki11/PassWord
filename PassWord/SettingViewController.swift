//
//  SettingViewController.swift
//  PassWord
//
//  Created by cmStudent on 2020/07/21.
//  Copyright © 2020 20cm0120. All rights reserved.
//

import UIKit
import RealmSwift

class SettingViewController: UIViewController,UITextFieldDelegate,UITextViewDelegate{
    
    
    @IBOutlet weak var inputTitle: UITextField!
    @IBOutlet weak var inputId: UITextField!
    @IBOutlet weak var inputPass: UITextField!
    @IBOutlet weak var inputAd: UITextField!
    @IBOutlet weak var inputMemo: UITextView!
    
    //Realmの使用を宣言する文
    let realm = try! Realm()
    
    var num = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        print(num)
        //保存ボタンを非活性
        self.navigationItem.rightBarButtonItem?.isEnabled = false
        
        //delegataの自分自身に設定
        inputTitle.delegate = self
        inputId.delegate = self
        inputPass.delegate = self
        inputAd.delegate = self
        inputMemo.delegate = self
        
        inputMemo.layer.borderWidth = 1
        inputMemo.layer.borderColor = UIColor.black.cgColor
        
        //新規か編集かを判定
        if num >= 0 {
            
            // relmからデータを取ってきた、textfieldに表示
            let data = realm.objects(Passitem.self)
            inputTitle.text = data[num].inputTitle // レコード取得
            inputId.text = data[num].inputId // レコード取得
            inputPass.text = data[num].inputPass //レコード取得
            inputAd.text = data[num].inputAd // レコード取得
            inputMemo.text = data[num].inputMemo
        }
    }

    //********** キーボードの設定　***********//
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // 各textFieldのキーボードを閉じる
        inputTitle.resignFirstResponder()
        inputId.resignFirstResponder()
        inputPass.resignFirstResponder()
        inputAd.resignFirstResponder()
        
        //TitleからPassWordまでtextfieldが一つでも空の場合保存ボタンは非活性,全て埋まっている場合活性
        if inputTitle.text!.isEmpty || inputId.text!.isEmpty || inputPass.text!.isEmpty{
            self.navigationItem.rightBarButtonItem?.isEnabled = false
        } else {
            self.navigationItem.rightBarButtonItem?.isEnabled = true
        }
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //Viewをtapしたらキーボードを閉じる
        if (self.inputMemo.isFirstResponder) {
            self.inputMemo.resignFirstResponder()
        }
    }
    @objc func keyboardWillShow(notification: NSNotification) {
        
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
                
            } else {
                let suggestionHeight = self.view.frame.origin.y + keyboardSize.height
                self.view.frame.origin.y -= suggestionHeight
                
            }
        }
    }
    //********** キーボードの設定　***********//
    
    //データの保存
    @IBAction func SaveButton(_ sender: UIBarButtonItem) {
        _=navigationController?.popViewController(animated: true)
        
        //Passitemのインスタンス生成
        let newPassitem = Passitem()
        //textfieldの値を代入
        newPassitem.inputTitle = inputTitle.text!
        newPassitem.inputId = inputId.text!
        newPassitem.inputPass = inputPass.text!
        newPassitem.inputAd = inputAd.text!
        newPassitem.inputMemo = inputMemo.text!
        
        //インスタンスをRealmに保存
        do{
            let realm = try Realm()
            
            
            try realm.write(
            { () -> Void in
                realm.add(newPassitem, update: .modified)
            }
            )
        }catch{
            
        }
        self.dismiss(animated: true, completion: nil)
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

