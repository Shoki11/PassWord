//
//  SettingsTableViewController.swift
//  PassWord
//
//  Created by cmStudent on 2020/09/15.
//  Copyright © 2020 20cm0119. All rights reserved.
//

import UIKit

class SettingsTableViewController: UITableViewController {
    
    @IBOutlet weak var EnterPass: UITableViewCell!
    @IBOutlet weak var TurnPass: UITableViewCell!
    @IBOutlet weak var TurnSwitch: UISwitch!
    
    let userDefaults = UserDefaults.standard
    var lockScreenPass = UserDefaults.standard.string(forKey: "LockScreenPass")
    
    var switchStatus: Bool = true {
        didSet {
            if oldValue != switchStatus {
                saveSwitchStatus()
                print("save succeed")
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("viewDidLoad start...")
        
        readSwitchStatus()
    }
    
    ///バックグラウンドからの復帰
    @objc func onDidBecomeActive(_ notification: Notification?) {
        
        //observerの呼び出し
        if !userDefaults.bool(forKey: "switchStatus") || lockScreenPass == "" || lockScreenPass == nil {
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
            //遷移する
            self.present(LockScreen, animated: true, completion: nil)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        readSwitchStatus()
        lockScreenPass = UserDefaults.standard.string(forKey: "LockScreenPass")
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        //セクションの数を返す
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //各セクション毎に何行のセルがあるか返す
        return 2
    }
    
    @IBAction func Tapped(_ sender: UISwitch) {
        print("did Tap")
        switchStatus = sender.isOn
        if !sender.isOn {
            print("switchStatus false")
        } else {
            if lockScreenPass == "" || lockScreenPass == nil{
                TurnSwitch.isOn = false
                switchStatus = false
            }
        }
    }
    
    ///起動時パスワードのオン/オフを保存
    func saveSwitchStatus() {
        userDefaults.set(switchStatus, forKey: "switchStatus")
    }
    
    ///起動時パスワードのオン/オフを読み込み
    func  readSwitchStatus() {
        userDefaults.register(defaults: ["switchStatus":false])
        switchStatus = userDefaults.bool(forKey: "switchStatus")
        TurnSwitch.isOn = switchStatus
        
        let lockScreenPass = userDefaults.string(forKey: "LockScreenPass")
        if lockScreenPass == "" || lockScreenPass == nil{
            TurnSwitch.isOn = false
            switchStatus = false
        }
    }
}
