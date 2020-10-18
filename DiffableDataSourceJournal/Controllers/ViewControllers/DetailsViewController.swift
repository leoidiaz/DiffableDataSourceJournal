//
//  DetailsViewController.swift
//  DiffableDataSourceJournal
//
//  Created by Leonardo Diaz on 10/17/20.
//

import UIKit

class DetailsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
     
    var journal: Journal?
    var entry: Entry?
    
    func setupView(){
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveNote))
    }
    
    @objc func saveNote(){
        createNewEntry(journal: journal, note: "This is a test", title: "TESTING")
        navigationController?.popViewController(animated: true)
    }
    
}

extension DetailsViewController {
    func createNewEntry(journal: Journal?, note: String, title: String) {
        guard var journal = journal else { return }
        let newEntry = Entry(title: title, lastModified:Date(), note: note)
        journal.entries.append(newEntry)
    }
}
