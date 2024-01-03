//
//  TopTableViewCell.swift
//  NotesPro
//
//  Created by Timur Baimukhambet on 01.08.2023.
//

import UIKit

class TopTableViewCell: UITableViewCell {
    let txtLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Good morning!"
        lbl.numberOfLines = 2
        lbl.textColor = .black
        lbl.font = .spaceMono(size: 40)
        lbl.translatesAutoresizingMaskIntoConstraints = false

        return lbl
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
        self.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setupCell() {
        contentView.backgroundColor = .black
        let cellView = UIView()
        cellView.translatesAutoresizingMaskIntoConstraints = false
        cellView.backgroundColor = UIColor(red: 155/255, green: 193/255, blue: 207/255, alpha: 1)
        cellView.layer.cornerRadius = 16
        
        
        contentView.addSubview(cellView)
        cellView.addSubview(txtLabel)
        
//        let maskLayer = CAShapeLayer()
//        maskLayer.path = UIBezierPath(roundedRect: cellView.bounds, cornerRadius: 16).cgPath
//        cellView.layer.mask = maskLayer
        
        NSLayoutConstraint.activate([
            cellView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            cellView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            cellView.topAnchor.constraint(equalTo: contentView.topAnchor),
            cellView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            txtLabel.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: 24),
            txtLabel.widthAnchor.constraint(equalToConstant: contentView.frame.size.width / 1.5),
            txtLabel.topAnchor.constraint(equalTo: cellView.topAnchor, constant: 14),
            txtLabel.bottomAnchor.constraint(equalTo: cellView.bottomAnchor, constant: 26)
        ])

        
    }
    

}
