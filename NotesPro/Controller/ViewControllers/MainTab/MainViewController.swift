import UIKit

class MainViewController: UIViewController {
    
    let tableView = UITableView()
    var hasBeenLoaded = false

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setupTableView()
        hasBeenLoaded.toggle()
        
        tableView.dataSource = self
        tableView.delegate = self
        

        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadRows(at: [IndexPath(row: 0, section: 2)], with: .fade)
    }
    
    func setupTableView() {
        tableView.register(TopTableViewCell.self, forCellReuseIdentifier: "TopCell")
        tableView.register(TipsCell.self, forCellReuseIdentifier: "TipsCell")
        tableView.register(BottomTableViewCell.self, forCellReuseIdentifier: "BottomTableViewCell")
        tableView.backgroundColor = .black
        tableView.isScrollEnabled = false
        tableView.separatorStyle = .none
        tableView.separatorColor = .clear
        
        tableView.contentInsetAdjustmentBehavior = .never
        
        self.view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.widthAnchor.constraint(equalToConstant: view.frame.size.width),
            tableView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    override func loadView() {
        super.loadView()
    }

}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "TopCell") as! TopTableViewCell
            cell.setupCell()
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "TipsCell") as! TipsCell
            cell.setupCell()
            cell.clipsToBounds = true
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "BottomTableViewCell") as! BottomTableViewCell
            cell.setupCell()
            
            var firstIndexOfCurrentMonth = 0
            AppModel.shared.notes.forEach { note in
                if AppModel.shared.currentMonth.month == Calendar.current.dateComponents([.month], from: note.date!).month {
                    return
                }
                firstIndexOfCurrentMonth += 1
            }
            
            var notesDone = 0
            AppModel.shared.notes.forEach { note in
                if note.status == 2 {
                    notesDone += 1
                }
            }
            
            cell.counterLabel.text = "\(notesDone)/\(AppModel.shared.notes.count - firstIndexOfCurrentMonth)"
            
            
            return cell
        default:
            return UITableViewCell()
        }
    }
}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return view.frame.size.height / 3
        } else if indexPath.section == 1 {
            return view.frame.size.height / 3.8
        }
        return view.frame.size.height - (view.frame.size.height / 3) - (view.frame.size.height / 3.8)
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
}
