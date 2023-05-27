//
//  RealmTestViewController.swift
//  SOPT_Week3
//
//  Created by uiskim on 2023/05/27.
//

import UIKit

import RealmSwift

class RealmTestViewController: UIViewController {
    
    var task: Results<User>!
    
    let localRealm = try! Realm()

    override func viewDidLoad() {
        super.viewDidLoad()

        let task1 = User(id: 100, name: "승찬", age: 27, phoneNumber: 01012345678)
        
        try! localRealm.write {
            localRealm.add(task1)
        }
        
        task = localRealm.objects(User.self)
        
//        print(tasks)

        print(Realm.Configuration.defaultConfiguration.fileURL!)
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

class User: Object {
    
    @Persisted(primaryKey: true) var id: Int = 0
    @Persisted var name: String = ""
    @Persisted var age: Int = 0
    @Persisted var phoneNumber: Int = 0
    
    convenience init(id: Int, name: String, age: Int, phoneNumber: Int) {
        self.init()
        self.id = id
        self.name = name
        self.age = age
        self.phoneNumber = phoneNumber
    }
}
