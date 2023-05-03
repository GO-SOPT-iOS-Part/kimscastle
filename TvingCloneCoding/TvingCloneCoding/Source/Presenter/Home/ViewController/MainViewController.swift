//
//  MainViewController.swift
//  TvingCloneCoding
//
//  Created by uiskim on 2023/04/27.
//

import UIKit

import SnapKit

final class MainViewController: UIViewController {
    
    private var currentPage: Int = 0 {
        didSet {
            changeViewController(before: oldValue, after: currentPage)
        }
    }
    
    private lazy var mainPageViewController: UIPageViewController = {
        let viewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
        return viewController
    }()
    
    private var dataSourceViewController: [UIViewController] = []
    
    private var menuBar = TvingMenuBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setHierarchy()
        setLayout()
        setButtonTarget()
        setDelegate()
        setNavigation()
        setPageViewController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        currentPage = 0
    }

}

private extension MainViewController {
    func setUI() {
        view.backgroundColor = .designSystem(.black)
    }
    
    func setHierarchy() {
        addChild(mainPageViewController)
        view.addSubview(mainPageViewController.view)
        view.addSubview(menuBar)
    }
    
    func setLayout() {
        mainPageViewController.view.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(-90)
            make.leading.trailing.bottom.equalToSuperview()
        }
        mainPageViewController.didMove(toParent: self)
        
        menuBar.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().inset(15)
            make.trailing.equalToSuperview().inset(15)
            make.height.equalTo(50)
        }
    }
    
    func setButtonTarget() {
    }
    
    func setDelegate() {
        mainPageViewController.dataSource = self
        mainPageViewController.delegate = self
        menuBar.delegate = self
    }
    
    func setNavigation() {
        let push = { self.navigationController?.pushViewController($0, animated: false)}
        tvingNavigationBar(.designSystem(.white),
                           left: [UIImageView(image: .assetImage(.logo))],
                           right: [UIButton.iconButton(.profile, action: { _ in push(SettingViewController()) })], spacing: 2)
    }
    
    func setPageViewController() {
        dataSourceViewController = MenuPageType.allCases.map{ $0.viewController }
//        let homeViewController = HomeViewController()
//        homeViewController.delegate = self
//        dataSourceViewController[0] = homeViewController
    }
    
    func changeViewController(before beforeIndex: Int, after newIndex: Int) {
        let direction: UIPageViewController.NavigationDirection = beforeIndex < newIndex ? .forward : .reverse
        mainPageViewController.setViewControllers([dataSourceViewController[currentPage]], direction: direction, animated: true, completion: nil)
        menuBar.isSelected = newIndex
    }
}

extension MainViewController: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard let currentVC = pageViewController.viewControllers?.first,
              let currentIndex = dataSourceViewController.firstIndex(of: currentVC) else { return }
        currentPage = currentIndex
    }
}

extension MainViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = dataSourceViewController.firstIndex(of: viewController) else { return nil }
        let nextIndex = currentIndex + 1
        guard nextIndex != dataSourceViewController.count else { return nil }
        return dataSourceViewController[nextIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = dataSourceViewController.firstIndex(of: viewController) else { return nil }
        let previousIndex = currentIndex - 1
        guard previousIndex >= 0 else { return nil }
        return dataSourceViewController[previousIndex]
    }
}

extension MainViewController: MenuItemDelegate {
    func menuView(didSelectItemAt indexPath: IndexPath) {
        currentPage = indexPath.row
    }
}
