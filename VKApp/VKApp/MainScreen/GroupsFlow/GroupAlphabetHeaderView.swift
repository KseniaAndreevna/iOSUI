//
//  GroupAlphabetHeaderView.swift
//  VKApp
//
//  Created by Ksusha on 01.03.2021.
//

import UIKit

class GroupAlphabetHeaderView: UITableViewHeaderFooterView {
        
    static let reuseIdentifier = "GroupAlphabetHeaderView"
        
    let headerTitle = UILabel()
        
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        //
        setupSubviews()
        setupConstraints()
    }
        
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        //
        setupSubviews()
        setupConstraints()
    }
    
    private func setupSubviews() {
        self.addSubview(headerTitle)
        //
        headerTitle.textColor = .black
        headerTitle.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        headerTitle.textAlignment = .left
        //
        backgroundView = UIView()
        backgroundView?.backgroundColor = UIColor.white
    }
        
    private func setupConstraints() {
        
        headerTitle.translatesAutoresizingMaskIntoConstraints = false
        
        let xOffset: CGFloat = 20
        let yOffset: CGFloat = 10
        
        headerTitle.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: xOffset).isActive = true
        headerTitle.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -xOffset).isActive = true
        headerTitle.topAnchor.constraint(equalTo: self.topAnchor, constant: -yOffset).isActive = true
        headerTitle.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: yOffset).isActive = true
    }

}
