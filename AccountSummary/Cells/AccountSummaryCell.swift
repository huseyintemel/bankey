//
//  AccountSummaryCell.swift
//  bankey
//
//  Created by huseyin on 5.07.2023.
//

import UIKit

class AccountSummaryCell: UITableViewCell {
    
    struct ViewModel {
        let accountType: AccountType
        let accountName: String
        let balance: Decimal
        
        var balanceAsAttributedString: NSAttributedString {
            return CurrencyFormatter().makeAttributedCurrency(balance)
        }
    }

    static let reuseId = "AccountSummaryCell"
    static let rowHeight: CGFloat = 112
    let viewModel: ViewModel? = nil
    
    lazy var typeLabel: UILabel = {
        let label = UILabel()
        label.text = "Account type"
        label.font = UIFont.preferredFont(forTextStyle: .caption1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var underlineView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Account name"
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
        
    let balanceStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let balanceLabel: UILabel = {
        let label = UILabel()
        label.text="Some Balance"
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
        
    let balanceAmountLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let chevronImageView: UIImageView = {
        let imageView = UIImageView()
        let chevronImage = UIImage(systemName: "chevron.right")?.withTintColor(appColor,renderingMode: .alwaysOriginal)
        imageView.image = chevronImage
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(typeLabel)
        contentView.addSubview(underlineView)
        contentView.addSubview(nameLabel)
        addBalanceStackViewSubViews()
        contentView.addSubview(balanceStackView)
        contentView.addSubview(chevronImageView)

        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addBalanceStackViewSubViews(){
        balanceStackView.addArrangedSubview(balanceLabel)
        balanceStackView.addArrangedSubview(balanceAmountLabel)
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            //typeLabel
            typeLabel.topAnchor.constraint(equalTo: topAnchor,constant: 8),
            typeLabel.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 16),
            
            //underlineView
            underlineView.topAnchor.constraint(equalTo: typeLabel.bottomAnchor,constant: 8),
            underlineView.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 16),
            underlineView.widthAnchor.constraint(equalToConstant: 60),
            underlineView.heightAnchor.constraint(equalToConstant: 4),
            
            //nameLabel
            nameLabel.topAnchor.constraint(equalTo: underlineView.bottomAnchor,constant: 16),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 16),
            
            //balanceStackView
            balanceStackView.topAnchor.constraint(equalTo: underlineView.bottomAnchor),
            balanceStackView.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor,constant: 4),
            trailingAnchor.constraint(equalTo: balanceStackView.trailingAnchor,constant: 32),
            
            //chevronImage
            chevronImageView.topAnchor.constraint(equalTo: underlineView.bottomAnchor,constant: 8),
            trailingAnchor.constraint(equalTo: chevronImageView.trailingAnchor, constant: 8)
        ])
    }
    
}

extension AccountSummaryCell {
    func configure(with vm:ViewModel){
        typeLabel.text = vm.accountType.rawValue
        nameLabel.text = vm.accountName
        balanceAmountLabel.attributedText = vm.balanceAsAttributedString
        
        switch vm.accountType {
            
        case .Banking:
            underlineView.backgroundColor = appColor
            balanceLabel.text = "Current Balance"
        case .CreditCard:
            underlineView.backgroundColor = .systemOrange
            balanceLabel.text = "Current Balance"
        case .Investment:
            underlineView.backgroundColor = .systemPurple
            balanceLabel.text = "Value"
        }
    }
}
