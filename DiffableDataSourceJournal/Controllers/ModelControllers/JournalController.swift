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
    var currentJournal: Journal?
    
    func createJournal(with title: String) {
        let newJournal = Journal(title: title)
        journals.append(newJournal)
        journals.sort(by: {$0.lastModified > $1.lastModified})
        saveToPersistence()
    }
    
    func updateJournal(journal: Journal, title: String, note: String) {
        let newEntry = Entry(title: title, note: note)
        journal.entries.append(newEntry)
        saveToPersistence()
    }
    
    func updateEntry(entry: Entry, title: String, note: String) {
        entry.title = title
        entry.note = note
        entry.lastModified = Date()
        saveToPersistence()
    }
    
    func delete(journal: Journal) {
        guard let journalIndex = journals.firstIndex(of: journal) else { return }
        journals.remove(at: journalIndex)
        saveToPersistence()
    }
    
    func removeEntry(entry: Entry, journal: Journal) {
        guard let entryIndex = journal.entries.firstIndex(of: entry) else { return }
        journal.entries.remove(at: entryIndex)
        saveToPersistence()
    }
    
    //MARK: - JSON Encoding / Decoding
    
    func fileURL() -> URL {
        let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let fileURL = url[0].appendingPathComponent("Journal.json")
        return fileURL
    }
    
    func loadFromPersistence() {
        let decoder = JSONDecoder()
        do {
            let data = try Data(contentsOf: fileURL())
            let decodedData = try decoder.decode([Journal].self, from: data)
            journals = decodedData
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func saveToPersistence(){
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(journals)
            try data.write(to: fileURL())
        } catch {
            print(error.localizedDescription)
        }
    }
}
