//
//  Entry.swift
//  DiffableDataSourceJournal
//
//  Created by Leonardo Diaz on 10/17/20.
//

import Foundation

struct Entry: Hashable {
    let title: String
    let lastModified: Date
    let note: String
}
