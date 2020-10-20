//
//  EntryTableViewController.swift
//  DiffableDataSourceJournal
//
//  Created by Leonardo Diaz on 10/19/20.
//

import UIKit

enum EntrySection {
    case main
}

class EntryTableViewDiffableDataSource: UITableViewDiffableDataSource<EntrySection, Entry>{
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard let entry = self.itemIdentifier(for: indexPath) else { return }
            var snapshot = self.snapshot()
            snapshot.deleteItems([entry])
            JournalController.shared.removeEntry(entry: entry, journal: JournalController.shared.currentJournal!)
            apply(snapshot)
         }
    }
}

class EntryTableViewController: UITableViewController {
    //MARK: - Properties
    private var diffableDataSource: EntryTableViewDiffableDataSource!
    
    var journal: Journal!
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.2705882353, green: 0.4823529412, blue: 0.6156862745, alpha: 1)
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.2705882353, green: 0.4823529412, blue: 0.6156862745, alpha: 1)
        tableView.tableFooterView = UIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupView()
        configureDataSource()
        createSnapshot(animatingDifferences: false)
    }
    
    //MARK: - Methods
    private func setupView(){
        JournalController.shared.currentJournal = journal
        navigationItem.largeTitleDisplayMode = .never
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "entryCell")
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(showDetails))
    }
    
    @objc func showDetails(){
        guard let journal = journal else { return }
        let destinationVC = DetailsViewController()
        destinationVC.journal = journal
        navigationController?.pushViewController(destinationVC, animated: true)
    }
    
    // MARK: - Table view diffable data source
}
extension EntryTableViewController {
    private func configureDataSource(){
        diffableDataSource = EntryTableViewDiffableDataSource(tableView: tableView) { (tableView, indexPath, entry) -> UITableViewCell? in
            let cell = tableView.dequeueReusableCell(withIdentifier: "entryCell", for: indexPath)
            cell.textLabel?.text = entry.title
            cell.accessoryType = .disclosureIndicator
            cell.backgroundColor = #colorLiteral(red: 0.2705882353, green: 0.4823529412, blue: 0.6156862745, alpha: 1)
            cell.textLabel?.textColor = #colorLiteral(red: 0.9450980392, green: 0.9803921569, blue: 0.9333333333, alpha: 1)
            return cell
        }
    }
    
    private func createSnapshot(animatingDifferences: Bool = true){
        var snapShot = NSDiffableDataSourceSnapshot<EntrySection, Entry>()
        snapShot.appendSections([.main])
        snapShot.appendItems(journal!.entries)
        diffableDataSource.apply(snapShot, animatingDifferences: animatingDifferences)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let entry = diffableDataSource.itemIdentifier(for: indexPath) else { return }
        guard let journal = journal else { return }
        let destinationVC = DetailsViewController()
        destinationVC.journal = journal
        destinationVC.entry = entry
        navigationController?.pushViewController(destinationVC, animated: true)
    }
}
