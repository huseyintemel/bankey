//
//  LoginView.swift
//  bankey
//
//  Created by huseyin on 19.06.2023.
//

import UIKit

class LoginView: UIView {
    
    lazy var textFieldStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 8
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.layer.cornerRadius = 6
        
        stack.layoutMargins = UIEdgeInsets(top: 10, left: 8, bottom: 10, right: 8)
        stack.isLayoutMarginsRelativeArrangement = true
        
        stack.backgroundColor = .secondarySystemBackground
        stack.clipsToBounds = true
        
        return stack
    }()
    
    lazy var usernameTextField : UITextField = {
        let textField = UITextField()
        textField.placeholder = "Username"
        textField.delegate = self
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }()
    
    lazy var passwordTextField : UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.isSecureTextEntry = true
        textField.delegate = self
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }()
    
    lazy var dividerView: UIView = {
        let view = UIView()
        view.backgroundColor = .secondarySystemFill
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(textFieldStack)
    
        addTextFieldStackSubViews()
        setConstraints()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addTextFieldStackSubViews() {
        textFieldStack.addArrangedSubview(usernameTextField)
        textFieldStack.addArrangedSubview(dividerView)
        textFieldStack.addArrangedSubview(passwordTextField)
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            //textFieldStack
            textFieldStack.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 1),
            textFieldStack.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 1),
            trailingAnchor.constraint(equalToSystemSpacingAfter: textFieldStack.trailingAnchor, multiplier: 1),
            bottomAnchor.constraint(equalToSystemSpacingBelow: textFieldStack.bottomAnchor, multiplier: 1),
                        
            //dividerView
            dividerView.heightAnchor.constraint(equalToConstant: 1),
            
        ])
    }
    
}

extension LoginView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        usernameTextField.endEditing(true)
        passwordTextField.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
    }
}
