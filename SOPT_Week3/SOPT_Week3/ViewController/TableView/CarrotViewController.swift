//
//  CarrotViewController.swift
//  SOPT_Week3
//
//  Created by uiskim on 2023/04/22.
//
import UIKit

import SnapKit
import Then

import RealmSwift

final class CarrotViewController: BaseViewController {
    
    private let tableView = UITableView()
    
    var task: Results<CarrotRealm>!
    let localRealm = try! Realm()
    
    private var dummy: [Carrot] = [] {
        didSet {
            tableView.reloadData()
            dump(dummy)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        task = localRealm.objects(CarrotRealm.self).sorted(byKeyPath: "id", ascending: true)
        dummy = Array(task).map{ Carrot(id: $0.id, image: .hypeBoy, product: $0.product, place: $0.place, time: $0.time, tradeStatus: .completed, price: $0.price, isChecked: $0.isChecked) }
        
    }
    
    override func setStyle() {
        
        view.backgroundColor = .white
        
        tableView.do {
            $0.register(CarrotTableViewCell.self, forCellReuseIdentifier: CarrotTableViewCell.identifier)
            $0.rowHeight = 120
            $0.delegate = self
            $0.dataSource = self
        }
    }
    
    override func setLayout() {
        
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.leading.trailing.equalToSuperview()
        }
    }
}

extension CarrotViewController: UITableViewDelegate {}

extension CarrotViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dummy.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CarrotTableViewCell.identifier, for: indexPath) as? CarrotTableViewCell else { return UITableViewCell() }
        
        cell.configureCell(dummy[indexPath.row])
        cell.delegate = self
        
        return cell
    }
}

extension CarrotViewController: StarTapped {
    func changeStarData(data: Carrot) {
        try! localRealm.write {
            localRealm.add(CarrotRealm(id: data.id,
                                       product: data.product,
                                       place: data.place,
                                       time: data.time,
                                       price: data.price,
                                       isChecked: data.isChecked), update: .modified)
        }
    }
}
