//
//  TaskCreatedViewController.swift
//  NotesPro
//
//  Created by Timur Baimukhambet on 11.08.2023.
//

import UIKit

class TaskCreatedViewController: UIViewController {

    lazy var taskCreatedLabel: UILabel = {
        let label = UILabel()
        label.text = "Task has been created!"
        label.font = .spaceMono(size: 24)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .black
        
        addLabelView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
            self.dismiss(animated: true)
        }
    }
    
    func addLabelView() {
        view.addSubview(taskCreatedLabel)
        
        NSLayoutConstraint.activate([
            taskCreatedLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            taskCreatedLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
