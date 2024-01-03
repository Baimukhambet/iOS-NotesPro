//
//  LibraryViewController.swift
//  NotesPro
//
//  Created by Timur Baimukhambet on 02.08.2023.
//

import UIKit

class LibraryViewController: UIViewController {
    
    let tableView = UITableView()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setupTableView()
        setTitleView()

        tableView.dataSource = self
        tableView.delegate = self
        
        navigationController?.navigationBar.tintColor = UIColor.white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }
    
    func setupTableView() {
        tableView.register(LibraryTopCell.self, forCellReuseIdentifier: "LibTopCell")
        tableView.register(FixedViewCell.self, forCellReuseIdentifier: "FixedCell")
        tableView.allowsSelection = true
        tableView.sectionHeaderTopPadding = 0
        tableView.tableFooterView = UIView()
        
        tableView.backgroundColor = UIColor(red: 19/255, green: 19/255, blue: 19/255, alpha: 1.0)
        tableView.isScrollEnabled = false
        tableView.separatorStyle = .none
        tableView.separatorColor = .clear

        self.view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    func setTitleView() {
        let titleView = UIView()
        let titleLabel: UILabel = {
            let lbl = UILabel()
            lbl.text = "Library"
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

}

extension LibraryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 1 || section == 2{
            return 3
        }
        return 1
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "LibTopCell") as! LibraryTopCell
            cell.setupCell()
            return cell
        case 1:
            let cell = FixedViewCell()
            let title: String
            let imageName: String
            let count: Int
            switch indexPath.row {
            case 0:
                title = "All files"
                imageName = "list.clipboard"
                count = AppModel.shared.notes.filter { $0.status == 1}.count
            case 1:
                title = "Archive"
                imageName = "archivebox"
                count = AppModel.shared.notes.filter { $0.status == 2}.count
            case 2:
                title = "Deleted"
                imageName = "trash"
                count = AppModel.shared.notes.filter { $0.status == 3}.count
            default:
                title = "Deleted"
                imageName = "trash"
                count = 0
            }

            cell.setupCell(text: title, count: count, imageName: imageName)
            cell.selectionStyle = .none
            cell.clipsToBounds = true
            return cell
        case 2:
            let cell = FixedViewCell()
            let title: String
            let imageName: String
            let count: Int?
            switch indexPath.row {
            case 0:
                title = "Important"
                imageName = "star.circle"
                count = AppModel.shared.notes.filter { $0.type == 1 && $0.status == 1}.count
            case 1:
                title = "To-do"
                imageName = "flame"
                count = AppModel.shared.notes.filter { $0.type == 2 && $0.status == 1}.count
            case 2:
                title = "Regular"
                imageName = "sparkles"
                count = AppModel.shared.notes.filter { $0.type == 3 && $0.status == 1}.count
            default:
                title = "Deleted"
                imageName = "trash"
                count = 0
            }
            
            cell.setupCell(text: title, count: count, imageName: imageName)
            
            cell.selectionStyle = .none
            cell.clipsToBounds = true
            return cell
            
        default:
            let cell = UITableViewCell()
            
            return cell
        }
    }
}

extension LibraryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return view.frame.size.height / 5
        default:
            return (58 * view.frame.size.height) / 813
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1{
            let listNotesVC = ListNotesViewController()
            switch indexPath.row {
            case 0:
                listNotesVC.status = .current
            case 1:
                listNotesVC.status = .archived
            case 2:
                listNotesVC.status = .deleted
            default:
                break
            }
            
            navigationController?.pushViewController(listNotesVC, animated: true)
        } else if indexPath.section == 2{
            let listNotesVC = ListNotesViewController()
            switch indexPath.row {
            case 0:
                listNotesVC.type = .important
            case 1:
                listNotesVC.type = .todo
            case 2:
                listNotesVC.type = .simple
            default:
                break
            }
            
            navigationController?.pushViewController(listNotesVC, animated: true)
        } else {
            tableView.deselectRow(at: indexPath, animated: true)
        }
        
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            return 50
        case 1:
            return 20
        default:
            return 0
        }
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 1, 2:
            return 40
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView()
        view.frame.size.width = tableView.frame.size.width
        if section == 0{
            view.backgroundColor = UIColor(red: 22/255, green: 22/255, blue: 22/255, alpha: 1.0)
            
            
        } else {
            view.backgroundColor = UIColor(red: 19/255, green: 19/255, blue: 19/255, alpha: 1.0)
            
        }
        
        //LINE
        let lineLayer = CAShapeLayer()
        let path = UIBezierPath()
        if section != 1{
            path.move(to: CGPoint(x: 0, y: 50))
            path.addLine(to: CGPoint(x: view.frame.maxX, y: 50))
        } else {
            path.move(to: CGPoint(x: 0, y: 20))
            path.addLine(to: CGPoint(x: view.frame.maxX, y: 20))
        }
        lineLayer.path = path.cgPath
        lineLayer.strokeColor = UIColor.black.cgColor
        lineLayer.lineWidth = 4
        view.layer.addSublayer(lineLayer)
        
        return view
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.frame.size.width = tableView.frame.size.width
        view.backgroundColor = UIColor(red: 22/255, green: 22/255, blue: 22/255, alpha: 1.0)
        if section == 0 {
            view.backgroundColor = .white
        }
        
        //LINE
        let lineLayer = CAShapeLayer()
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: 40))
        path.addLine(to: CGPoint(x: view.frame.maxX, y: 40))
        lineLayer.path = path.cgPath
        lineLayer.strokeColor = UIColor.black.cgColor
        lineLayer.lineWidth = 4
        view.layer.addSublayer(lineLayer)
        
        let sectionTitle: UILabel = {
            let label = UILabel()
            label.textColor = .gray
            label.font = .spaceMono(size: 16)
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        
        view.addSubview(sectionTitle)
        NSLayoutConstraint.activate([
            sectionTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            sectionTitle.topAnchor.constraint(equalTo: view.topAnchor),
            sectionTitle.bottomAnchor.constraint(equalTo: view.bottomAnchor),
//            sectionTitle.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -12),
            sectionTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        if section == 1 {
            sectionTitle.text = "FIXED"
        } else {
            sectionTitle.text = "LABELS"
        }
        
        return view
    }

}


import SwiftUI

struct ViewControllerRepresentable: UIViewControllerRepresentable {
    
    func makeUIViewController(context: Context) -> some UIViewController {
        return LibraryViewController()
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
}

struct ViewController_Preview: PreviewProvider {
    static var previews: some View {
        ViewControllerRepresentable()
    }
}
