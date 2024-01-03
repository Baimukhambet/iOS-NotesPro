import UIKit

class FoldersViewController: UIViewController {
    
    let appModel = AppModel.shared
    
    lazy var createFolderView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 22/255, green: 22/255, blue: 22/255, alpha: 1.0)

        view.translatesAutoresizingMaskIntoConstraints = false
        
        let shapeLayer = CAShapeLayer()
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: UIApplication.keyWin!.windows.first!.frame.size.width, y: 0))
        path.move(to: CGPoint(x: 0, y: 52))
        path.addLine(to: CGPoint(x: UIApplication.keyWin!.windows.first!.frame.size.width, y: 52))
        
        shapeLayer.path = path.cgPath
        shapeLayer.lineWidth = 2
        shapeLayer.strokeColor = UIColor.black.cgColor
        
        view.layer.addSublayer(shapeLayer)
        
        view.layer.masksToBounds = true
        view.clipsToBounds = true
        
        return view
    }()
    
    lazy var createFolderLabel: UILabel = {
        let label = UILabel()
        label.text = "CREATE NEW FOLDER"
        label.font = .spaceMono(size: 16)
        label.textColor = UIColor(red: 63/255, green: 63/255, blue: 63/255, alpha: 1.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var createFolderButton: UIButton = {
        let btn = UIButton()
//        btn.setTitle("+", for: .normal)
        btn.tintColor = .white
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.cornerRadius = btn.bounds.size.width / 2
        btn.backgroundColor = UIColor(red: 24/255, green: 24/255, blue: 24/255, alpha: 1.0)
        let img = UIImage(systemName: "plus")?.withTintColor(UIColor(red: 152/255, green: 150/255, blue: 150/255, alpha: 1.0), renderingMode: .alwaysOriginal)
        
        btn.setImage(img, for: .normal)
        
        btn.layer.borderWidth = 1
        btn.layer.borderColor = UIColor.black.cgColor
        
        btn.addTarget(self, action: #selector(createFolderTapped), for: .touchUpInside)
        
        return btn
    }()
    
    let tableView = UITableView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.darkBackground
        setupTableView()
        setTitleView()
        navigationController?.navigationBar.tintColor = .white

    }
    
    override func viewDidLayoutSubviews() {
        setupCreateFolderView()
    }
    
    func setupTableView() {
        tableView.register(FolderTableViewCell.self, forCellReuseIdentifier: "FolderCell")
        tableView.backgroundColor = .darkBackground
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        view.addSubview(createFolderView)
    
        
        
        NSLayoutConstraint.activate([
            createFolderView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            createFolderView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            createFolderView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            createFolderView.heightAnchor.constraint(equalToConstant: 52),
            
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: createFolderView.bottomAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

        ])
    }
    

    
    func setupCreateFolderView() {
        createFolderView.addSubview(createFolderButton)
        createFolderView.addSubview(createFolderLabel)
        createFolderButton.layer.cornerRadius = 14
        
        NSLayoutConstraint.activate([
            createFolderButton.centerYAnchor.constraint(equalTo: createFolderView.centerYAnchor),
            createFolderButton.widthAnchor.constraint(equalToConstant: 28),
            createFolderButton.heightAnchor.constraint(equalToConstant: 28),
            createFolderButton.trailingAnchor.constraint(equalTo: createFolderView.trailingAnchor, constant: -24),
            
            createFolderLabel.centerYAnchor.constraint(equalTo: createFolderView.centerYAnchor),
            createFolderLabel.leadingAnchor.constraint(equalTo: createFolderView.leadingAnchor, constant: 24),
            createFolderLabel.trailingAnchor.constraint(equalTo: createFolderButton.leadingAnchor)
        ])
    }
    
    func setTitleView() {
        let titleView = UIView()
        let titleLabel: UILabel = {
            let lbl = UILabel()
            lbl.text = "Folders"
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
    }
    
    @objc func createFolderTapped() {
        let ac = UIAlertController(title: "New Folder", message: nil, preferredStyle: .alert)
        ac.addTextField() { textField in
            textField.placeholder = "Name.."
        }
        ac.view.tintColor = .white
        
        let saveAction = UIAlertAction(title: "Save", style: .default) { action in
            let newFolder = Folder(context: self.appModel.context.persistentContainer.viewContext)
            guard let text = ac.textFields?.first?.text else { return }
            if text.isEmpty {
                return }
            newFolder.name = text
            try! self.appModel.context.persistentContainer.viewContext.save()
            self.appModel.folders.append(newFolder)
            self.tableView.reloadData()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        ac.addAction(saveAction)
        ac.addAction(cancelAction)
        
        present(ac, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

}


extension FoldersViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return appModel.folders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FolderCell") as! FolderTableViewCell
        let folder = appModel.folders[indexPath.row]
        cell.setupCell(name: folder.name ?? "blya:(", count: folder.notes?.count ?? 0)
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = ListNotesViewController()
        vc.folder = appModel.folders[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deletionSwipeAction = UIContextualAction(style: .destructive, title: "Delete") { [unowned self] _, _, _ in
            let folder = appModel.folders[indexPath.row]
            appModel.folders.remove(at: indexPath.row)
            appModel.context.persistentContainer.viewContext.delete(folder)
            tableView.reloadData()
        }
        
        let actionConfiguration = UISwipeActionsConfiguration(actions: [deletionSwipeAction])
        
        return actionConfiguration
    }
    
}
