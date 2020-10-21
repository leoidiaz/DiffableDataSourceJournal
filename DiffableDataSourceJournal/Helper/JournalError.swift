//
//  JournalError.swift
//  DiffableDataSourceJournal
//
//  Created by Leonardo Diaz on 10/21/20.
//

import Foundation

enum JournalError: LocalizedError {
    case thrownError(Error)
    case emptyTextField
    
    var errorDescription: String? {
        switch self {
        case .thrownError(let error):
            return error.localizedDescription
        case .emptyTextField:
            return "Textfield can not be left empty!"
        }
    }
}
