//
//  Journal.swift
//  DiffableDataSourceJournal
//
//  Created by Leonardo Diaz on 10/17/20.
//

import Foundation

struct Journal: Hashable {
    let title: String
    let entries: [Entry]
    let lastModified: Date
}
