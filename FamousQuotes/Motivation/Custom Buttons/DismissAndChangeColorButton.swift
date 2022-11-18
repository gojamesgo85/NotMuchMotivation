//
//  DismissAndChangeColorButton.swift
//  Motivation
//
//  Created by James on 11/17/22.
//

import UIKit

class DismissAndChangeColorButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        layer.cornerRadius = 10
        layer.borderWidth = 1
        backgroundColor = .systemRed
        setTitle("Go Back and Change Colors!", for: .normal)
        titleLabel?.textColor = .white
        titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
        translatesAutoresizingMaskIntoConstraints = false
        
    }
}
