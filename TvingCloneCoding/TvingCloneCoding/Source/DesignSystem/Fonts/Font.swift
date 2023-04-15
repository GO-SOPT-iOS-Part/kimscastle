//
//  Font.swift
//  TvingCloneCoding
//
//  Created by uiskim on 2023/04/12.
//

import UIKit

enum Font {
    enum Name: String {
        case system
        case pretendard = "Pretendard"
    }
    
    // 피그마기준 존재하는 font size => 14,15,23
    enum Size: CGFloat {
        case _14 = 14
        case _15 = 15
        case _23 = 23
    }

    enum Weight: String {
//        case _100 = "Thin"
//        case _200 = "ExtraLight"
//        case _300 = "Light"
        case _400 = "Regular"
        case _500 = "Medium"
        case _600 = "SemiBold"
        case _700 = "Bold"

        var real: UIFont.Weight {
            switch self {
//            case ._100:
//                return .thin
//            case ._200:
//                return .ultraLight
//            case ._300:
//                return .light
            case ._400:
                return .regular
            case ._500:
                return .medium
            case ._600:
                return .semibold
            case ._700:
                return .bold
            }
        }
    }

    struct CustomFont {
        private let _name: Name
        private let _weight: Weight

        init(name: Name, weight: Weight) {
            self._name = name
            self._weight = weight
        }

        var name: String {
            "\(_name.rawValue)-\(_weight.rawValue)"
        }

        var `extension`: String {
            "ttf"
        }
    }

    static func registerFonts() {
        fonts.forEach { font in
            Font.registerFont(fontName: font.name, fontExtension: font.extension)
        }
    }
}

extension Font {
    static var fonts: [CustomFont] {
        [
            CustomFont(name: .pretendard, weight: ._400),
            CustomFont(name: .pretendard, weight: ._500),
            CustomFont(name: .pretendard, weight: ._600),
            CustomFont(name: .pretendard, weight: ._700)
        ]
    }

    private static func registerFont(fontName: String, fontExtension: String) {
        guard let fontURL = Bundle(identifier: "uikit.TvingCloneCoding")?.url(forResource: fontName, withExtension: fontExtension),
              let fontDataProvider = CGDataProvider(url: fontURL as CFURL),
              let font = CGFont(fontDataProvider) else {
            debugPrint("Couldn't create font from filename: \(fontName) with extension \(fontExtension)")
            return
        }

        var error: Unmanaged<CFError>?
        CTFontManagerRegisterGraphicsFont(font, &error)
    }
}
