//
//  SettingViewController.swift
//  PassWord
//
//  Created by cmStudent on 2020/07/21.
//  Copyright © 2020 20cm0119. All rights reserved.
//

import UIKit
import RealmSwift

class SettingViewController: UIViewController,UITextFieldDelegate,UITextViewDelegate{
    let userDefaults = UserDefaults.standard
    let lockScreenPass = UserDefaults.standard.string(forKey: "LockScreenPass")
    
    @IBOutlet weak var inputTitle: UITextField!
    @IBOutlet weak var inputId: UITextField!
    @IBOutlet weak var inputPass: UITextField!
    @IBOutlet weak var inputAd: UITextField!
    @IBOutlet weak var inputMemo: UITextView!
    
    private var activeTextView: UITextView? = nil
    
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
        
        inputMemo.layer.borderWidth = 2
        inputMemo.layer.borderColor = UIColor.blue.cgColor
        
        self.inputMemo.layer.cornerRadius = 5.0 //角丸設定
        self.inputMemo.clipsToBounds = true//これを記述しないと上記のコードがエラーになる
        
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
        //テキストビューの行間制限
        func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
            let existingLines = inputMemo.text.components(separatedBy: .newlines)//既に存在する改行数
            let newLines = text.components(separatedBy: .newlines)//新規改行数
            let linesAfterChange = existingLines.count + newLines.count - 1
            return linesAfterChange <= 7
        }
    }
    
    @objc func onDidBecomeActive(_ notification: Notification?) {
    //observerの呼び出し
    if !userDefaults.bool(forKey: "switchStatus") || lockScreenPass == "" || lockScreenPass == nil{
        print("don't call observer")
    }
    else
    {
        print("call observer")
        //遷移先のStoryboardをMainStorybordに設定
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        //遷移先をLockScreenViewControllerに設定
        let LockScreen = storyboard.instantiateViewController(withIdentifier: "LockScreen")
        //モーダルをfullscreenに変更
        LockScreen.modalPresentationStyle = .fullScreen
        print("go lockScreen from SettingView")
        //遷移する
        self.present(LockScreen, animated: true, completion: nil)
    }
    }
        
        //********** キーボードの設定　***********//
        
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            // 各textFieldのキーボードを閉じる
            inputTitle.resignFirstResponder()
            inputId.resignFirstResponder()
            inputPass.resignFirstResponder()
            inputAd.resignFirstResponder()
            
            judgeText()
            
            return true
        }
        
        
        
        override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            //Viewをtapしたらキーボードを閉じる
            if (self.inputTitle.isFirstResponder) {
                self.inputTitle.resignFirstResponder()
            }
            if (self.inputId.isFirstResponder) {
                self.inputId.resignFirstResponder()
            }
            if (self.inputPass.isFirstResponder) {
                self.inputPass.resignFirstResponder()
            }
            if (self.inputAd.isFirstResponder) {
                self.inputAd.resignFirstResponder()
            }
            if (self.inputMemo.isFirstResponder) {
                self.inputMemo.resignFirstResponder()
            }
            judgeText()
        }
        
        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            configureObserver()  //Notification発行
        }
        
        
        // MARK: - Notification
        
        //      /// Notification発行
        func configureObserver() {
            let notification = NotificationCenter.default
            notification.addObserver(self, selector: #selector(keyboardWillShow(_:)),
                                     name: UIResponder.keyboardWillShowNotification, object: nil)
            notification.addObserver(self, selector: #selector(keyboardWillHide(_:)),
                                     name: UIResponder.keyboardWillHideNotification, object: nil)
            print("Notificationを発行")
        }
        
             /// キーボードが表示時に画面をずらす。
        @objc func keyboardWillShow(_ notification: Notification?) {
            if self.activeTextView != nil{
                guard let rect = (notification?.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue,
                    let duration = notification?.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval else { return }
                UIView.animate(withDuration: duration) {
                    let transform = CGAffineTransform(translationX: 0, y: -(rect.size.height))
                    self.view.transform = transform
                }
                print("keyboardWillShowを実行")
            }
        }
        
        //      /// キーボードが降りたら画面を戻す
        @objc func keyboardWillHide(_ notification: Notification?) {
            if self.activeTextView != nil{
                guard let duration = notification?.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? TimeInterval else { return }
                UIView.animate(withDuration: duration) {
                    self.view.transform = CGAffineTransform.identity
                }
                print("keyboardWillHideを実行")
            }
        }
        
        //********** キーボードの設定　***********//
        
        ///データの保存
        @IBAction func SaveButton(_ sender: UIBarButtonItem) {
            func save(){
                if inputTitle.text!.isEmpty || inputId.text!.isEmpty || inputPass.text!.isEmpty{
                    print("aralt")
                    //alertの作成
                    let alertController = UIAlertController(title: "保存に失敗しました。", message: "入力必須項目に空白があります。", preferredStyle: .alert)
                    //OKbuttonの作成
                    let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                    alertController.addAction(okAction)
                    //alertを表示
                    present(alertController, animated: true, completion: nil)
                } else {
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
                        _=navigationController?.popViewController(animated: true)
                        self.dismiss(animated: true, completion: nil)
                    }catch{
                        
                    }
                }
                print("alert2")
            }
            save()
        }
    }
    
    extension SettingViewController {
        
        func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
            activeTextView = nil
            return true
        }
        func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
            activeTextView = textView
            return true
        }
        
        func judgeText(){
            //TitleからPassWordまでtextfieldが一つでも空の場合保存ボタンは非活性,全て埋まっている場合活性
            if inputTitle.text!.isEmpty || inputId.text!.isEmpty || inputPass.text!.isEmpty{
                self.navigationItem.rightBarButtonItem?.isEnabled = false
            } else {
                self.navigationItem.rightBarButtonItem?.isEnabled = true
            }
            if num < 0 {
                //titleの重複がある時alertを表示
                func alert() {
                    let data = realm.objects(Passitem.self)
                    let newTitle = inputTitle.text!
                    var count = 0
                    
                    for _ in data{
                        let titleDate = data[count].inputTitle
                        if titleDate == newTitle{
                            //alertの作成
                            let alertController = UIAlertController(title: "このタイトルは使用できません。", message: "既に同じタイトルが使用されています。", preferredStyle: .alert)
                            //OkButton
                            let okAction = UIAlertAction(title: "OK", style: .default, handler: {(action:UIAlertAction!)in
                                self.inputTitle.text = ""
                            }
                            )
                            alertController.addAction(okAction)
                            //alertを表示
                            present(alertController, animated: true, completion: nil)
                        }
                        count += 1
                    }
                }
                alert()
            }
        }
}
