//
//  DetailsViewController.swift
//  DiffableDataSourceJournal
//
//  Created by Leonardo Diaz on 10/19/20.
//

import UIKit

class DetailsViewController: UIViewController {
    //MARK: - Properties
    var journal: Journal?
    var entry: Entry?
    
    var textField = UITextField()
    var textView = UITextView()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func loadView() {
        super.loadView()
        addLayout()
    }
    
    //MARK: - Methods
    private func setupView(){
        textField.delegate = self
        textField.textAlignment = .center
        view.backgroundColor = #colorLiteral(red: 0.2705882353, green: 0.4823529412, blue: 0.6156862745, alpha: 1)
        textField.backgroundColor = .systemBackground
        navigationItem.rightBarButtonItem  = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(addEntry))
        if let entry = entry {
            textField.text = entry.title
            textView.text = entry.note
        } else {
            textField.becomeFirstResponder()
        }
    }
    
    private func addLayout(){
        view.addSubview(textField)
        view.addSubview(textView)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 26.0),
            textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16.0),
            textField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16.0),
            textField.heightAnchor.constraint(equalToConstant: 30),
            textView.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 20),
            textView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16.0),
            textView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16.0),
            textView.heightAnchor.constraint(equalToConstant: 150)
        ])
    }
    
    @objc func addEntry(){
        guard let journal = journal else { return }
        guard let textTitle = textField.text, !textTitle.isEmpty else { return }
        guard let note = textView.text, !note.isEmpty else { return }
        
        if let entry = entry {
            JournalController.shared.updateEntry(entry: entry, title: textTitle, note: note)
        } else {
            JournalController.shared.updateJournal(journal: journal, title: textTitle, note: note)
        }
        
        navigationController?.popViewController(animated: true)
    }
}

extension DetailsViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        textView.becomeFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}
