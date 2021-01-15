//
//  Passitem.swift
//  PassWord
//
//  Created by cmStudent on 2020/08/19.
//  Copyright © 2020 20cm0119. All rights reserved.
//

import Foundation
import RealmSwift

class Passitem: Object{
    //title
    @objc dynamic var inputTitle = ""
    //id
    @objc dynamic var inputId = ""
    //pass
    @objc dynamic var inputPass = ""
    //adress
    @objc dynamic var inputAd = ""
    //memo
    @objc dynamic var inputMemo = ""
    
    //特定でき空白ではない。検索が早い。重複が必ずない
    override static func primaryKey() -> String? {
        return "inputTitle"
    }
}
