//
//  TotalViewController.swift
//  CompositionalLayout
//
//  Created by uiskim on 2023/05/01.
//

import UIKit

import SnapKit

protocol ScrollDelegate: AnyObject {
    func scroll(yContentOffset: CGFloat)
}

class MainViewController: UIViewController {
    
    weak var delgate: ScrollDelegate?
    
    private let collectionView: UICollectionView = {
        let collectionViewLayout = UICollectionViewLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionView.backgroundColor = .none
        collectionView.bounces = false
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private var sections = MainViewData.shared.pageData

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        view.addSubview(collectionView)

        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(MustWatchCollectionViewCell.self, forCellWithReuseIdentifier: MustWatchCollectionViewCell.cellId)
        collectionView.register(QuickVODCollectionViewCell.self, forCellWithReuseIdentifier: QuickVODCollectionViewCell.cellId)
        collectionView.register(WatchingCollectionViewCell.self, forCellWithReuseIdentifier: WatchingCollectionViewCell.cellId)
        collectionView.register(RankingCollectionViewCell.self, forCellWithReuseIdentifier: RankingCollectionViewCell.cellId)
        collectionView.register(FamousLiveChannelCollectionViewCell.self, forCellWithReuseIdentifier: FamousLiveChannelCollectionViewCell.cellId)
        
        collectionView.register(HeaderSupplementaryView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderSupplementaryView.viewId)

        collectionView.collectionViewLayout = createLayout()
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension MainViewController: UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        delgate?.scroll(yContentOffset: scrollView.contentOffset.y)
    }
}

extension MainViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sections[section].counts
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch sections[indexPath.section] {
        case .mustWatchList(let mustWatchList):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MustWatchCollectionViewCell.cellId, for: indexPath) as? MustWatchCollectionViewCell else { return MustWatchCollectionViewCell()}
            cell.data = mustWatchList[indexPath.row]
            return cell
        case .quickVODList(let quickVODList):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: QuickVODCollectionViewCell.cellId, for: indexPath) as? QuickVODCollectionViewCell else { return QuickVODCollectionViewCell()}
            cell.data = quickVODList[indexPath.row]
            return cell
        case .watchingList(let watchingList):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WatchingCollectionViewCell.cellId, for: indexPath) as? WatchingCollectionViewCell else { return WatchingCollectionViewCell()}
            cell.data = watchingList[indexPath.row]
            return cell
        case .rankingList(let rankingList):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RankingCollectionViewCell.cellId, for: indexPath) as? RankingCollectionViewCell else { return RankingCollectionViewCell()}
            cell.data = rankingList[indexPath.row]
            return cell
        case .famousLiveChannel(let famousLiveChannel):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FamousLiveChannelCollectionViewCell.cellId, for: indexPath) as? FamousLiveChannelCollectionViewCell else { return FamousLiveChannelCollectionViewCell()}
            cell.data = famousLiveChannel[indexPath.row]
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeaderSupplementaryView.viewId, for: indexPath) as! HeaderSupplementaryView
            if indexPath.section == 0 {
                header.isFirst = true
            }
            header.title.text = sections[indexPath.section].title
            return header
        default:
            return UICollectionReusableView()
        }
    }
}

extension MainViewController {
    private func createLayout() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { [weak self] secitonIndex, _ in
            guard let self = self else { return nil }
            let section = self.sections[secitonIndex]
            switch section {
            case .mustWatchList(_):
                return createMainVideoSection(type: .vertical, headerHeight: 670)
            case .watchingList(_), .rankingList(_):
                return createMainVideoSection(type: .vertical)
            case .quickVODList(_), .famousLiveChannel(_):
                return createMainVideoSection(type: .horizontal)
            }
        }
    }
    
    private func createMainVideoSection(type: PosterType, headerHeight: CGFloat = 20) -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
        item.contentInsets = .init(top: 10, leading: 5, bottom: 10, trailing: 5)
        switch type {
        case .vertical:
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .absolute(Constant.Size.width/3.5), heightDimension: .estimated(200)), subitems: [item])
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = .init(top: 0, leading: 0, bottom: 20, trailing: 0)
            section.orthogonalScrollingBehavior = .continuous
            let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: .init(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(headerHeight)), elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
            section.boundarySupplementaryItems = [header]
            return section
        case .horizontal:
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .absolute(Constant.Size.width/2), heightDimension: .estimated(150)), subitems: [item])
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = .init(top: 0, leading: 0, bottom: 20, trailing: 0)
            section.orthogonalScrollingBehavior = .continuous
            let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: .init(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(headerHeight)), elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
            section.boundarySupplementaryItems = [header]
            return section
        }
    }
}


