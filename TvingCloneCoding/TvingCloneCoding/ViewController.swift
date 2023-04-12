//
//  ViewController.swift
//  TvingCloneCoding
//
//  Created by uiskim on 2023/04/12.
//

import UIKit

class ViewController: UIViewController {
    
    let testLabel: UILabel = {
        let v = UILabel()
        v.text = "동해물과 백두산이 마르고 닳도록"
        v.textColor = .designSystem(.mainRed)
        v.font = .pretendard(weight: .bold, size: ._25)
        return v
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.addSubview(testLabel)
        testLabel.translatesAutoresizingMaskIntoConstraints = false
        testLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        testLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }


}

