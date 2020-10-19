//
//  HomeTableViewController.swift
//  DiffableDataSourceJournal
//
//  Created by Leonardo Diaz on 10/17/20.
//

import UIKit

fileprivate enum JournalSection {
    case main
}

class HomeTableViewController: UITableViewController {
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        configureDataSource()
    }
    //MARK: - Properties
    private var dataSource: UITableViewDiffableDataSource<JournalSection, Journal>!
    
    //MARK: - Helper Methods
    private func setupView(){
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "journalCell")
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(showAlert))
    }
    
    @objc private func showAlert(){
        let alertController = UIAlertController(title: "New Journal", message: nil, preferredStyle: .alert)
        alertController.addTextField { (textField) in
            textField.placeholder = "Name of Journal"
        }
        alertController.addAction(UIAlertAction(title: "Add", style: .default, handler: { [weak self] (_) in
            guard let text = alertController.textFields?.first?.text, !text.isEmpty else { return }
            JournalController.shared.createJournal(with: text)
            self?.createSnapshot(from: JournalController.shared.journals)
        }))
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(alertController, animated: true)
    }
}
    //MARK: - Table view Diffable data source
extension HomeTableViewController {
    private func configureDataSource(){
        dataSource = UITableViewDiffableDataSource<JournalSection, Journal>(tableView: tableView) { (tableView, indexPath, journal) -> UITableViewCell? in
            let cell = tableView.dequeueReusableCell(withIdentifier: "journalCell", for: indexPath)
            cell.textLabel?.text = journal.title
            cell.accessoryType = .disclosureIndicator
            return cell
        }
    }
    
    private func createSnapshot(from journal: [Journal]){
        var snapShot = NSDiffableDataSourceSnapshot<JournalSection, Journal>()
        snapShot.appendSections([.main])
        snapShot.appendItems(journal)
        dataSource.apply(snapShot, animatingDifferences: true)
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let journal = dataSource.itemIdentifier(for: indexPath) else { return }
        let entryVC = EntryTableViewController()
        entryVC.journal = journal
        navigationController?.pushViewController(entryVC, animated: true)
    }
}
