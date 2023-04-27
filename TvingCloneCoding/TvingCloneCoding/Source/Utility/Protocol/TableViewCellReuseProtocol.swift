//
//  TableViewCellReuseProtocol.swift
//  TvingCloneCoding
//
//  Created by uiskim on 2023/04/27.
//

import UIKit

protocol TableViewCellReuseProtocol where Self: UITableViewCell {
    static func register(tableView: UITableView)
    static func dequeueReusableCell(tableView: UITableView) -> Self
    static var reuseIdentifier: String { get }
}


extension TableViewCellReuseProtocol {
    static func register(tableView: UITableView) {
        tableView.register(Self.self, forCellReuseIdentifier: self.reuseIdentifier)
    }
    
    static func dequeueReusableCell(tableView: UITableView) -> Self {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: self.reuseIdentifier), let returnCell = cell as? Self else { fatalError("Error! \(self.reuseIdentifier)") }
        return returnCell
    }
    
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
