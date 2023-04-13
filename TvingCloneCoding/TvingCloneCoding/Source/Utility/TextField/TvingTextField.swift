//
//  TvingTextField.swift
//  TvingCloneCoding
//
//  Created by uiskim on 2023/04/13.
//

import UIKit

final class TvingTextField: UITextField {
    
    enum TextFieldType {
        case email
        case password
    }
    
    private let righthButtonView = UIView()
    private var textFieldType: TextFieldType
    private let sidePadding: Int
    
    var clearButtonClicked: Bool = false {
        didSet {
            clearButton.isHidden = clearButtonClicked
        }
    }
    
    private lazy var clearButton: UIButton = {
        let button = UIButton()
        button.setImage(.makeLoginImage(type: .clear), for: .normal)
        button.contentMode = .scaleAspectFill
        button.addTarget(self, action: #selector(clearButtonTapped(_:)), for: .touchUpInside)
        return button
    }()
    
    
    private lazy var securityButton: UIButton = {
        let button = UIButton()
        button.setImage(.makeLoginImage(type: .hidePassword), for: .selected)
        button.setImage(.makeLoginImage(type: .showPassword), for: .normal)
        button.contentMode = .scaleAspectFill
        button.addTarget(self, action: #selector(securityButtonTapped(_:)), for: .touchUpInside)
        return button
    }()
    
    init(textFieldType: TextFieldType, sidePadding: Int) {
        self.textFieldType = textFieldType
        self.sidePadding = sidePadding
        super.init(frame: .zero)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        self.leftView = UIView(frame: .init(x: 0, y: 0, width: sidePadding, height: 0))
        self.leftViewMode = .always
        self.backgroundColor = .designSystem(.gray2E2E2E)
        self.layer.cornerRadius = 3
        self.font = .pretendard(weight: ._600, size: ._15)
        self.textColor = .designSystem(.gray9C9C9C)
        
        switch textFieldType {
        case .email:
            self.setLoginPlaceholder(placeholder: "아이디")
            isSecureTextEntry = false
            rightView = righthButtonView.addButtonsInTextfield(views: [clearButton], padding: sidePadding)
        case .password:
            self.setLoginPlaceholder(placeholder: "비밀번호")
            isSecureTextEntry = true
            rightView = righthButtonView.addButtonsInTextfield(views: [clearButton, securityButton], padding: sidePadding)
        }
    }
    
    @objc func clearButtonTapped(_ sender: UIButton) {
        self.text = ""
        sender.isHidden = true
    }
    
    @objc func securityButtonTapped(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        self.isSecureTextEntry = !sender.isSelected
    }
    
    
}
