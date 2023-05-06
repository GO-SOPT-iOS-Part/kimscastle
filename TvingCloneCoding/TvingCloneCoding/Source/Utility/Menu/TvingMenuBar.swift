//
//  TvingMenuBar.swift
//  TvingCloneCoding
//
//  Created by uiskim on 2023/05/02.
//

import UIKit

final class TvingMenuBar: UIView {
    
    var isSelected: Int? {
        didSet {
            updateBar(from: isSelected)
        }
    }
    
    weak var delegate: MenuItemDelegate?
    
    private let labels = MenuPageType.allCases.map{ $0.rawValue }
    
    private var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        let view = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        view.backgroundColor = .designSystem(.clear)
        view.showsVerticalScrollIndicator = false
        return view
    }()
    
    private var underLine: UIView = {
        let view = UIView()
        view.backgroundColor = .designSystem(.white)
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
        setHierarchy()
        setLayout()
        setDelegate()
        setCollectionView()
    }
    
    override func draw(_ rect: CGRect) {
        self.isSelected = 0
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension TvingMenuBar {
    func setUI() {
        self.backgroundColor = .designSystem(.clear)
    }
    
    func setHierarchy() {
        addSubview(collectionView)
        addSubview(underLine)
    }
    
    func setLayout() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func setDelegate() {
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    func setCollectionView() {
        collectionView.register(TvingMenuCollectionViewCell.self, forCellWithReuseIdentifier: TvingMenuCollectionViewCell.cellId)
    }
    
    func updateBar(from isSelected: Int?) {
        guard let isSelected else { return }
        collectionView.selectItem(at: IndexPath(item: isSelected, section: 0), animated: true, scrollPosition: .centeredHorizontally)
        guard let cell = collectionView.cellForItem(at: IndexPath(item: isSelected, section: 0)) as? TvingMenuCollectionViewCell else { return }
        
        underLine.snp.remakeConstraints { make in
            make.bottom.equalTo(collectionView.snp.bottom)
            make.leading.equalTo(cell.snp.leading).offset(5)
            make.trailing.equalTo(cell.snp.trailing).offset(-5)
            make.height.equalTo(3)
            
        }
        
        UIView.animate(withDuration: 0.3) {
            self.layoutIfNeeded()
        }
    }
}


extension TvingMenuBar: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return labels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TvingMenuCollectionViewCell.cellId, for: indexPath) as? TvingMenuCollectionViewCell else { return TvingMenuCollectionViewCell()}
        cell.title = labels[indexPath.item]
        return cell
    }
}

extension TvingMenuBar: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.menuView(didSelectItemAt: indexPath)
    }
}

extension TvingMenuBar: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: labels[indexPath.row].calcuateWidth(addPadding: 9), height: collectionView.frame.height)
    }
}
