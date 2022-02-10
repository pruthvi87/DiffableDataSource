//
//  ViewController.swift
//  DiffableDataSource
//
//  Created by ponkar on 7/2/22.
//

import UIKit

class ViewController: UIViewController {

    private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: ItemLayout.makeLayout)

    private typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Item>

    private typealias DataSource = UICollectionViewDiffableDataSource<Section, Item>

    private var snapshot = Snapshot()

    private var dataSource: DataSource?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            view.leadingAnchor.constraint(equalTo: collectionView.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: collectionView.trailingAnchor),
            view.topAnchor.constraint(equalTo: collectionView.topAnchor),
            view.bottomAnchor.constraint(equalTo: collectionView.bottomAnchor)
        ])
        collectionView.register(ItemCell.self, forCellWithReuseIdentifier: "Item")
        setupDataSource()
        addNavigationItem()
        title = "Items"
    }

    private func addNavigationItem() {
        let item = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewItem))

        let clearItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(clearItems))
        navigationItem.rightBarButtonItems = [item, clearItem]
    }

    private func setupDataSource() {
        dataSource = DataSource(collectionView: collectionView) { collectionView, indexPath, model in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Item", for: indexPath) as? ItemCell else { return UICollectionViewCell() }
            cell.label.text = model.title
            return cell
        }
    }

    @objc private func clearItems() {
        snapshot.deleteAllItems()
        dataSource?.apply(snapshot)
    }

    @objc private func addNewItem() {
        if snapshot.numberOfSections == 0 {
        snapshot.appendSections([.main])
        }

        let count = snapshot.numberOfItems

        if count > 5 && snapshot.numberOfSections == 1 {
            snapshot.appendSections([.secondary])
        }

        let item = "Item \(count)"
        if count <= 5 {
            snapshot.appendItems([Item(title: item)], toSection: .main)
        } else {
            snapshot.appendItems([Item(title: item)], toSection: .secondary)
        }
        dataSource?.apply(snapshot)
    }

}

struct ItemLayout {
   static var makeLayout: UICollectionViewLayout {
        let itemLayout = UICollectionViewCompositionalLayout { _, _ in
            let itemsize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(60))
            let item = NSCollectionLayoutItem(layoutSize: itemsize)
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(60))

            let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = .init(top: 20, leading: 0, bottom: 0, trailing: 0)
            return section
        }

        return itemLayout
    }
}

