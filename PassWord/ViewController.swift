//
//  ViewController.swift
//  PassWord
//
//  Created by cmStudent on 2020/07/21.
//  Copyright © 2020 20cm0119. All rights reserved.
//

import UIKit
import RealmSwift

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{
    
    let userDefaults = UserDefaults.standard
    let dataStore = UserDefaults.standard.string(forKey: "DataStore")
    
    //スイッチのオンオフ
    func readData() -> Int {
        let TurnData = userDefaults.object(forKey: "turnData") as! Int
        return TurnData
    }
    
    var num: Int = 0
    var itemList: Results<Passitem>!
    
    @IBOutlet weak var PassTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        PassTableView.delegate = self
        PassTableView.dataSource = self
        
        //Realmからデータを取得
        do{
            let realm = try Realm()
            itemList = realm.objects(Passitem.self)
            
            print("Realm saved")
        } catch {
            print("Realm save is faild")
        }
    
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(ViewController.onDidBecomeActive(_:)),
            name: UIApplication.didBecomeActiveNotification,
            object: nil
        )
    }
    
    //バックグラウンドからの復帰
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
            print("go lockscreen from viewController")
            //遷移する
            self.present(LockScreen, animated: true, completion: nil)
        }
    }
    
    //tableviewの表示
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "passCell")!
        cell.textLabel?.text = itemList[indexPath.row].inputTitle
        return cell
        
    }
    // 画面が表示される直前にtableViewを更新
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        PassTableView.reloadData()
        
    }
    
    //パスワードの追加
    @IBAction func PlusButtonAction(_ sender: Any) {
        
        
        let viewController = self.storyboard?.instantiateViewController(identifier: "settingViewController") as! SettingViewController
        self.navigationController?.pushViewController(viewController, animated: true)
        
        viewController.num = -1
    }
    
    //swipeAction（消去と編集）
    //消去ボタン
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteTitle = UIContextualAction(style: .destructive, title: "消去") {  (contextualAction, view, boolValue) in
            _ = NSLocalizedString("Delete", comment: "Delete action")
            
            //Realm内のデータを削除
            do{
                let realm = try Realm()
                try realm.write{
                    realm.delete(self.itemList[indexPath.row])
                }
                tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.fade)
                
            }catch{
            }
        }
        //編集ボタン
        let EditTitle = UIContextualAction(style: .destructive, title: "編集") {  (contextualAction, view, boolValue) in
            _ = NSLocalizedString("Edit", comment: "Edit action")
            
            
            //保存画面に画面遷移
            //storybordのインスタンス生成
            let storybord: UIStoryboard = self.storyboard!
            
            //遷移先のviewControllerのインスタンス生成
            let viewController = storybord.instantiateViewController(withIdentifier: "settingViewController") as! SettingViewController
            self.navigationController?.pushViewController( viewController , animated: true)
            viewController.num = indexPath.row
        }
        
        EditTitle.backgroundColor = .green
        
        let swipeActions = UISwipeActionsConfiguration(actions:[deleteTitle,EditTitle])
        
        return swipeActions
    }
    
    //cellをタップした時
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // セルの選択を解除
        tableView.deselectRow(at: indexPath, animated: true)
        
        num = indexPath.row
        
        // 別の画面に遷移
        performSegue(withIdentifier: "goDetail", sender: nil)
    }
    
    // セグエ実行前処理
    //numのデータの受け渡し
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let next = segue.destination as? DetailViewController
        next?.num = num
    }
}

