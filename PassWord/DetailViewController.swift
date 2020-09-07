//
//  DetailViewController.swift
//  PassWord
//
//  Created by cmStudent on 2020/08/25.
//  Copyright © 2020 20cm0120. All rights reserved.
//

import UIKit
import RealmSwift

class DetailViewController: UIViewController {
    
    //Realmの使用を宣言する文
       let realm = try! Realm()
    
    //変数　num を宣言
    var num = 0

    @IBOutlet weak var TitleLabel: UILabel!
    @IBOutlet weak var IdLabel: UILabel!
    @IBOutlet weak var PassLabel: UILabel!
    @IBOutlet weak var AdLabel: UILabel!
    @IBOutlet weak var MemoLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let data = realm.objects(Passitem.self)
        TitleLabel.text = data[num].inputTitle // レコード取得になります
        IdLabel.text = data[num].inputId // レコード取得になります
        PassLabel.text = data[num].inputPass //レコード取得になります
        AdLabel.text = data[num].inputAd // レコード取得になります
        MemoLabel.text = data[num].inputMemo
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
