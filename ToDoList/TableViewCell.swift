//
//  TableViewCell.swift
//  ToDoList
//
//  Created by Jarae on 6/9/23.
//

import UIKit

class TableViewCell: UITableViewCell {
    static let reuseID = String(describing: self)
    
    private lazy var doneButton: UIButton = {
        let view = UIButton()
        view.setImage(UIImage(systemName: "circle"), for: .normal)
        view.addTarget(self, action: #selector(done), for: .touchUpInside)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var taskText: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 20, weight: .regular)
        view.numberOfLines = 1
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var isDone = false
    
    override func layoutSubviews() {
        setupConstraints()
    }
    
    
    func setupConstraints() {
        self.addSubviews(doneButton, taskText)
        
        NSLayoutConstraint.activate([
            doneButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 7),
            doneButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 3),
            doneButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            doneButton.widthAnchor.constraint(equalToConstant: 30),
            
            taskText.centerYAnchor.constraint(equalTo: doneButton.centerYAnchor),
            taskText.leadingAnchor.constraint(equalTo: doneButton.trailingAnchor, constant: 5),
            taskText.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
        ])
    }
    
    func configure(task: String) {
        taskText.text = task
    }
    
    @objc func done() {
        isDone.toggle()
        let image = isDone ? "checkmark.circle.fill" : "circle"
        
        doneButton.setImage(UIImage(systemName: image), for: .normal)
        print("done button tapped")
    }
}
