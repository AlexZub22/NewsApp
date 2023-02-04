//
//  ViewController.swift
//  NewsApp
//
//  Created by Alexander Zub on 04.02.2023.
//

import UIKit

class ViewController: UIViewController {

    private let tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "News"
        view.backgroundColor = .systemBackground
        API.shared.getTopStories { result in
            switch result {
            case .success(let response):
                break
            case.failure(let error):
                print(error)
            }
        }
    }
    


}

