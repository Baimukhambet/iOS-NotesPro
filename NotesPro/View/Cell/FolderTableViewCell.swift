//
//  FolderTableViewCell.swift
//  NotesPro
//
//  Created by Timur Baimukhambet on 13.08.2023.
//

import UIKit

class FolderTableViewCell: UITableViewCell {
    
    lazy var folderNameLabel: UILabel = {
        let label = UILabel()
        label.font = .spaceMono(size: 16)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var folderDescriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .spaceMono(size: 14)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let chevron = UIImageView(image: UIImage(systemName: "chevron.right")?.withTintColor(.white, renderingMode: .alwaysOriginal))
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("FolderTableViewCell error!")
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupCell(name: String, count: Int) {
        contentView.backgroundColor = .darkBackground
        chevron.translatesAutoresizingMaskIntoConstraints = false
        chevron.contentMode = .scaleAspectFit
        
        folderNameLabel.text = name
        folderDescriptionLabel.text = "\(count) notes"
        contentView.addSubview(folderNameLabel)
        contentView.addSubview(folderDescriptionLabel)
        contentView.addSubview(chevron)
        
        NSLayoutConstraint.activate([
            folderNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            folderNameLabel.bottomAnchor.constraint(equalTo: folderDescriptionLabel.topAnchor, constant: -6),
            folderNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            
            folderDescriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            folderDescriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            folderDescriptionLabel.trailingAnchor.constraint(equalTo: chevron.leadingAnchor),
            
            chevron.topAnchor.constraint(equalTo: contentView.topAnchor),
            chevron.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            chevron.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            
//            chevron.widthAnchor.constraint(equalToConstant: 12)
            
        ])
    }


}
