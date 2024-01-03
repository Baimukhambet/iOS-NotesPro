//
//  BottomTableViewCell.swift
//  NotesPro
//
//  Created by Timur Baimukhambet on 02.08.2023.
//

import UIKit

class BottomTableViewCell: UITableViewCell {
    
    lazy var counterLabel = getInfoLabel()
//    lazy var
    let tasksDoneLabel: UILabel = {
        let label = UILabel()
        label.text = "Tasks done"
        label.textColor = .white
        label.font = .spaceMono(size: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let title: UILabel = {
        let label = UILabel()
        label.text = "Your monthly report"
        label.textColor = .white
        label.font = .spaceMono(size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("some fatal error :D")
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func getInfoLabel() -> UILabel {
        let label = UILabel()
        label.textColor = .white
        label.font = .spaceMono(size: 30)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "10/44"
        return label
    }
    
    func setupCell() {
        contentView.backgroundColor = .black
        getReportView()


    }
    
    func getReportView(){
        let view = UIView()
        view.backgroundColor = UIColor(red: 35/255, green: 35/255, blue: 35/255, alpha: 1.0)
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        
        let stack = UIStackView(arrangedSubviews: [counterLabel, tasksDoneLabel])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        
        stack.alignment = .center
        
        view.addSubview(stack)
        contentView.addSubview(title)
        contentView.addSubview(view)
        
        let layer = getBarView(superview: view, ratio: 1, count: 1)
        view.layer.addSublayer(layer)
        
        let layer2 = getBarView(superview: view, ratio: 1, count: 2)
        view.layer.addSublayer(layer)
        
        
        NSLayoutConstraint.activate([
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stack.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            stack.widthAnchor.constraint(equalToConstant: 140),
            stack.heightAnchor.constraint(equalToConstant: 120),
            title.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            title.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            title.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            
            view.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            view.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 12),
//            view.widthAnchor.constraint(equalToConstant: (UIApplication.size?.windows.first?.frame.width ?? 30) - 24),
            view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            view.heightAnchor.constraint(equalToConstant: UIApplication.keyWin!.windows.first!.frame.height / 4.6)
        ])
        
    }
    
    func getBarView(superview: UIView, ratio: Int, count: Int) -> CAShapeLayer {
        let layer = CAShapeLayer()
        let path = UIBezierPath()
        path.move(to: CGPoint(x: UIApplication.keyWin!.windows.first!.frame.width / 2.4 * CGFloat(count), y: 30))
        path.addLine(to: CGPoint(x: UIApplication.keyWin!.windows.first!.frame.width / 2.4 * CGFloat(count), y: 150 ))
        
        layer.path = path.cgPath
        
        layer.lineWidth = 2
        layer.strokeColor = UIColor.red.cgColor
        
        return layer
    }

}

