//
//  TrainingFirstViewController.swift
//  SOPT_Week2
//
//  Created by uiskim on 2023/04/08.
//

import UIKit

import SnapKit
import Then

final class TrainingFirstViewController: UIViewController {
    
    var count: Int = 0
    
    let countShowLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.backgroundColor = .black
        label.font = .boldSystemFont(ofSize: 20)
        label.textAlignment = .center
        return label
    }()
    
    var pustNextViewControllerButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("다음뷰로가기", for: .normal)
        button.backgroundColor = .blue
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(countShowLabel)
        view.addSubview(pustNextViewControllerButton)
        
        pustNextViewControllerButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
        countShowLabel.text = "카운트 횟수 0"
        countShowLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(200)
            make.height.equalTo(50)
        }
        
        pustNextViewControllerButton.snp.makeConstraints { make in
            make.top.equalTo(countShowLabel.snp.bottom).offset(30)
            make.centerX.equalToSuperview()
        }
    }
    
    @objc func buttonTapped() {

        let nextVC = TrainingSecondViewController()
        nextVC.delegate = self
        self.navigationController?.pushViewController(nextVC, animated: true)
    }


}

extension TrainingFirstViewController: CountUpdelegate {
    func countUp() {
        self.count += 1
        countShowLabel.text = self.count < 10 ? "카운트 횟수 \(count)" : "많이카운트하셨네요 \(count)"
    }
}
