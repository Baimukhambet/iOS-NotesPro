//
//  LibraryTopCell.swift
//  NotesPro
//
//  Created by Timur Baimukhambet on 02.08.2023.
//

import UIKit

class LibraryTopCell: UITableViewCell {
    
    let txtLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Plan for the week"
        lbl.numberOfLines = 0
        lbl.textColor = .black
        lbl.font = .spaceMono(size: 28)
        lbl.translatesAutoresizingMaskIntoConstraints = false

        return lbl
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
        self.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("some error in lib top cell :(")
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setupCell() {
        contentView.backgroundColor = UIColor(red: 22/255, green: 22/255, blue: 22/255, alpha: 1.0)
        let cellView = UIView()
        cellView.translatesAutoresizingMaskIntoConstraints = false
        cellView.backgroundColor = UIColor(red: 253/255, green: 244/255, blue: 165/255, alpha: 1)
        cellView.layer.cornerRadius = 16
        
        
        contentView.addSubview(cellView)
        cellView.addSubview(txtLabel)
        
        
        NSLayoutConstraint.activate([
            cellView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            cellView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            cellView.topAnchor.constraint(equalTo: contentView.topAnchor),
            cellView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            txtLabel.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: 18),
            txtLabel.trailingAnchor.constraint(equalTo: cellView.trailingAnchor, constant: -24),
            txtLabel.bottomAnchor.constraint(equalTo: cellView.bottomAnchor, constant: -24)
        ])

        
    }

}
