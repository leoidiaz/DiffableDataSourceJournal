//
//  EntryTableViewController.swift
//  DiffableDataSourceJournal
//
//  Created by Leonardo Diaz on 10/17/20.
//

import UIKit

fileprivate enum EntrySection {
    case main
}

class EntryTableViewController: UITableViewController {
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        configureDataSource()
    }
    var entries = [Entry]()
    //MARK: - Properties
    var journal: Journal? {
        didSet{
            guard let journal = journal else { return }
            entries = journal.entries
        }
    }
    
    private var dataSource: UITableViewDiffableDataSource<EntrySection, Entry>!
    
    private func setupView(){
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "entryCell")
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(createEntry))
    }
    
    @objc func createEntry(){
        guard let journal = journal else { return }
        let detailsVC = DetailsViewController()
        detailsVC.journal = journal
        navigationController?.pushViewController(detailsVC, animated: true)
    }
}

    // MARK: - Table view diffable data source
extension EntryTableViewController {
    private func configureDataSource(){
        dataSource = UITableViewDiffableDataSource<EntrySection, Entry>(tableView: tableView) { (tableView, indexPath, entry) -> UITableViewCell? in
            let cell = tableView.dequeueReusableCell(withIdentifier: "entryCell", for: indexPath)
            cell.textLabel?.text = entry.title
            cell.accessoryType = .disclosureIndicator
            return cell
        }
    }
    
    private func createSnapshot(from entry: [Entry]){
        var snapShot = NSDiffableDataSourceSnapshot<EntrySection, Entry>()
        snapShot.appendSections([.main])
        snapShot.appendItems(entry)
        dataSource.apply(snapShot, animatingDifferences: true)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let entry = dataSource.itemIdentifier(for: indexPath) else { return }
        let detailsVC = DetailsViewController()
        detailsVC.entry = entry
        navigationController?.pushViewController(detailsVC, animated: true)
    }
}
