//
//  ItemCell.swift
//  DiffableDataSource
//
//  Created by ponkar on 10/2/22.
//

import UIKit

class ItemCell: UICollectionViewCell {

    let label = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUp()
    }

    func setUp() {

        label.translatesAutoresizingMaskIntoConstraints = false
        addSubview(label)
        NSLayoutConstraint.activate([
            leadingAnchor.constraint(equalTo: label.leadingAnchor, constant: -8),
            trailingAnchor.constraint(equalTo: label.trailingAnchor, constant: 16),
            topAnchor.constraint(equalTo: label.topAnchor, constant: 8),
            bottomAnchor.constraint(equalTo: label.bottomAnchor, constant: 8)
        ])
        label.textColor = .darkGray
    }
    
}
