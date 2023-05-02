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
    
//    private var menu = CustomMenuBar()
    
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
//        view.addSubview(menu)
    }
    
    func setLayout() {
        mainPageViewController.view.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(-view.safeAreaHeight)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    func setButtonTarget() {
        
    }
    
    func setDelegate() {
        mainPageViewController.dataSource = self
        mainPageViewController.delegate = self
    }
    
    func setNavigation() {
        let push = { self.navigationController?.pushViewController($0, animated: false)}
        tvingNavigationBar(.designSystem(.white),
                           left: [UIImageView(image: UIImage(named: Constant.ImageName.logo))],
                           right: [UIButton.iconButton(.profile, action: { _ in push(SettingViewController()) })], spacing: 2)
    }
    
    func setPageViewController() {
        dataSourceViewController = PageType.allCases.map{$0.viewController}
    }
    
    func changeViewController(before beforeIndex: Int, after newIndex: Int) {
        let direction: UIPageViewController.NavigationDirection = beforeIndex < newIndex ? .forward : .reverse
        mainPageViewController.setViewControllers([dataSourceViewController[currentPage]], direction: direction, animated: true, completion: nil)
//        menu.isSelected = newIndex
    }
}

extension MainViewController: UIPageViewControllerDelegate {
    
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
