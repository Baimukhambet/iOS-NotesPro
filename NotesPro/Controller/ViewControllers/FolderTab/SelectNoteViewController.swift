//
//  SelectNoteViewController.swift
//  NotesPro
//
//  Created by Timur Baimukhambet on 18.08.2023.
//

import UIKit

class SelectNoteViewController: UIViewController {
    
    let tableView = UITableView()
    var folder: Folder?
    var notes: [Notentity]!

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .darkBackground
        setupTableView()
    }
    
    func setupTableView() {
        tableView.register(ListNoteCell.self, forCellReuseIdentifier: "ListNoteCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .darkBackground
        view.addSubview(tableView)
        
        NSLayoutConstraint.setup(superview: view, subview: tableView)
    }
    
}

extension SelectNoteViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AppModel.shared.notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListNoteCell", for: indexPath) as! ListNoteCell
        cell.setupCell(text: AppModel.shared.notes[indexPath.row].title!)
        
        return cell
    }
}

extension SelectNoteViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        folder!.addToNotes(AppModel.shared.notes[indexPath.row])
        self.navigationController?.popViewController(animated: true)
    }
}
