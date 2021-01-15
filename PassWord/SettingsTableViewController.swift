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
    var dataStore = UserDefaults.standard.string(forKey: "DataStore")
    let ud = UserDefaults.standard
    
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
    
    //バックグラウンドからの復帰
    @objc func onDidBecomeActive(_ notification: Notification?) {
        
        //observerの呼び出し
        if !userDefaults.bool(forKey: "switchStatus") || dataStore == "" || dataStore == nil {
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
        dataStore = UserDefaults.standard.string(forKey: "DataStore")
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
            if dataStore == "" || dataStore == nil{
                TurnSwitch.isOn = false
                switchStatus = false
            }
        }
    }
    
    func saveSwitchStatus() {
        ud.set(switchStatus, forKey: "switchStatus")
    }
    
    func  readSwitchStatus() {
        ud.register(defaults: ["switchStatus":false])
        switchStatus = ud.bool(forKey: "switchStatus")
        TurnSwitch.isOn = switchStatus
        
        let dataStore = ud.string(forKey: "DataStore")
        if dataStore == "" || dataStore == nil{
            TurnSwitch.isOn = false
            switchStatus = false
        }
    }
}
    /*
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
     
     // Configure the cell...
     
     return cell
     }
     */
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    

