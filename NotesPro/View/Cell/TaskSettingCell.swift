//
//  TaskSettingCell.swift
//  NotesPro
//
//  Created by Timur Baimukhambet on 05.08.2023.
//

import UIKit

class TaskSettingCell: UITableViewCell, UITextViewDelegate, UITextFieldDelegate {
    
    var typeSelectedCompletion: ((String) -> ())?
    var titleSelectedCompletion: ((String) -> ())?
    var noteTextEditingChangedCompletion: ((String) -> ())?
    
    
    lazy var taskTypeLabel: UILabel = {
        let label = UILabel()
        label.font = .spaceMono(size: 18)
        label.text = "Type"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        return label
    }()
    
    lazy var taskTypePicker: UISegmentedControl = {
        let picker = UISegmentedControl()
        
        picker.insertSegment(withTitle: "Important", at: 0, animated: true)
        picker.insertSegment(withTitle: "To-Do", at: 1, animated: true)
        picker.insertSegment(withTitle: "Regular", at: 2, animated: true)
        picker.translatesAutoresizingMaskIntoConstraints = false
        picker.tintColor = .white
        picker.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .normal)
        picker.selectedSegmentTintColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
        
        return picker
    }()
    
    lazy var taskTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .spaceMono(size: 18)
        label.text = "Title"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        return label
    }()
    
    lazy var taskTitleTextField: UITextField = {
        let txtField = UITextField()
        txtField.font = .spaceMono(size: 14)
        txtField.textColor = .white
        txtField.backgroundColor = .darkBackground
        txtField.layer.cornerRadius = 8
        txtField.translatesAutoresizingMaskIntoConstraints = false
        txtField.delegate = self
        txtField.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        return txtField
    }()
    
    lazy var textView: UITextView = {
        let txtView = UITextView()
        txtView.font = .spaceMono(size: 16)
        txtView.backgroundColor = .darkBackground
        txtView.textColor = .white
        txtView.translatesAutoresizingMaskIntoConstraints = false
        txtView.layer.cornerRadius = 6
        txtView.isScrollEnabled = true
        txtView.tintColor = .white
        return txtView
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("TaskSettingCell error :(")
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setupCell(row: Int) {
        contentView.backgroundColor = UIColor(red: 22/255, green: 22/255, blue: 22/255, alpha: 1.0)
        switch row {
        case 0:
            contentView.addSubview(taskTypeLabel)
            contentView.addSubview(taskTypePicker)
            taskTypePicker.addTarget(self, action: #selector(taskTypeSelected(_:)), for: .valueChanged)
            
            NSLayoutConstraint.activate([
                taskTypeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
                taskTypeLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
                taskTypeLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
                
                taskTypePicker.leadingAnchor.constraint(equalTo: taskTypeLabel.trailingAnchor),
                taskTypePicker.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 6),
                taskTypePicker.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -6),
                taskTypePicker.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -4),
                
            ])
        case 1:
            contentView.addSubview(taskTitleLabel)
            contentView.addSubview(taskTitleTextField)

            NSLayoutConstraint.activate([
                taskTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
                taskTitleLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
                taskTitleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
                taskTitleTextField.widthAnchor.constraint(equalToConstant: UIApplication.keyWin!.windows.first!.frame.size.width / 2),
                
                taskTitleTextField.leadingAnchor.constraint(equalTo: taskTitleLabel.trailingAnchor),
                taskTitleTextField.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
                taskTitleTextField.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
                taskTitleTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -4),
                
            ])
        default:
            contentView.addSubview(textView)
            textView.delegate = self
            
            NSLayoutConstraint.activate([
                textView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
                textView.topAnchor.constraint(equalTo: contentView.topAnchor),
                textView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
                textView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            ])
        }
    }
    
    @objc func editingChanged() {
        titleSelectedCompletion!(self.taskTitleTextField.text!)
    }

    func textViewDidChange(_ textView: UITextView) {
        noteTextEditingChangedCompletion!(self.textView.text)
    }
    

    @objc func taskTypeSelected(_ sender: UISegmentedControl) {
        let selectedIndex = sender.titleForSegment(at: sender.selectedSegmentIndex)
        typeSelectedCompletion!(selectedIndex!)
    }
    
    
    
}

