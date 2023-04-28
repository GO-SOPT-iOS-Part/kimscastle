//
//  String+.swift
//  TvingCloneCoding
//
//  Created by uiskim on 2023/04/13.
//

import UIKit

extension String {
    
    var checkEmail: Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: self)
    }

    var checkPassword: Bool {
        guard self.count > 8 else { return false }
        return true
    }
    
    var isNotEmpty: Bool {
        return self.isEmpty ? false : true
    }
}


extension String {
    /// Label안에 Image를 넣을때 적절한 String타입으로 만들어주는 함수
    /// - Returns: Label을 리턴해줌
    func makeNSAttributedString() -> NSAttributedString {
        return NSAttributedString(string: self)
    }
}
