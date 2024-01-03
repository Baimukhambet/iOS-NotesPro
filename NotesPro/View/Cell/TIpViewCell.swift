//
//  TIpViewCell.swift
//  NotesPro
//
//  Created by Timur Baimukhambet on 02.08.2023.
//

import UIKit

class TipViewCell: UICollectionViewCell {
    let textLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .spaceMono(size: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCell(title: String) {
        contentView.backgroundColor = UIColor(red: 35/255, green: 35/255, blue: 35/255, alpha: 1.0)
        self.layer.cornerRadius = 8
        self.clipsToBounds = true
        textLabel.text = title
        contentView.addSubview(textLabel)
        NSLayoutConstraint.activate([
            textLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            textLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            textLabel.widthAnchor.constraint(equalToConstant: contentView.frame.size.width)
        ])
    }
}
