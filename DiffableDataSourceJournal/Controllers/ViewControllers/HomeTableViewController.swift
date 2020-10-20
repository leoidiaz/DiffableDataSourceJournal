//
//  HomeTableViewController.swift
//  DiffableDataSourceJournal
//
//  Created by Leonardo Diaz on 10/17/20.
//

import UIKit

enum JournalSection {
    case main
}

class HomeTableViewDiffableDataSource: UITableViewDiffableDataSource<JournalSection, Journal>{
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard let journal = self.itemIdentifier(for: indexPath) else { return }
            var snapshot = self.snapshot()
            snapshot.deleteItems([journal])
            JournalController.shared.delete(journal: journal)
            apply(snapshot)
         }
    }
}

class HomeTableViewController: UITableViewController {
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        configureDataSource()
        createSnapshot(animatingDifferences: false)
    }
    //MARK: - Properties
    private var diffableDataSource: HomeTableViewDiffableDataSource!
    //MARK: - Helper Methods
    private func setupView(){
        view.backgroundColor = #colorLiteral(red: 0.2705882353, green: 0.4823529412, blue: 0.6156862745, alpha: 1)
        JournalController.shared.loadFromPersistence()
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Journal"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "journalCell")
        tableView.tableFooterView = UIView()
        navigationItem.leftBarButtonItem = editButtonItem
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(showAlert))
        navigationController?.navigationBar.tintColor = #colorLiteral(red: 0.9450980392, green: 0.9803921569, blue: 0.9333333333, alpha: 1)
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.2705882353, green: 0.4823529412, blue: 0.6156862745, alpha: 1)
    }
    //: TODO CREATE ALERT SERVICE
    @objc private func showAlert(){
        let alertController = UIAlertController(title: "New Journal", message: nil, preferredStyle: .alert)
        alertController.addTextField { (textField) in
            textField.placeholder = "Name of Journal"
        }
        alertController.addAction(UIAlertAction(title: "Add", style: .default, handler: { [weak self] (_) in
            guard let noteTitle = alertController.textFields?.first?.text, !noteTitle.isEmpty else { return }
            JournalController.shared.createJournal(with: noteTitle)
            self?.createSnapshot()
        }))
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(alertController, animated: true)
    }
}
    //MARK: - Table view Diffable data source
extension HomeTableViewController {
    private func configureDataSource() {
        diffableDataSource = HomeTableViewDiffableDataSource(tableView: tableView) { (tableView, indexPath, journal) -> UITableViewCell? in
            let cell = tableView.dequeueReusableCell(withIdentifier: "journalCell", for: indexPath)
            cell.textLabel?.text = journal.title
            cell.accessoryType = .disclosureIndicator
            cell.backgroundColor = #colorLiteral(red: 0.2705882353, green: 0.4823529412, blue: 0.6156862745, alpha: 1)
            cell.textLabel?.textColor = #colorLiteral(red: 0.9450980392, green: 0.9803921569, blue: 0.9333333333, alpha: 1)
            return cell
        }
    }
    
    private func createSnapshot(animatingDifferences: Bool = true){
        var snapShot = NSDiffableDataSourceSnapshot<JournalSection, Journal>()
        snapShot.appendSections([.main])
        snapShot.appendItems(JournalController.shared.journals)
        diffableDataSource.apply(snapShot, animatingDifferences: animatingDifferences)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let journal = diffableDataSource.itemIdentifier(for: indexPath) else { return }
        let destinationVC = EntryTableViewController()
        
        destinationVC.journal = journal
        navigationController?.pushViewController(destinationVC, animated: true)
    }
}
