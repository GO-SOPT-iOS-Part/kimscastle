//
//  TotalViewController.swift
//  CompositionalLayout
//
//  Created by uiskim on 2023/05/01.
//

import UIKit

import SnapKit

final class MainViewController: UIViewController {
    
    weak var delgate: ScrollDelegate?
    private let dataFetchable: DataFechable
    
    private let collectionView: UICollectionView = {
        let collectionViewLayout = UICollectionViewLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionView.backgroundColor = .none
        collectionView.bounces = false
        collectionView.contentInsetAdjustmentBehavior = .never
        return collectionView
    }()
    
    private var sections: [ListSection] = []
    
    init(dataFetchable: DataFechable) {
        self.dataFetchable = dataFetchable
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setHierarchy()
        setLayout()
        setDelegate()
        setCollectionView()
        dataFetchable.fetchMovie { datas in
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
    
    private func createMainVideoSection(type: PosterType, headerHeight: CGFloat = 20) -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
        item.contentInsets = type.itemContentInset
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .absolute(type.groupWidth), heightDimension: .estimated(type.groupHeight)), subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = type.sectionContentInset
        section.orthogonalScrollingBehavior = .continuous
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: .init(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(type.headerHeight(height: headerHeight))), elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        section.boundarySupplementaryItems = [header]
        return section
    }
}


