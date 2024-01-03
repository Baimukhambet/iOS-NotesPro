import UIKit
import CoreData

class NoteViewController: UIViewController, UITextViewDelegate {
    
    var note: NSManagedObject!
    lazy var contentTextView: UITextView = {
        let textView = UITextView()
        textView.font = .spaceMono(size: 16)
        textView.text = note.value(forKeyPath: "content") as? String
        textView.textColor = .white
        textView.backgroundColor = .lightBackground
        
        return textView
    }()
    
    lazy var titleView = setupTitleView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .darkBackground
        setupView()
        self.navigationItem.titleView = titleView
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(titleTapped))
        self.navigationController?.navigationBar.topItem?.titleView?.addGestureRecognizer(tapGesture)
    }

    
    func setupView() {
        contentTextView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(contentTextView)
        NSLayoutConstraint.setup(superview: view, subview: contentTextView, top: 8)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        note.setValue(contentTextView.text, forKey: "content")
    }
    
    func setupTitleView() -> UIView {
        let view = UIView()
        let label: UILabel = {
            let lbl = UILabel()
            lbl.text = note.value(forKeyPath: "title") as? String
            lbl.font = .spaceMono(size: 16)
            lbl.textColor = .white
            lbl.numberOfLines = 0
            lbl.translatesAutoresizingMaskIntoConstraints = false
            return lbl
        }()
        view.addSubview(label)
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10)

        ])

        return view
    }
    
    @objc func titleTapped() {
        print("Tapped")
        let ac = UIAlertController(title: "New title", message: nil, preferredStyle: .actionSheet)
        let saveAction = UIAlertAction(title: "Save", style: .default) { action in
            guard let newTitle = ac.textFields?.first?.text else { return }
            let label = self.titleView.subviews.first as! UILabel
            label.text = newTitle
            self.note.setValue(newTitle, forKeyPath: "title")
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        ac.addAction(saveAction)
        ac.addAction(cancelAction)
        ac.addTextField()
        
        present(ac, animated: true)
    }

}


extension NSLayoutConstraint {
    static func setup(superview: UIView, subview: UIView, top: CGFloat = 0, bottom: CGFloat = 0, left: CGFloat = 0, right: CGFloat = 0) {
        NSLayoutConstraint.activate([
            subview.topAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.topAnchor, constant: top),
            subview.bottomAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.bottomAnchor, constant: bottom),
            subview.leadingAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.leadingAnchor, constant: left),
            subview.trailingAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.trailingAnchor, constant: right),
        ])
    }
}
