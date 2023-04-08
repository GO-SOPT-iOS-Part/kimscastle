//
//  UITrainingViewController.swift
//  SOPT_Week2
//
//  Created by uiskim on 2023/04/08.
//

import UIKit
import SnapKit

final
class UITrainingViewController: UIViewController {
    
    let yellowView = UIView()
    let greenView = UIView()
    let blackView = UIView()
    let blueView = UIView()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        yellowView.backgroundColor = .yellow
        greenView.backgroundColor = .green
        blackView.backgroundColor = .black
        blueView.backgroundColor = .blue
        
        view.addSubview(yellowView)
        view.addSubview(greenView)
        view.addSubview(blackView)
        view.addSubview(blueView)
        
        yellowView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalTo(greenView.snp.leading)
            make.width.equalTo(greenView.snp.width)
            make.bottom.equalTo(greenView.snp.top)
        }
        
        greenView.snp.makeConstraints { make in
            make.top.equalTo(yellowView.snp.bottom)
            make.trailing.equalToSuperview()
            make.leading.equalTo(yellowView.snp.trailing)
            make.bottom.equalTo(blackView.snp.top)
            make.height.equalTo(yellowView.snp.height)
        }
        
        blackView.snp.makeConstraints { make in
            make.top.equalTo(greenView.snp.bottom)
            make.leading.equalToSuperview()
            make.trailing.equalTo(yellowView.snp.trailing)
            make.bottom.equalTo(blueView.snp.top)
            make.height.equalTo(yellowView.snp.height)
        }

        blueView.snp.makeConstraints { make in
            make.top.equalTo(blackView.snp.bottom)
            make.trailing.equalToSuperview()
            make.leading.equalTo(greenView.snp.leading)
            make.bottom.equalToSuperview()
            make.height.equalTo(yellowView.snp.height)
        }
    }
}
