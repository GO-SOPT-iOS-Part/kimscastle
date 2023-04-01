//
//  FirstViewController_1st_Seminar.swift
//  32th-iOS-Seminar
//
//  Created by uiskim on 2023/01/14.
//

import UIKit

final class FirstViewController_1st_Seminar: UIViewController {
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "이름이 무엇인가요!?"
        label.font = .systemFont(ofSize: 16)
        label.textColor = .white
        label.textAlignment = .center
        
        // MARK: - UIComponent들에 속성 추가하기
        label.backgroundColor = .black
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 10
        return label
    }()
    
    private let nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "이름을 입력해주세요"
        textField.clearButtonMode = .whileEditing
        textField.layer.borderColor = UIColor.gray.cgColor
        textField.layer.borderWidth = 1
        
        // MARK: - UIComponent들에 속성 추가하기
        textField.borderStyle = .roundedRect
        textField.keyboardType = .numberPad
        return textField
    }()
    
    private lazy var presentButton: UIButton = {
        let button = UIButton()
        button.setTitle("present!", for: .normal)
        button.backgroundColor = .yellow
        button.setTitleColor(.blue, for: .normal)
        
        // MARK: - UIComponent들에 속성 추가하기
        button.titleLabel?.font = .systemFont(ofSize: 15, weight: .bold)
        button.setImage(UIImage(systemName: "snow"), for: .normal)
        
        // 새롭게 추가
        button.addTarget(self,
                         action: #selector(presentButtonTapped),
                         for: .touchUpInside)
        return button
    }()
    
    private lazy var pushButton: UIButton = {
        let button = UIButton()
        button.setTitle("push!", for: .normal)
        button.backgroundColor = .yellow
        button.setTitleColor(.blue, for: .normal)
        
        // MARK: - UIComponent들에 속성 추가하기
        button.titleLabel?.font = .systemFont(ofSize: 15, weight: .bold)
        button.setImage(UIImage(systemName: "sunset"), for: .normal)
        
        // 새롭게 추가
        button.addTarget(self,
                         action: #selector(pushButtonTapped),
                         for: .touchUpInside)
        return button
    }()
    
    // MARK: - 새로운 UIComponent 추가하고 속성부여하기
    private lazy var testSwitch: UISwitch = {
        let mySwitch = UISwitch()
        mySwitch.onTintColor = .orange
        mySwitch.isOn = true
        mySwitch.addTarget(self, action: #selector(switchChanged(_:)), for: .valueChanged)
        return mySwitch
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        style()
        setLayout()
    }
}

private extension FirstViewController_1st_Seminar {
    
    func style() {
        view.backgroundColor = .white
    }
    
    func setLayout() {
        
        [nameLabel, nameTextField,
         presentButton, pushButton, testSwitch].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        
        NSLayoutConstraint.activate([nameLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 300),
                                     nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
                                     nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30)])
        
        NSLayoutConstraint.activate([nameTextField.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 20),
                                     nameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
                                     nameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
                                     nameTextField.heightAnchor.constraint(equalToConstant: 48)])
        
        NSLayoutConstraint.activate([presentButton.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 20),
                                     presentButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
                                     presentButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
                                     presentButton.heightAnchor.constraint(equalToConstant: 48)])
        
        NSLayoutConstraint.activate([pushButton.topAnchor.constraint(equalTo: presentButton.bottomAnchor, constant: 20),
                                     pushButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
                                     pushButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
                                     pushButton.heightAnchor.constraint(equalToConstant: 48)])
        
        testSwitch.topAnchor.constraint(equalTo: pushButton.bottomAnchor, constant: 50).isActive = true
        testSwitch.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    func presentToSecondViewController() {
        
        let secondViewController = SecondViewController_1st_Seminar()
        secondViewController.modalPresentationStyle = .fullScreen
        self.present(secondViewController, animated: true)
    }
    
    func pushToSecondViewController() {
        
        guard let name = nameTextField.text else { return }
        let secondViewController = SecondViewController_1st_Seminar()
        secondViewController.name = name
        self.navigationController?.pushViewController(secondViewController, animated: true)
    }
    
    @objc
    func presentButtonTapped() {
        
        presentToSecondViewController()
    }
    
    @objc
    func pushButtonTapped() {
        
        pushToSecondViewController()
    }
    
    @objc
    func switchChanged(_ sender: UISwitch) {
        view.backgroundColor = sender.isOn ? .white : .red
    }
}
