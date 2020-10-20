//
//  Entry.swift
//  DiffableDataSourceJournal
//
//  Created by Leonardo Diaz on 10/19/20.
//

import Foundation

//struct Entry: Hashable {
//    var id = UUID()
//    var title: String
//    var note: String
//    var journal: Journal
//    var timeModified: Date = Date()
//}

class Entry: Hashable, Codable {
    static func == (lhs: Entry, rhs: Entry) -> Bool {
        return lhs.id == rhs.id
    }
    var id = UUID()
    var title: String
    var note: String
    var lastModified: Date
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    init(title: String, note: String, lastModified: Date = Date()) {
        self.title = title
        self.note = note
        self.lastModified = lastModified
    }
}
