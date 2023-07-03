//
//  DummyViewController.swift
//  bankey
//
//  Created by huseyin on 3.07.2023.
//

import UIKit

class DummyViewController: UIViewController {

    lazy var label: UILabel = {
        let label = UILabel()
        label.text = "Welcome"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 24)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var logoutButton: UIButton = {
        let button = UIButton(type: .system)
        button.configuration = .filled()
        button.setTitle("Logout", for: [])
        button.addTarget(self, action: #selector(logoutTapped), for: .primaryActionTriggered)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    weak var delegate: LogoutDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        view.addSubview(label)
        view.addSubview(logoutButton)
        
        setConstraints()
    }
   
    func setConstraints() {
        NSLayoutConstraint.activate([
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            logoutButton.topAnchor.constraint(equalTo: label.bottomAnchor,constant: 20),
            logoutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
    
    @objc func logoutTapped(){
        delegate?.didLogout()
    }

}
