//
//  LoginNicknameBottomSheetViewController.swift
//  TvingCloneCoding
//
//  Created by uiskim on 2023/04/15.
//

import UIKit

import SnapKit

protocol PassingNicknameDataProtocol: AnyObject {
    func sendNickname(_ nickName: String)
}

final class LoginNicknameBottomSheetViewController: UIViewController {
    
    weak var delegate: PassingNicknameDataProtocol?
    
    private let bottomSheetHeight: CGFloat
    
    private let backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .designSystem(.black)
        view.alpha = 0.0
        return view
    }()
    
    private let clearView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    private let handleView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 7/2
        return view
    }()
    
    
    private let bottomSheetView = TvingBottomSheet(color: .designSystem(.white))
    private let nicknameLabel = TvingLabel(title: "닉네임을 입력해주세요", fontWeight: ._500, fontSize: ._23, fontColor: .black)
    private let nicknameTextField = TvingTextField(textFieldType: .normal, sidePadding: 20)
    private let saveNicknameButton = TvingRectangleButton(title: "저장하기", buttonType: .nonActive)

    override func viewDidLoad() {
        super.viewDidLoad()
        nicknameTextField.delegate = self
        setHierarchy()
        setTapGesture()
        setAddTarget()
        setLayout()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showBottomSheet()
    }
    
    init(bottomSheetHeightPercentage: CGFloat) {
        self.bottomSheetHeight = bottomSheetHeightPercentage.makePercentage * Constant.Screen.height
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension LoginNicknameBottomSheetViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let text = textField.text else { return }
        nicknameTextField.showClearButton = text.isNotEmpty ? false : true
        saveNicknameButton.makeActiveTypeButton(activeType: text.isNotEmpty ? .active : .nonActive)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.rightViewMode = .always
    }
}

extension LoginNicknameBottomSheetViewController {
    
    
    private func setHierarchy() {
        view.addSubviews(backgroundView, bottomSheetView, clearView)
        clearView.addSubview(handleView)
        bottomSheetView.addSubviews(nicknameLabel, nicknameTextField, saveNicknameButton)
    }

    
    private func setTapGesture() {
        let backgroundTap = UITapGestureRecognizer(target: self, action: #selector(backgroundViewTapped(_:)))
        backgroundView.addGestureRecognizer(backgroundTap)
        backgroundView.isUserInteractionEnabled = true

    }
    
    private func setAddTarget() {
        saveNicknameButton.addTarget(self, action: #selector(saveNicknameButtonTapped), for: .touchUpInside)
    }
    
    private func setLayout() {
        backgroundView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        handleView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.width.equalTo(56)
            make.height.equalTo(7)
        }
        clearView.snp.makeConstraints { make in
            make.bottom.equalTo(bottomSheetView.snp.top)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(22)
        }
        
        bottomSheetView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(bottomSheetHeight)
            make.bottom.equalToSuperview().inset(-bottomSheetHeight)
        }
        
        nicknameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(50)
            make.leading.equalToSuperview().inset(20)
        }
        
        nicknameTextField.snp.makeConstraints { make in
            make.top.equalTo(nicknameLabel.snp.bottom).offset(21)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(52)
        }
        
        saveNicknameButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(30)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(52)
        }
    }
    
    private func hideBottomSheetAndDismissViewController() {
        hideBottomSheet(bottomSheet: bottomSheetView) {
            if self.presentationController != nil {
                self.dismiss(animated: true)
            }
        }
    }
    
    private func showBottomSheet() {
        bottomSheetView.snp.updateConstraints { $0.bottom.equalToSuperview() }
        UIView.animate(withDuration: 0.25) {
            self.backgroundView.alpha = 0.7
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func backgroundViewTapped(_ tapRecongnizer: UITapGestureRecognizer) {
        hideBottomSheetAndDismissViewController()
    }
    
    @objc func saveNicknameButtonTapped() {
        hideBottomSheet(bottomSheet: bottomSheetView) {
            if self.presentationController != nil {
                guard let nickName = self.nicknameTextField.text else { return }
                self.delegate?.sendNickname(nickName)
                self.dismiss(animated: true)
            }
        }
    }
    
    private func hideBottomSheet<T: TvingBottomSheet>(bottomSheet: T, duration: CGFloat = 0.25, completionHandler: @escaping () -> Void) {
        bottomSheet.snp.updateConstraints { $0.bottom.equalToSuperview().inset(-bottomSheet.bounds.height) }
        UIView.animate(withDuration: duration) {
            self.backgroundView.alpha = 0
            self.view.layoutIfNeeded()
        } completion: { _ in
            completionHandler()
        }
    }
    
}
