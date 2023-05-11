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

final class MainViewController: UIViewController {
    
    weak var delgate: ScrollDelegate?
    private let cache = ImageCacheManager.shared
    
    private let collectionView: UICollectionView = {
        let collectionViewLayout = UICollectionViewLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionView.backgroundColor = .none
        collectionView.bounces = false
        collectionView.contentInsetAdjustmentBehavior = .never
        return collectionView
    }()
    
    private var sections: [ListSection] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setHierarchy()
        setLayout()
        setDelegate()
        setCollectionView()
        MainViewDataService.shared.fetchMovie { datas in
            self.sections = datas
            self.collectionView.reloadData()
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
        case .mainPoster:
            let cell = MainPosterCollectionViewCell.dequeueReusableCell(collectionView: collectionView, indexPath: indexPath)
            return cell
        case .mustWatchList(let mustWatchList):
            let cell = MustWatchCollectionViewCell.dequeueReusableCell(collectionView: collectionView, indexPath: indexPath)
            cell.data = mustWatchList[indexPath.row]
            return cell
        case .quickVODList(let quickVODList):
            let cell = QuickVODCollectionViewCell.dequeueReusableCell(collectionView: collectionView, indexPath: indexPath)
            cell.data = quickVODList[indexPath.row]
            return cell
        case .watchingList(let watchingList):
            let cell = WatchingCollectionViewCell.dequeueReusableCell(collectionView: collectionView, indexPath: indexPath)
            cell.data = watchingList[indexPath.row]
            return cell
        case .rankingList(let rankingList):
            let cell = RankingCollectionViewCell.dequeueReusableCell(collectionView: collectionView, indexPath: indexPath)
            cell.data = rankingList[indexPath.row]
            return cell
        case .famousLiveChannel(let famousLiveChannel):
            let cell = FamousLiveChannelCollectionViewCell.dequeueReusableCell(collectionView: collectionView, indexPath: indexPath)
            cell.data = famousLiveChannel[indexPath.row]
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeaderSupplementaryView.viewId, for: indexPath) as! HeaderSupplementaryView
            header.title = sections[indexPath.section].title
            return header
        default:
            return UICollectionReusableView()
        }
    }
}

private extension MainViewController {
    
    func setUI() {
        view.backgroundColor = .designSystem(.black)
    }
    
    func setHierarchy() {
        view.addSubview(collectionView)
    }
    
    func setLayout() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func setDelegate() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func setCollectionView() {

        MainPosterCollectionViewCell.register(collectionView: collectionView)
        MustWatchCollectionViewCell.register(collectionView: collectionView)
        QuickVODCollectionViewCell.register(collectionView: collectionView)
        WatchingCollectionViewCell.register(collectionView: collectionView)
        RankingCollectionViewCell.register(collectionView: collectionView)
        FamousLiveChannelCollectionViewCell.register(collectionView: collectionView)
        
        collectionView.register(HeaderSupplementaryView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderSupplementaryView.viewId)

        collectionView.collectionViewLayout = createLayout()
    }

    
    private func createLayout() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { [weak self] secitonIndex, _ in
            guard let self = self else { return nil }
            let section = self.sections[secitonIndex]
            switch section {
            case .mainPoster:
                return createMainVideoSection(type: .header)
            case .mustWatchList(_):
                return createMainVideoSection(type: .vertical)
            case .watchingList(_), .rankingList(_):
                return createMainVideoSection(type: .vertical)
            case .quickVODList(_), .famousLiveChannel(_):
                return createMainVideoSection(type: .horizontal)
            }
        }
    }
    
    /// 추후수정할 코드
    private func createMainVideoSection(type: PosterType, headerHeight: CGFloat = 20) -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
        item.contentInsets = .init(top: 10, leading: 5, bottom: 10, trailing: 5)
        switch type {
        case .vertical:
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .absolute(Constant.Screen.width/3.5), heightDimension: .estimated(180)), subitems: [item])
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = .init(top: 0, leading: 0, bottom: 20, trailing: 0)
            section.orthogonalScrollingBehavior = .continuous
            let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: .init(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(headerHeight)), elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
            section.boundarySupplementaryItems = [header]
            return section
        case .horizontal:
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .absolute(Constant.Screen.width/2), heightDimension: .estimated(130)), subitems: [item])
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = .init(top: 0, leading: 0, bottom: 20, trailing: 0)
            section.orthogonalScrollingBehavior = .continuous
            let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: .init(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(headerHeight)), elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
            section.boundarySupplementaryItems = [header]
            return section
        case .header:
            item.contentInsets = .zero
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .absolute(Constant.Screen.width), heightDimension: .estimated(654)), subitems: [item])
            let section = NSCollectionLayoutSection(group: group)
            section.orthogonalScrollingBehavior = .continuous
            return section
        }
    }
}


