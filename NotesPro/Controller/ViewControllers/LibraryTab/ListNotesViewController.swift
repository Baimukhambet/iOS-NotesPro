import UIKit
import CoreData

class ListNotesViewController: UIViewController {
    let tableView = UITableView()
    var noteList: [Notentity]!
    var type: NoteType?
    var status: NoteStatus?
    var folder: Folder?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupTableView()
        setTitleView()
        self.noteList = fetchNotes()
    }
    
    func fetchNotes() -> [Notentity] {
        let notes = AppModel.shared.notes
        var fetchedNotes: [Notentity] = []
        guard let folder = folder else {
            if let type = self.type {
                fetchedNotes = notes.filter { $0.type == type.rawValue && $0.status == 1 }
            }
            if let status = self.status {
                if fetchedNotes.isEmpty {
                    fetchedNotes = notes.filter { $0.status == status.rawValue }
                } else {
                    fetchedNotes = fetchedNotes.filter { $0.status == status.rawValue}
                }
            }
            return fetchedNotes
            
        }
        guard let notesArray = folder.notes?.allObjects as? [Notentity] else {
            return []
        }
        let result = notesArray.filter{ $0.status == 1}
        return result
    }
    
    func setupTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .darkBackground
        
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        
        tableView.register(ListNoteCell.self, forCellReuseIdentifier: "ListNoteCell")
    }
    
    func setTitleView() {
        let titleView = UIView()
        let titleLabel: UILabel = {
            let lbl = UILabel()
            lbl.text = "Notes"
            lbl.font = .spaceMono(size: 20)
            lbl.textColor = .white
            lbl.translatesAutoresizingMaskIntoConstraints = false
            return lbl
        }()
        titleView.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: titleView.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: titleView.centerYAnchor)
        ])
        
        navigationItem.titleView = titleView
        
        if folder != nil {
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNoteTapped))
        }
    }
    
    @objc func addNoteTapped() {
        let vc = SelectNoteViewController()
        vc.folder = folder
        vc.notes = noteList
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        noteList = fetchNotes()
        tableView.reloadData()
    }
}

extension ListNotesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return noteList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListNoteCell", for: indexPath) as! ListNoteCell
        if cell.title != nil {
            cell.title!.text = noteList[indexPath.row].title!
        } else {
            cell.setupCell(text: noteList[indexPath.row].title!)
        }
        
        
        return cell
    }
}

extension ListNotesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = NoteViewController()
        vc.note = noteList[indexPath.row]
        
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
//    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
//        return .delete
//    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteSwipeInstance = UIContextualAction(style: .destructive, title: "Delete") { _, _, _ in
            let currentNote = AppModel.shared.notes[indexPath.row]
            AppModel.shared.context.persistentContainer.viewContext.delete(currentNote)
            AppModel.shared.notes.remove(at: indexPath.row)
            self.noteList.remove(at: indexPath.row)
            tableView.reloadData()
            
            AppModel.shared.context.saveContext()
            print(self.noteList.count)
        }
        let actionConfiguration = UISwipeActionsConfiguration(actions: [deleteSwipeInstance])
        
        return actionConfiguration
        
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let currentNote = noteList[indexPath.row]
        
        let completeNoteSwipeAction = UIContextualAction(style: .normal, title: "Done") { _, _, _ in
            currentNote.status = 2
            self.noteList.remove(at: indexPath.row)
            tableView.reloadData()
            AppModel.shared.context.saveContext()
        }
        
        let uncheckNoteSwipeAction = UIContextualAction(style: .normal, title: "Uncheck") { _, _, _ in
                currentNote.status = 1
                self.noteList.remove(at: indexPath.row)
                tableView.reloadData()
                AppModel.shared.context.saveContext()
        }
        
        
        let actionConfiguration: UISwipeActionsConfiguration
        if noteList[indexPath.row].status == 1 {
            actionConfiguration = UISwipeActionsConfiguration(actions: [completeNoteSwipeAction])
        } else {
            actionConfiguration = UISwipeActionsConfiguration(actions: [uncheckNoteSwipeAction])
        }
        
        return actionConfiguration
    }
}
