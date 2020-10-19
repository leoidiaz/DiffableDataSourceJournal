//
//  JournalController.swift
//  DiffableDataSourceJournal
//
//  Created by Leonardo Diaz on 10/17/20.
//

import Foundation

class JournalController {
    static let shared = JournalController()
    var journals = [Journal]()
    
    func createJournal(with title: String) {
        let newJournal = Journal(title: title)
        journals.append(newJournal)
    }
}
