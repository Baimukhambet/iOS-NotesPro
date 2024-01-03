//
//  FixedViewCell.swift
//  NotesPro
//
//  Created by Timur Baimukhambet on 02.08.2023.
//

import UIKit

class FixedViewCell: UITableViewCell {
    
    lazy var titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .white
        lbl.font = .spaceMono(size: 14)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    lazy var countLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .gray
        lbl.font = .spaceMono(size: 12)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
        
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("FixedViewCell error")
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setupCell(text: String, count: Int?, imageName: String) {
        contentView.backgroundColor = UIColor(red: 19/255, green: 19/255, blue: 19/255, alpha: 1.0)
        titleLabel.text = text
        if let count = count {
            countLabel.text = "\(count)"
        } else {
            countLabel.text = ""
        }
        let iconView = UIImageView()
        iconView.contentMode = .scaleAspectFit
        iconView.image = UIImage(systemName: imageName)
        iconView.translatesAutoresizingMaskIntoConstraints = false
        iconView.tintColor = .white
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(countLabel)
        contentView.addSubview(iconView)
        
        NSLayoutConstraint.activate([
//            contentView.heightAnchor.constraint(equalToConstant: (UIApplication.keyWin!.windows.first!.frame.height * 50) / 813),
//            contentView.widthAnchor.constraint(equalToConstant: UIApplication.keyWin!.windows.first!.frame.width),
            iconView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 14),
            iconView.topAnchor.constraint(equalTo: contentView.topAnchor),
            iconView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            iconView.widthAnchor.constraint(equalToConstant: 16),
//            iconView.heightAnchor.constraint(equalToConstant: 16),
            
            titleLabel.leadingAnchor.constraint(equalTo: iconView.trailingAnchor, constant: 12),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            countLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            countLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            countLabel.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 8),
            countLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12)
        ])
        
    }

}
