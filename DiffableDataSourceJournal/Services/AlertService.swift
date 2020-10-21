//
//  AlertService.swift
//  DiffableDataSourceJournal
//
//  Created by Leonardo Diaz on 10/21/20.
//

import UIKit.UIAlertController


struct AlertService {
    func createJournalAlert(alertTitle: String?,  completion: @escaping (String) -> Void) -> UIAlertController {
        let alertController = UIAlertController(title: alertTitle, message: nil, preferredStyle: .alert)
        alertController.addTextField { (textField) in
            textField.placeholder = "Name of Journal"
        }
        alertController.addAction(UIAlertAction(title: "Add", style: .default, handler: { (_) in
            guard let noteTitle = alertController.textFields?.first?.text, !noteTitle.isEmpty else { return }
            completion(noteTitle)
        }))
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        return alertController
    }
    
    func presentErrorToUser(localizedError: JournalError, title: String?) -> UIAlertController {
        let alertController = UIAlertController(title: title, message: localizedError.errorDescription, preferredStyle: .alert)
        let dismissAction = UIAlertAction(title: "Ok", style: .cancel)
        alertController.addAction(dismissAction)
        return alertController
    }
}
