//
//  DashboardView.swift
//  mvvm.example
//
//  Created by 林家富 on 2022/8/20.
//

import UIKit

class DashboardView: UIStackView {

    // MARK: Component
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Countdown (sec)"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textAlignment = .center
        return label
    }()
    
    lazy var decrementButton: UIButton = {
        let button = UIButton(type: .system)
        button.configuration = UIButton.Configuration.filled()
        button.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        button.setImage(UIImage(systemName: "minus"), for: .normal)
        return button
    }()
    
    lazy var countDownLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.textAlignment = .center
        return label
    }()
    
    lazy var incrementButton: UIButton = {
        let button = UIButton(type: .system)
        button.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        button.configuration = UIButton.Configuration.filled()
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        return button
    }()
    
    private lazy var buttonControlView: UIStackView = {
        let containerVStack = UIStackView()
        containerVStack.translatesAutoresizingMaskIntoConstraints = false
        containerVStack.axis = .vertical
        containerVStack.spacing = 8
        
        let buttonHStack = UIStackView()
        buttonHStack.axis = .horizontal
        buttonHStack.spacing = 8
        
        containerVStack.addArrangedSubview(titleLabel)
        containerVStack.addArrangedSubview(buttonHStack)
        
        buttonHStack.addArrangedSubview(decrementButton)
        buttonHStack.addArrangedSubview(countDownLabel)
        buttonHStack.addArrangedSubview(incrementButton)
        
        decrementButton.translatesAutoresizingMaskIntoConstraints = false
        incrementButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            decrementButton.widthAnchor.constraint(equalToConstant: 35),
            decrementButton.heightAnchor.constraint(equalToConstant: 35),
            incrementButton.widthAnchor.constraint(equalToConstant: 35),
            incrementButton.heightAnchor.constraint(equalToConstant: 35)
        ])
        
        return containerVStack
    }()
    
    private lazy var getButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.configuration = UIButton.Configuration.filled()
        button.tintColor = .systemGreen
        button.setTitle("GET", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        axis = .horizontal
        alignment = .bottom
        distribution = .fill
        spacing = 16
        
        addArrangedSubview(buttonControlView)
        addArrangedSubview(getButton)
        
        NSLayoutConstraint.activate([
            getButton.heightAnchor.constraint(equalToConstant: 35),
            getButton.widthAnchor.constraint(equalToConstant: 75),
            buttonControlView.widthAnchor.constraint(equalToConstant: 150)
        ])
    }
}
