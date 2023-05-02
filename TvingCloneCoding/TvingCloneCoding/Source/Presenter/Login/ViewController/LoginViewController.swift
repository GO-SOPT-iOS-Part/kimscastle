//
//  LoginViewController.swift
//  TvingCloneCoding
//
//  Created by uiskim on 2023/04/12.
//

import UIKit

import SnapKit

final class LoginViewController: UIViewController {
    
    private var nickName: String?
    
    private let loginTitleLabel = TvingLabel(title: "TVING ID 로그인", fontWeight: ._500, fontSize: ._23, fontColor: .white)
    private let emailTextField = TvingTextField(textFieldType: .email, sidePadding: 20)
    private let passwordTextField = TvingTextField(textFieldType: .password, sidePadding: 20)
    private let loginSettingView = LoginSettingView()    
    private lazy var loginButton = TvingRectangleButton(title: Constant.ButtonTitle.loginButtonTitle, buttonType: .nonActive)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .designSystem(.black)
        self.navigationController?.navigationBar.barStyle = .black
        setHierarchy()
        setUI()
        setNavigationBar()
        setDelegate()
        setButtonTarget()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}


extension LoginViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let text = textField.text, let tvingTextField = textField as? TvingTextField else { return }
        //guard let emailText = emailTextField.text, let passwordText = passwordTextField.text else { return }
        
        tvingTextField.showClearButton = text.isNotEmpty ? false : true
        loginButton.makeActiveTypeButton(activeType: .active)
        
        // MARK: - 완성되면 다시 원상태로
        //loginButton.makeActiveTypeButton(activeType: checkUserInputIsValid(emailText)(passwordText)(nickName) ? .active : .nonActive)
    }
    
    private func checkUserInputIsValid(_ email: String) -> (_ password: String) -> (_ nickName: String?) -> Bool {
        return { password in
            return { nickName in
                return email.checkEmail && password.checkPassword && ((nickName?.isNotEmpty) != nil)
            }
        }
    }
    
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        guard let text = textField.text, let tvingTextField = textField as? TvingTextField else { return }
        
        textField.makeTextFieldFocused()
        tvingTextField.rightViewMode = .always
        tvingTextField.showClearButton = text.isEmpty ? true : false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.makeTextFieldNormal()
        textField.rightViewMode = .never
    }
}

private extension LoginViewController {
    func setUI() {
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
        
        loginSettingView.snp.makeConstraints { make in
            make.top.equalTo(loginButton.snp.bottom).offset(31)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(200)
        }
    }
    
    func setButtonTarget() {
        loginSettingView.makeNicknameButton.addButtonAction { sender in
            let bottomSheetVC = LoginNicknameBottomSheetViewController(bottomSheetHeightPercentage: 50)
            bottomSheetVC.delegate = self
            bottomSheetVC.modalPresentationStyle = .overFullScreen
            self.present(bottomSheetVC, animated: false)
        }
        
        loginButton.addButtonAction { sender in
            let loginCompletedViewController = LoginCompletedViewController()
            loginCompletedViewController.userNickName = self.nickName
            self.navigationController?.pushViewController(loginCompletedViewController, animated: true)
        }
    }
    
    func setHierarchy() {
        view.addSubviews(loginTitleLabel, emailTextField, passwordTextField, loginButton, loginSettingView)
    }
    
    func setDelegate() {
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    func setNavigationBar() {
        tvingNavigationBar(.designSystem(.grayD6D6D6),
                           left: [UIButton.iconButton(.back, action: { _ in print("back Button이 눌렸습니다") })],
                           right: [],
                           spacing: 0)
    }

}

extension LoginViewController: PassingNicknameDataProtocol {
    func sendNickname(_ nickName: String) {
        guard let emailText = emailTextField.text, let passwordText = passwordTextField.text else { return }
        self.nickName = nickName
        loginButton.makeActiveTypeButton(activeType: emailText.checkEmail && passwordText.checkPassword ? .active : .nonActive)
    }

}

