//
//  MenuListViewController.swift
//  CircularBannerDemo
//
//  Created by Apinun Wongintawang on 3/2/2569 BE.
//

import UIKit

class MenuListViewController: UIViewController {
    
    @IBOutlet private var tableView: UITableView!
    var menuList: [MenuListModel] = [
        .init(title: "Circular Banner", icon: "🫣", build: {
            let vc = CircularBannerViewController(nibName: "CircularBannerViewController", bundle: nil)
            return vc
        })
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.delegate = self
        tableView.dataSource = self
        
        self.title = "Menu List"
    }
}

extension MenuListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let item = menuList[indexPath.row]
        cell.textLabel?.text = "\(item.icon) \(item.title)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuList.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = menuList[indexPath.row]
        let vc = item.build()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}


