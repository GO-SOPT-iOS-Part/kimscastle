//
//  SettingTableViewCell.swift
//  TvingCloneCoding
//
//  Created by uiskim on 2023/05/04.
//

import UIKit

import SnapKit

final class SettingTableViewCell: UITableViewCell {
    
    static let cellId = "SettingTableViewCell"
    
    let label: UILabel = {
        let label = UILabel()
        label.textColor = .designSystem(.gray626262)
        return label
    }()

    private let myImageView = TvingImageView(imageName: .go)

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        selectionStyle = .none
        backgroundColor = .designSystem(.black)
        addSubview(label)
        addSubview(myImageView)
        label.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(20)
        }
        
        myImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(20)
            make.size.equalTo(20)
        }
        
    }

}
