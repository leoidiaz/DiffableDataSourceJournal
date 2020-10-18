//
//  Journal.swift
//  DiffableDataSourceJournal
//
//  Created by Leonardo Diaz on 10/17/20.
//

import Foundation

struct Journal: Hashable {
    var title: String
    var entries: [Entry] = []
    var lastModified: Date = Date()
}
