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
        
        task = localRealm.objects(CarrotRealm.self)
        print(Array(task))
    }
}
