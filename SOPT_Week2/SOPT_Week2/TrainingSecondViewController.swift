//
//  TrainingSecondViewController.swift
//  SOPT_Week2
//
//  Created by uiskim on 2023/04/08.
//

import UIKit

protocol CountUpdelegate: AnyObject {
    func countUp()
}

final class TrainingSecondViewController: UIViewController {
    
    weak var delegate: CountUpdelegate?
    
    let label: UILabel = {
        let label = UILabel()
        label.text = "횟수는?"
        return label
    }()
    
    let countUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("카운트업", for: .normal)
        button.backgroundColor = .black
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    let backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("뒤로가기", for: .normal)
        button.backgroundColor = .black
        button.setTitleColor(.white, for: .normal)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        countUpButton.addTarget(self, action: #selector(countUpButtonTapped), for: .touchUpInside)
        backButton.addTarget(self, action: #selector(backButtonTappes), for: .touchUpInside)
        view.addSubview(label)
        view.addSubview(countUpButton)
        view.addSubview(backButton)
        
        label.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        countUpButton.snp.makeConstraints { make in
            make.top.equalTo(label.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
        
        backButton.snp.makeConstraints { make in
            make.top.equalTo(countUpButton.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
    }
    
    @objc func countUpButtonTapped() {
        delegate?.countUp()
    }
    
    @objc func backButtonTappes() {
        self.navigationController?.popViewController(animated: true)
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
