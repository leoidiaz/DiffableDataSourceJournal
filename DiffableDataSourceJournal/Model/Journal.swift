//
//  Journal.swift
//  DiffableDataSourceJournal
//
//  Created by Leonardo Diaz on 10/17/20.
//

import Foundation

class Journal: Hashable, Codable {
    static func == (lhs: Journal, rhs: Journal) -> Bool {
        return lhs.id == rhs.id
    }
    
    var id = UUID()
    var title: String
    var lastModified: Date
    var entries: [Entry]
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    init(title: String, lastModified: Date = Date(), entries: [Entry] = []) {
        self.title = title
        self.lastModified = lastModified
        self.entries = entries
    }
}
//
//struct Journal: Hashable {
//    var title: String
//    var note: String
//    var lastModified: Date
//    var entries: [Entry] = []
//}
