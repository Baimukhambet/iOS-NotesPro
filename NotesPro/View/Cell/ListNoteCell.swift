//
//  ListNoteCell.swift
//  NotesPro
//
//  Created by Timur Baimukhambet on 03.08.2023.
//

import UIKit

class ListNoteCell: UITableViewCell {
    
    var title: UILabel?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupCell(text: String) {
        title = UILabel()
        title!.text = text
        title!.font = .spaceMono(size: 16)
        title!.textColor = .white
        title!.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.backgroundColor = .darkBackground
        
        contentView.addSubview(title!)
        NSLayoutConstraint.activate([
            title!.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            title!.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            title!.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            title!.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
        ])
    }

}
