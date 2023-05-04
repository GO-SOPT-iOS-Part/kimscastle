//
//  CaruselView.swift
//  TvingCloneCoding
//
//  Created by uiskim on 2023/05/04.
//

import UIKit

import SnapKit


final class CaruselView: UIView {
    
    enum ScrollType {
        case normal
        case last
        case none
    }
    
    var carouselTimer: Timer?
    
    private var items = CarueselPoster.dummy()
    private var initalItemCount: Int = 0
    private var carouselItemCount: Int = 0
    private let initalPage = Constant.Screen.width
    private var currentItem = 1

    private lazy var carouselView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = .init(width: Constant.Screen.width, height: 594)
        layout.minimumLineSpacing = 0
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.isScrollEnabled = true
        view.showsHorizontalScrollIndicator = false
        view.backgroundColor = .designSystem(.clear)
        view.register(CaruselCollectionViewCell.self, forCellWithReuseIdentifier: CaruselCollectionViewCell.cellId)
        view.isPagingEnabled = true
        return view
    }()
    
    private lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.currentPageIndicatorTintColor = .designSystem(.white)
        pageControl.pageIndicatorTintColor = .designSystem(.gray626262)
        pageControl.numberOfPages = items.count
        pageControl.currentPage = 0
        if #available(iOS 14.0, *) {
          pageControl.backgroundStyle = .minimal
          pageControl.allowsContinuousInteraction = false
        }
        pageControl.preferredIndicatorImage = UIImage(named: "pageIndicator_default")
        
        return pageControl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setHierarchy()
        setUI()
        setDelegate()
        setCarouselProperty()
        activateTimer(2)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        carouselView.move(to: initalPage)
        pageControl.subviews.forEach {
            $0.transform = CGAffineTransform(scaleX: 2/3, y: 2/3)
        }
    }
}

extension CaruselView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        items.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CaruselCollectionViewCell.cellId, for: indexPath) as? CaruselCollectionViewCell else { return CaruselCollectionViewCell()}
        cell.item = items[indexPath.item]
        return cell
    }
}

extension CaruselView: UICollectionViewDelegate {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        initalizeTimer(interval: 2)
        
        let nextPage = Constant.Screen.width * Double(carouselItemCount - 2)
        let initalPage = Constant.Screen.width
        
        let checkScrollType: (UIScrollView) -> ScrollType = { i in
            if i.contentOffset.x == 0 { return .normal }
            if i.contentOffset.x == Double(self.carouselItemCount - 1) * Constant.Screen.width { return .last }
            return .none
        }

        let scroll: (ScrollType) -> Void = { type in
            if type == .last { scrollView.move(to: initalPage) }
            if type == .normal { scrollView.move(to: nextPage) }
        }
        
        scroll(checkScrollType(scrollView))
        
        pageControl.currentPage = Int(scrollView.contentOffset.x / scrollView.frame.maxX) - 1
        
    }
    
    func initalizeTimer(interval: Double) {
        invalidateTimer()
        activateTimer(interval)
    }
}

private extension CaruselView {
    
    func setHierarchy() {
        backgroundColor = .white
        addSubview(carouselView)
        addSubview(pageControl)
    }
    
    func setUI() {
        carouselView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(60)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(594)
        }
        
        pageControl.snp.makeConstraints { make in
            make.bottom.equalTo(carouselView.snp.bottom).offset(-20)
            make.leading.equalToSuperview().inset(-60)
            make.width.equalTo(200)
        }
    }
    
    func setDelegate() {
        carouselView.dataSource = self
        carouselView.delegate = self
    }
    
    func setCarouselProperty() {
        initalItemCount = items.count
        items.makeInfinityCarouselArray()
        carouselItemCount = items.count
    }
    
    func activateTimer(_ interval: Double) {
        carouselTimer?.invalidate()

        carouselTimer = Timer.addCarouselTimerAction(timeInterval: interval) {
            self.slidePageAutometically(from: self.carouselView, range: self.initalItemCount)
        }
    }
    
    func slidePageAutometically(from view: UICollectionView, range pageCount: Int?) {
        guard let pageCount else { return }
        let changeInitalPage = { i in
            view.scroll(to: i, animation: true)
            if i == pageCount + 1 { DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { view.scroll(to: 1) }
                self.currentItem = 1
            }
            self.pageControl.currentPage = (i - 1) % self.initalItemCount
        }
        
        let scrollCompletion: (Int) -> ((Int) -> Void) -> Void = { i in { $0(i) } }
        currentItem += 1
        currentItem = max(1, currentItem % carouselItemCount)
        scrollCompletion(currentItem)(changeInitalPage)
    }
    
    func invalidateTimer() {
        carouselTimer?.invalidate()
    }
}

