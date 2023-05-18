//
//  ViewController.swift
//  TvingCloneCoding
//
//  Created by uiskim on 2023/05/04.
//

import UIKit

import SnapKit

extension MainViewDataService: DataFechable {}

final class HomeViewController: UIViewController {
    private var currentPage: Int = 0 {
        didSet {
            changeViewController(before: oldValue, after: currentPage)
        }
    }
    
    private let profileButton: UIButton = .iconButton(.profile)
    private lazy var naviBar = TvingNavigationBar(profileButton: profileButton)
    
    
    private let backgroundView: UIView = {
        let view = UIView()
        view.layer.backgroundColor = UIColor.black.cgColor
        view.layer.opacity = 0
        return view
    }()
    
    private lazy var pageViewController: UIPageViewController = {
        let viewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
        return viewController
    }()
    
    private var dataSourceViewController: [UIViewController] = []
    
    private var menu = TvingMenuBar()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setHierarchy()
        setLayout()
        setDelegate()
        setPageViewController()
        setButtonAction()
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
        currentPage = 0
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

}

private extension HomeViewController {
    func setUI() {
        view.backgroundColor = .designSystem(.black)
    }
    
    func setHierarchy() {
        addChild(pageViewController)
        view.addSubview(pageViewController.view)
        view.addSubview(backgroundView)
        view.addSubview(naviBar)
        view.addSubview(menu)
    }
    
    func setLayout() {
        naviBar.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(80)
        }
        
        pageViewController.view.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(-90)
            make.leading.trailing.bottom.equalToSuperview()
        }
        pageViewController.didMove(toParent: self)
        
        backgroundView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(-90)
            make.trailing.leading.equalToSuperview()
            make.bottom.equalTo(menu.snp.bottom)
        }
        
        menu.snp.makeConstraints { make in
            make.top.equalTo(naviBar.snp.bottom)
            make.leading.equalToSuperview().inset(15)
            make.trailing.equalToSuperview().inset(15)
            make.height.equalTo(50)
        }
    }
    
    func setDelegate() {
        pageViewController.dataSource = self
        pageViewController.delegate = self
        menu.delegate = self
    }
    
    func setPageViewController() {
        dataSourceViewController = MenuPageType.allCases.map{ $0.viewController }
        let firstVC = MainViewController(dataFetchable: MainViewDataService.shared)
        firstVC.delgate = self
        dataSourceViewController[0] = firstVC
    }
    
    func setButtonAction() {
        profileButton.addButtonAction { _ in
            let settingViewController = SettingViewController()
            self.navigationController?.pushViewController(settingViewController, animated: false)
            self.navigationController?.isNavigationBarHidden = false
        }
    }
    
    func changeViewController(before beforeIndex: Int, after newIndex: Int) {
        let direction: UIPageViewController.NavigationDirection = beforeIndex < newIndex ? .forward : .reverse
        pageViewController.setViewControllers([dataSourceViewController[currentPage]], direction: direction, animated: true, completion: nil)
        menu.isSelected = newIndex
    }
}

extension HomeViewController: UIPageViewControllerDataSource {
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

extension HomeViewController: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard let currentVC = pageViewController.viewControllers?.first,
              let currentIndex = dataSourceViewController.firstIndex(of: currentVC) else { return }
        currentPage = currentIndex
    }
}

extension HomeViewController: MenuItemDelegate {
    func menuView(didSelectItemAt indexPath: IndexPath) {
        currentPage = indexPath.row
    }
}

extension HomeViewController: ScrollDelegate {
    func scroll(yContentOffset: CGFloat) {
        backgroundView.layer.opacity = yContentOffset > 50 ? Float(Float(0.5*(yContentOffset)/350)+(23/35)) : 0
        naviBar.alpha = yContentOffset > 20 ? 0 : 1
        
        naviBar.snp.updateConstraints { make in
            make.top.equalToSuperview().inset(-min(30, yContentOffset))
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(80)
        }
    }
}
