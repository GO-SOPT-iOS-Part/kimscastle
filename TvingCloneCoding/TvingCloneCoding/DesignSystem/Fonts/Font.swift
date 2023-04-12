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
    
    enum Size: CGFloat {
        case _10 = 10
        case _11 = 11
        case _13 = 13
        case _15 = 15
        case _17 = 17
        case _20 = 20
        case _25 = 25
        case _30 = 30
    }

    enum Weight: String {
        case heavy = "Heavy"
        case bold = "Bold"
        case medium = "Medium"
        case regular = "Regular"
        case light = "Light"

        var real: UIFont.Weight {
            switch self {
            case .heavy:
                return .heavy
                
            case .bold:
                return .bold
                
            case .medium:
                return .medium
                
            case .regular:
                return .regular
                
            case .light:
                return .light
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
            "otf"
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
            CustomFont(name: .pretendard, weight: .light),
            CustomFont(name: .pretendard, weight: .medium),
            CustomFont(name: .pretendard, weight: .bold)
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
