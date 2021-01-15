//
//  DetailViewController.swift
//  PassWord
//
//  Created by cmStudent on 2020/08/25.
//  Copyright © 2020 20cm0119. All rights reserved.
//

import UIKit
import RealmSwift
import AVFoundation

class DetailViewController: UIViewController {
    let userDefaults = UserDefaults.standard
    let lockScreenPass = UserDefaults.standard.string(forKey: "LockScreenPass")
    
    
    //Realmの使用を宣言する文
    let realm = try! Realm()
    
    //変数　num を宣言
    var num = 0
    
    @IBOutlet weak var TitleLabel: UILabel!
    @IBOutlet weak var IdLabel: UILabel!
    @IBOutlet weak var PassLabel: UILabel!
    @IBOutlet weak var AdLabel: UILabel!
    @IBOutlet weak var MemoLabel: UILabel!
    @IBOutlet weak var TapResultLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let data = realm.objects(Passitem.self)
        
        TitleLabel.text = data[num].inputTitle // レコード取得になります
        IdLabel.text = data[num].inputId // レコード取得になります
        AdLabel.text = data[num].inputAd // レコード取得になります
        MemoLabel.text = data[num].inputMemo
        
        let countTextPass = data[num].inputPass.count //レコード取得
        
        //*を用意
        let hidePassChar = "＊"
        
        //文字のカウントの分だけラベルに＊を足す
        //0から始まると１文字多くなるので１からスタート
        for _ in 1...countTextPass{
            PassLabel.text! += hidePassChar
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
            let topView: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            //遷移先をLockScreenViewControllerに設定
            let LockScreen = topView.instantiateViewController(withIdentifier: "LockScreen")
            //モーダルをfullscreenに変更
            LockScreen.modalPresentationStyle = .fullScreen
            print("go lockscreen from DetailView")
            //遷移する
            self.present(LockScreen, animated: true, completion: nil)
        }
    }
    
    //LabelのTap設定
    @IBAction func TitleTap(_ sender: Any) {
        //TitleLabelをTapしCopy
        UIPasteboard.general.string = TitleLabel.text!
        DispatchQueue.main.async {
            
            self.tapAction()
        
        }
    }
    
    @IBAction func IdTap(_ sender: Any) {
        UIPasteboard.general.string = IdLabel.text!
        
        DispatchQueue.main.async {
            
            self.tapAction()
        }
    }
    
    @IBAction func PassTap(_ sender: Any) {
        
        let data = realm.objects(Passitem.self)
        UIPasteboard.general.string = data[num].inputPass
        
        DispatchQueue.main.async {
            
            self.tapAction()
        
        }
    }
    
    @IBAction func AdTap(_ sender: Any) {
        UIPasteboard.general.string = AdLabel.text!
        
        DispatchQueue.main.async {
            
            self.tapAction()
        }
    }
    ///テキストがタップされた時の操作
    func tapAction(){
        Toast.show("テキストをコピーしました", self.view)
            
        // 結果を読み上げるコード
        let utterWords = AVSpeechUtterance(string: "テキストをコピーしました")
        
        // 英語なら"en-us" 日本語なら"ja-jp"
        utterWords.voice = AVSpeechSynthesisVoice(language: "ja-jp")
        
        let synthesizer = AVSpeechSynthesizer()
        
        synthesizer.speak(utterWords)
    }
}
