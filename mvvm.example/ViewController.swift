//
//  ViewController.swift
//  mvvm.example
//
//  Created by 林家富 on 2022/8/20.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: Component
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "MVVM Example"
        label.font = UIFont.boldSystemFont(ofSize: 24)
        return label
    }()
    
    private lazy var dashboardView: UIView = {
        let view = DashboardView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var personTableView: PersonTableView = {
        let tableView = PersonTableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(PersonTableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        return tableView
    }()
    
    // MARK: Property
    private let cellIdentifier: String = "PersonTableViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        
        view.addSubview(titleLabel)
        view.addSubview(dashboardView)
        view.addSubview(personTableView)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            titleLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            dashboardView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            dashboardView.centerXAnchor.constraint(equalTo: titleLabel.centerXAnchor),
            dashboardView.heightAnchor.constraint(greaterThanOrEqualToConstant: 50),
            personTableView.topAnchor.constraint(equalTo: dashboardView.bottomAnchor, constant: 8),
            personTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            personTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            personTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

