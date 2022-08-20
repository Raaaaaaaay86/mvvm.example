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
        view.getButton.addTarget(self, action: #selector(getNewRandomPerson(_:)), for: .touchUpInside)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var personTableView: PersonTableView = {
        let tableView = PersonTableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(PersonTableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        return tableView
    }()
    
    // MARK: Property
    private let cellIdentifier: String = "PersonTableViewCell"
    
    private var viewModel: ViewControllerViewModelProtocol = ViewControllerViewModel()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        bindViewModel()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    // MARK: Layout
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
    
    // MARK: Data
    private func bindViewModel() {
        self.viewModel.peopleListOnChange = { _ in
            DispatchQueue.main.async { [weak self] in
                self?.personTableView.reloadData()
            }
        }
        
        self.viewModel.showAlert = { message in
            self.showAlert(message: message)
        }
    }
    
    // MARK: Button Action
    @objc func getNewRandomPerson(_ sender: UIButton) {
        self.viewModel.fetchNewPerson()
    }
    
    // MARK: Methods
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.peopleList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! PersonTableViewCell
        
        guard let person = viewModel.peopleList[indexPath.row] else {
            return cell
        }
        
        cell.updateView(imageURLString: person.picture?.medium, name: person.name?.first)
        
        return cell
    }
}
