//
//  SecondViewController.swift
//  SOPT_Week2
//
//  Created by uiskim on 2023/04/08.
//

import UIKit


// 클래스를 하려면 init함수가 필요함
// 그리고 함수를 선언하고 구현까지 해야함

// 예를들어서 나는 SecondVC에서 텍스트를 받아서 FirstVC에서는 label에다가 넣고싶을수도있고 textfield에도 넣고싶음
// 클래스로 만든다면 이부분을 전부다 상상해서 구현해줘야함 애초에 설계과정부터 모든걸 다 염려한 후에 코드를 짜야함
// 프로토콜에서는 나는 이걸전달만해줌 -> 구현은 구현부에게 맡긴다



protocol DataBindProtocol: AnyObject {
    func databind(text: String)
}

final class SecondViewController: UIViewController {
    
    //weak var delegate: DataBindProtocol?
    
    var completionHandler: ((String) -> (Void))?
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "이름이 무엇인가요!?"
        label.font = .systemFont(ofSize: 16)
        label.textColor = .blue
        label.textAlignment = .center
        return label
    }()
    
    private let nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "이름을 입력해주세요"
        textField.clearButtonMode = .whileEditing
        textField.layer.borderColor = UIColor.gray.cgColor
        textField.layer.borderWidth = 1
        return textField
    }()
    
    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.setTitle("뒤로가기!", for: .normal)
        button.backgroundColor = .yellow
        button.setTitleColor(.blue, for: .normal)
        button.addTarget(self,
                         action: #selector(popSecondViewController),
                         for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        style()
        setLayout()
    }
}

private extension SecondViewController {
    
    func style() {
        
        view.backgroundColor = .white
    }
    
    func setLayout() {
        
        [nameLabel, nameTextField, backButton].forEach {
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
        
        NSLayoutConstraint.activate([backButton.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 20),
                                     backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
                                     backButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
                                     backButton.heightAnchor.constraint(equalToConstant: 48)])
    }
    
    @objc
    func popSecondViewController() {
        guard let text = nameTextField.text else { return }
        completionHandler?(text)
        self.navigationController?.popViewController(animated: true)
    }
}
