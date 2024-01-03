//
//  BadNoteVC.swift
//  NotesPro
//
//  Created by Timur Baimukhambet on 23.08.2023.
//

import UIKit

class BadNotePopUp: UIViewController {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var message: UILabel!
    var messageText = ""
    
    init() {
        super.init(nibName: "BadNotePopUp", bundle: nil)
        self.modalPresentationStyle = .overFullScreen
    }
    
    required init?(coder: NSCoder) {
        fatalError("BADNOTEvc")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configView()
        self.message.font = .spaceMono(size: 16)
        self.message.text = self.messageText
    }
    
    func configView() {
        self.view.backgroundColor = .clear
        self.backView.backgroundColor = .black.withAlphaComponent(0.6)
        self.backView.alpha = 0
        self.contentView.alpha = 0
        self.contentView.backgroundColor = UIColor.popUpColor.withAlphaComponent(0.9)
        self.contentView.layer.cornerRadius = 12

    }
    
    func appear(sender: UIViewController, message: String) {
        self.messageText = message
        sender.present(self, animated: false) {
            self.show()
        }
    }
    
    private func show() {
        UIView.animate(withDuration: 1.0, delay: 0.1) {
            self.backView.alpha = 1
            self.contentView.alpha = 1
        } completion: { _ in
            self.hide()
        }
        
    }
    
    func hide() {
        UIView.animate(withDuration: 1.0, delay: 0.0, options: .curveEaseOut) {
            self.backView.alpha = 0
            self.contentView.alpha = 0
        } completion: { _ in
            self.dismiss(animated: false)
            self.removeFromParent()
            
        }
    }
    
    

}

extension UIColor {
    static let popUpColor = UIColor(#colorLiteral(red: 1, green: 0, blue: 0, alpha: 1))
}
