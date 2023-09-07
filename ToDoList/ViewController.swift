//
//  ViewController.swift
//  ToDoList
//
//  Created by Jarae on 5/9/23.
//

import UIKit

class ViewController: UIViewController {

    private lazy var newTask: UITextField = {
        let view = UITextField()
        view.backgroundColor = .white
        view.placeholder = "  add task"
        view.layer.borderWidth = 1
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var addButton: UIButton = {
        let view = UIButton()
        view.setTitle("ADD", for: .normal)
        view.backgroundColor = .systemBlue
        view.tintColor = .white
        view.layer.cornerRadius = 4
        view.addTarget(self, action: #selector(addTask), for: .touchUpInside)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var tasksList: UITableView = {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var tasks: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Tasks"
        setupConstraints()
        setupTableView()
        
        if !UserDefaults().bool(forKey: "setup") {
            UserDefaults().set(true, forKey: "setup")
            UserDefaults().set(0, forKey: "count")
        }
        
        updateTasks()
    }
    
    func updateTasks() {
        tasks.removeAll()
        
        guard let count = UserDefaults().value(forKey: "count") as? Int else {
            return
        }
        
        let task = Task(id: count + 1, text: <#T##String#>, isDone: <#T##Bool?#>)
        
        
        for x in 0..<count {
            if let task = UserDefaults().value(forKey: "task_\(x + 1)") as? String {
                //tasks.append(task)
            }
        }
        
        tasksList.reloadData()
    }

    @objc func addTask() {
//        guard let text = newTask.text, !text.isEmpty else {
//            return
//        }
//
//        guard let count = UserDefaults().value(forKey: "count") as? Int else {
//            return
//        }
//
//        let newCount = count + 1
//
//        UserDefaults().set(newCount, forKey: "count")
//        UserDefaults().set(text, forKey: "task_\(newCount)")
//
//        updateTasks()
//        newTask.text = ""
        
        let text = newTask.text ?? ""
        tasks.append(text)
        tasksList.reloadData()
    }
    
    private func setupConstraints() {
        view.addSubviews(newTask, addButton, tasksList)
        
        NSLayoutConstraint.activate([
            newTask.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            newTask.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            newTask.heightAnchor.constraint(equalToConstant: 40),
            
            addButton.heightAnchor.constraint(equalToConstant: 40),
            addButton.widthAnchor.constraint(equalToConstant: 50),
            addButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            addButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            addButton.leadingAnchor.constraint(equalTo: newTask.trailingAnchor, constant: 10),
            
            
            tasksList.topAnchor.constraint(equalTo: newTask.bottomAnchor, constant: 20),
            tasksList.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tasksList.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tasksList.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    private func setupTableView() {
        tasksList.dataSource = self
        tasksList.delegate = self
        tasksList.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.reuseID)
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.reuseID, for: indexPath) as? TableViewCell
        cell?.configure(task: tasks[indexPath.row])
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewController = DetailsViewController()
        navigationController?.pushViewController(viewController, animated: true)
    }
}

