//
//  RealmTestViewController.swift
//  SOPT_Week3
//
//  Created by uiskim on 2023/05/27.
//

import UIKit

import RealmSwift

class RealmTestViewController: UIViewController {
    
    var task: Results<CarrotRealm>!
    
    let localRealm = try! Realm()

    override func viewDidLoad() {
        super.viewDidLoad()
        let task = CarrotRealm(id: 1, product: "아이폰", place: "마석", time: "11시", price: 20000)
        
        try! localRealm.write {
            localRealm.add(task)
        }

        print(Realm.Configuration.defaultConfiguration.fileURL!)
    }
}
