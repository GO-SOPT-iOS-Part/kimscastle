//
//  ViewController.swift
//  SOPT_Week4
//
//  Created by uiskim on 2023/05/06.
//

import UIKit

final class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        signUp()
    }
    
    private func signUp() {
        
        SignUpService.shared.signUp(email: "seungchan@naver.com",
                                    nickname: "godios",
                                    password: "Qwer1234!") { response in
            switch response {
            case .success(let data):
                guard let data = data as? SignUpResponse else { return }
                dump(data)
            default:
                return
            }
        }
    }
}

