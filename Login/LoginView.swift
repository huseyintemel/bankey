//
//  LoginView.swift
//  bankey
//
//  Created by huseyin on 19.06.2023.
//

import UIKit

class LoginView: UIView {

    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Bankey"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()

    lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Your premium source for all things banking!"
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 20)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
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
    
    lazy var signInButton: UIButton = {
        let button = UIButton(type: .system)
        button.configuration = .filled()
        button.setTitle("Sign In", for: [])
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(signInTapped), for: .primaryActionTriggered)
        button.configuration?.imagePadding = 8 // indicator spacing

        return button
    }()
    
    lazy var errorMessageLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemRed
        label.numberOfLines = 0
        label.isHidden = true
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    var username: String? {
        return usernameTextField.text
    }
    
    var password: String? {
        return passwordTextField.text
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(titleLabel)
        addSubview(subtitleLabel)
        addSubview(textFieldStack)
        addSubview(signInButton)
        addSubview(errorMessageLabel)
        
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
            //titleLabel
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            
            //subtitleLabel
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor,constant: 20),
            subtitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            subtitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            //textFieldStack
            textFieldStack.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor,constant: 20),
            textFieldStack.leadingAnchor.constraint(equalTo: leadingAnchor),
            textFieldStack.trailingAnchor.constraint(equalTo: trailingAnchor),
                        
            //dividerView
            dividerView.heightAnchor.constraint(equalToConstant: 1),
            
            //signInButton
            signInButton.topAnchor.constraint(equalTo: textFieldStack.bottomAnchor,constant: 20),
            signInButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            signInButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            //errorMessageLabel
            errorMessageLabel.topAnchor.constraint(equalTo: signInButton.bottomAnchor,constant: 10),
            errorMessageLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            errorMessageLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            errorMessageLabel.bottomAnchor.constraint(equalTo: bottomAnchor,constant: 20)
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

extension LoginView {
    @objc func signInTapped() {
        errorMessageLabel.isHidden = true
        login()
    }
    
    private func login() {
        guard let username = username, let password = password else {
            assertionFailure("Username / password should never be nil")
            return
        }
        
        if username.isEmpty || password.isEmpty {
            configureView(withMessage: "Username / password cannot be blank")
            return
        }
        
        if username == "Deneme" && password == "deneme" {
            signInButton.configuration?.showsActivityIndicator = true
        } else {
            configureView(withMessage: "Incorrect username / password")
        }
        
    }
    
    private func configureView(withMessage message: String){
        errorMessageLabel.isHidden = false
        errorMessageLabel.text = message
    }
    
}