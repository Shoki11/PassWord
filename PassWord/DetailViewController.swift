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
    let dataStore = UserDefaults.standard.string(forKey: "DataStore")
    
    
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
        
        // Do any additional setup after loading the view.
        
        let data = realm.objects(Passitem.self)
        TitleLabel.text = data[num].inputTitle // レコード取得になります
        IdLabel.text = data[num].inputId // レコード取得になります
        AdLabel.text = data[num].inputAd // レコード取得になります
        MemoLabel.text = data[num].inputMemo
        
        let countTextPass = data[num].inputPass.count //レコード取得
        
        //*を用意
        let maru = "＊"
        
        //文字のカウントの分だけラベルに＊を足す
        //0から始まると１文字多くなるので１からスタート
        for _ in 1...countTextPass{
            PassLabel.text! += maru
        }
    }
    
    @objc func onDidBecomeActive(_ notification: Notification?) {
        //observerの呼び出し
        if !userDefaults.bool(forKey: "switchStatus") || dataStore == "" || dataStore == nil{
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
            print("go lockscreen from DetailView")
            //遷移する
            self.present(LockScreen, animated: true, completion: nil)
        }
    }
    
    //LabelのTap設定
    @IBAction func TitleTap(_ sender: Any) {
        //TitleLabelをTapしCopy
        UIPasteboard.general.string = TitleLabel.text!
        
        //タップした時テキストに変える
//        TapResultLabel.text = "テキストをコピーしました"
        
        
        DispatchQueue.main.async {
            
        Toast.show("テキストをコピーしました", self.view)
            
        // 結果を読み上げるコード
        let utterWords = AVSpeechUtterance(string: "テキストをコピーしました")
        
        // 英語なら"en-us" 日本語なら"ja-jp"
        utterWords.voice = AVSpeechSynthesisVoice(language: "ja-jp")
        
        let synthesizer = AVSpeechSynthesizer()
        
        synthesizer.speak(utterWords)
        
        }
        //タップしてから3秒後にテキストを戻す
//        Timer.scheduledTimer(withTimeInterval: 3, repeats: false){
//            _ in self.TapResultLabel.text = "入力したテキストをタップでコピー"
//        }
    }
    
    @IBAction func IdTap(_ sender: Any) {
        UIPasteboard.general.string = IdLabel.text!
        
        DispatchQueue.main.async {
            
        Toast.show("テキストをコピーしました", self.view)
            
        // 結果を読み上げるコード
        let utterWords = AVSpeechUtterance(string: "テキストをコピーしました")
        
        // 英語なら"en-us" 日本語なら"ja-jp"
        utterWords.voice = AVSpeechSynthesisVoice(language: "ja-jp")
        
        let synthesizer = AVSpeechSynthesizer()
        
        synthesizer.speak(utterWords)
        
        }
        //タップした時テキストに変える
//        TapResultLabel.text = "Done"
        
//        TapResultLabel.font = UIFont.boldSystemFont(ofSize: 100)
//
//        TapResultLabel.textColor = UIColor.green
        
        //タップしてから3秒後にテキストを戻す
//        Timer.scheduledTimer(withTimeInterval: 3, repeats: false) {
//
//            _ in self.TapResultLabel.text = "入力したテキストをタップでコピー"
//
//            self.TapResultLabel.font = UIFont.boldSystemFont(ofSize: 25)
//
//            self.TapResultLabel.textColor = UIColor.black
//
//        }
        
    }
    
    @IBAction func PassTap(_ sender: Any) {
        
        let data = realm.objects(Passitem.self)
        UIPasteboard.general.string = data[num].inputPass
        
        DispatchQueue.main.async {
            
        Toast.show("テキストをコピーしました", self.view)
            
        // 結果を読み上げるコード
        let utterWords = AVSpeechUtterance(string: "テキストをコピーしました")
        
        // 英語なら"en-us" 日本語なら"ja-jp"
        utterWords.voice = AVSpeechSynthesisVoice(language: "ja-jp")
        
        let synthesizer = AVSpeechSynthesizer()
        
        synthesizer.speak(utterWords)
        
        }
        
        //タップした時テキストに変える
//        TapResultLabel.text = "テキストをコピーしました"
        
        //タップしてから3秒後にテキストを戻す
//        Timer.scheduledTimer(withTimeInterval: 3, repeats: false){
//            _ in self.TapResultLabel.text = "入力したテキストをタップでコピー"
//        }
    }
    
    @IBAction func AdTap(_ sender: Any) {
        UIPasteboard.general.string = AdLabel.text!
        
        DispatchQueue.main.async {
            
        Toast.show("テキストをコピーしました", self.view)
            
        // 結果を読み上げるコード
        let utterWords = AVSpeechUtterance(string: "テキストをコピーしました")
        
        // 英語なら"en-us" 日本語なら"ja-jp"
        utterWords.voice = AVSpeechSynthesisVoice(language: "ja-jp")
        
        let synthesizer = AVSpeechSynthesizer()
        
        synthesizer.speak(utterWords)
        
        }
        
        //タップした時テキストに変える
//        TapResultLabel.text = "テキストをコピーしました"
        
        //タップしてから3秒後にテキストを戻す
//        Timer.scheduledTimer(withTimeInterval: 3, repeats: false){
//            _ in self.TapResultLabel.text = "入力したテキストをタップでコピー"
//        }
    }
}
