//
//  ViewController.swift
//  NoStoryboard
//
//  Created by Kalyan Mannem on 10/12/19.
//  Copyright © 2019 CompIndia. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
    let tableView = UITableView()
    var safeArea: UILayoutGuide!
    let queryService = QueryService()

    var results: [Row] = []
    override func loadView()
    {
        super.loadView()
        safeArea = view.layoutMarginsGuide
        setUpTableView()
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        tableView.dataSource = self
        queryService.getResults { [weak self](results, title, errorMessage) in
            if let res = results{
                self?.results = res
                self?.tableView.reloadData()
            }
        }
    }
    
    func setUpTableView()
    {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }

}

extension ViewController: UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let row = results[indexPath.row]
        cell.textLabel?.text = row.title
        return cell
    }
}

