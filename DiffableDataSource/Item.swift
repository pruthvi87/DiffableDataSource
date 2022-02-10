//
//  Item.swift
//  DiffableDataSource
//
//  Created by ponkar on 10/2/22.
//

import Foundation

enum Section {
    case main, secondary
}

struct Item: Hashable {
    let title: String
}
