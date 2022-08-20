//
//  PersonTableViewCell.swift
//  mvvm.example
//
//  Created by 林家富 on 2022/8/20.
//

import UIKit

class PersonTableViewCell: UITableViewCell {
    
    // MARK: Component
    lazy var profileImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = UIColor(red: 0.00, green: 0.00, blue: 0.00, alpha: 0.06)
        imageView.layer.cornerRadius = imageDiameter / 2
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "TEST NAME"
        return label
    }()
    
    // MARK: Property
    private let imageDiameter: CGFloat = 50

    // MARK: Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Setup function
    private func setupLayout() {
        contentView.addSubview(profileImage)
        contentView.addSubview(nameLabel)
        
        NSLayoutConstraint.activate([
            profileImage.widthAnchor.constraint(equalToConstant: imageDiameter),
            profileImage.heightAnchor.constraint(equalToConstant: imageDiameter),
            profileImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            profileImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            profileImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            nameLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: profileImage.trailingAnchor, constant: 16)
        ])
    }
}
