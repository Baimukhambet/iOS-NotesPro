import UIKit
import SwiftUI

class AddTaskViewController: UIViewController, UITextFieldDelegate {
    
    let tableView = UITableView()
    var selectedType: String?
    var selectedTitle: String?
    var noteText: String?
    var errorToggle = false {
        didSet {
            self.view.setNeedsDisplay()
        }
    }
    
    let appModel = AppModel.shared
    
    lazy var incompletedNote: UILabel = {
        let lbl = UILabel()
        lbl.font = .spaceMono(size: 16)
        lbl.textColor = .black
        lbl.backgroundColor = .red.withAlphaComponent(0.8)
        lbl.layer.cornerRadius = 10
        lbl.translatesAutoresizingMaskIntoConstraints = false
        
        return lbl
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightBackground
        
        let addButton = UIBarButtonItem(title: "Create", style: .done, target: self, action: #selector(createTaskTapped))
        addButton.setTitleTextAttributes([NSAttributedString.Key.font : UIFont.spaceMono(size: 18), NSAttributedString.Key.foregroundColor : UIColor.white], for: .normal)
        addButton.setTitleTextAttributes([NSAttributedString.Key.font : UIFont.spaceMono(size: 18), NSAttributedString.Key.foregroundColor : UIColor.white], for: .highlighted)
        navigationItem.rightBarButtonItem = addButton

        setupTableView()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        navigationController?.navigationBar.tintColor = .white
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
//        tableView.isScrollEnabled = false
        tableView.separatorStyle = .none
        tableView.register(TaskSettingCell.self, forCellReuseIdentifier: "TaskSettingCell")
        tableView.backgroundColor = UIColor(red: 19/255, green: 19/255, blue: 19/255, alpha: 1.0)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    @objc func createTaskTapped() {
        let overlayVC = BadNotePopUp()
        
        guard let type = self.selectedType else {
            overlayVC.appear(sender: self, message: "Type is not chosen!")
            DispatchQueue.main.async {
                UIView.animate(withDuration: 1.0) {
                    self.incompletedNote.layer.opacity = 0.0
                }
                self.incompletedNote.removeFromSuperview()
            }
            return
        }
        guard let title = self.selectedTitle else {
            overlayVC.appear(sender: self, message: "Title is not chosen!")
            DispatchQueue.main.async {
                UIView.animate(withDuration: 1.0) {
                    self.incompletedNote.layer.opacity = 0.0
                }
                self.incompletedNote.removeFromSuperview()
            }
            return
        }
        guard let text = self.noteText else {
            overlayVC.appear(sender: self, message: "Note is empty!")
            DispatchQueue.main.async {
                UIView.animate(withDuration: 1.0) {
                    self.incompletedNote.layer.opacity = 0.0
                }
                self.incompletedNote.removeFromSuperview()
            }
            return
        }
        createNote(type: type, title: title, content: text)
    }
    
//    func showIncompletedNoteView(_ error: String) {
//        print(error)
//        incompletedNote.text = error
//        view.addSubview(incompletedNote)
//        NSLayoutConstraint.activate([
//            incompletedNote.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            incompletedNote.centerYAnchor.constraint(equalTo: view.centerYAnchor),
//        ])
//        errorToggle.toggle()
//    }
    
    func createNote(type: String, title: String, content: String) {
        let noteType: NoteType
        if type == "Important" {
            noteType = .important
        } else if type == "To-Do" {
            noteType = .todo
        } else {
            noteType = .simple
        }
        let newNote = Note(title: title, content: content, typeValue: noteType.rawValue, statusValue: Int32(1), date: Date.now.format())
        appModel.addTask(newNote)
        
        let vc = TaskCreatedViewController()
        tableView.reloadData()
        
        selectedType = nil
        selectedTitle = nil
        noteText = nil
        
        self.present(vc, animated: true)
        return
    }
}

extension AddTaskViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = TaskSettingCell(style: .default, reuseIdentifier: "TaskSettingCell")
        cell.setupCell(row: indexPath.row)
        switch indexPath.row {
        case 0:
            cell.typeSelectedCompletion = { type in
                self.selectedType = type
            }
        case 1:
            cell.titleSelectedCompletion = { title in
                self.selectedTitle = title
            }
        default:
            cell.noteTextEditingChangedCompletion = { text in
                self.noteText = text
            }
        }
        return cell
        
        
    }
    
}

extension AddTaskViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 2:
            return UIApplication.keyWin!.windows.first!.frame.size.height - 108 - 44
//            return self.tableView.bounds.size.height - 108 - 44
//            return 200
        default:
            return 54
        }
    }
}


struct PreviewController: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> AddTaskViewController {
        return AddTaskViewController()
    }
    
    func updateUIViewController(_ uiViewController: AddTaskViewController, context: Context) {
        
    }
    
    
    
}

struct Preview: PreviewProvider {
    static var previews: some View {
        PreviewController()
    }
    
}


