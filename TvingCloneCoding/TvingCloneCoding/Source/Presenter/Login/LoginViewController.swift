//
//  LoginViewController.swift
//  TvingCloneCoding
//
//  Created by uiskim on 2023/04/12.
//

import UIKit

import SnapKit

final class LoginViewController: UIViewController {
    
    private let loginTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "TVING ID 로그인"
        label.font = .pretendard(weight: ._500, size: ._23)
        label.textAlignment = .center
        label.textColor = .designSystem(.white)
        return label
    }()
    
    private let emailTextField = TvingTextField(textFieldType: .email, sidePadding: 20)
    private let passwordTextField = TvingTextField(textFieldType: .password, sidePadding: 20)
    
    private lazy var loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("로그인하기", for: .normal)
        button.nonActiveButton()
        button.addTarget(self, action: #selector(loginButtonTapped(_:)), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setNavigationBar()
        setDelegate()
    }
    
    private func setUI() {
        view.addSubviews(loginTitleLabel, emailTextField, passwordTextField, loginButton)
        loginTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            make.leading.trailing.equalToSuperview().inset(110)
        }
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(loginTitleLabel.snp.bottom).offset(31)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(52)
        }
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(11)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(52)
        }
        
        loginButton.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(52)
        }
    }
    
    private func setDelegate() {
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    private func setNavigationBar() {
        let leftBarButtonItem = UIBarButtonItem(image: UIImage.setNavigationBackButtonImage,
                                                style: .plain,
                                                target: nil,
                                                action: #selector(loginBackButtonTapped(_:)))
        self.navigationController?.navigationBar.tintColor = .designSystem(.grayD6D6D6)
        self.navigationItem.leftBarButtonItem = leftBarButtonItem
    }
    
    @objc func loginBackButtonTapped(_ sender: UIButton) {
        print("Back Button이 눌렸습니다")
    }
    
    @objc func loginButtonTapped(_ sender: UIButton) {
        print("로그인버튼이 눌렸습니다")
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let text = textField.text, let tvingTextField = textField as? TvingTextField else { return }
        guard let emailText = emailTextField.text, let passwordText = passwordTextField.text else { return }
        
        tvingTextField.clearButton.isHidden = text.isNotEmpty ? false : true
        loginButton.makeActiveTypeButton(activeType: emailText.checkEmail && passwordText.checkPassword ? .active : .nonActive)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        guard let text = textField.text, let tvingTextField = textField as? TvingTextField else { return }
        
        textField.makeTextFieldFocused()
        tvingTextField.rightViewMode = .always
        tvingTextField.clearButton.isHidden = text.isEmpty ? true : false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.makeTextFieldNormal()
        textField.rightViewMode = .never
    }
}

