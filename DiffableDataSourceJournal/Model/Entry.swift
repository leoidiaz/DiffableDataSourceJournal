//
//  Entry.swift
//  DiffableDataSourceJournal
//
//  Created by Leonardo Diaz on 10/17/20.
//

import Foundation

struct Entry: Hashable {
    var title: String
    var lastModified: Date
    var note: String
}
