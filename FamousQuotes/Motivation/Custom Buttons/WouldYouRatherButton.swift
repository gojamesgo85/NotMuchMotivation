//
//  WouldYouRatherButton.swift
//  Motivation
//
//  Created by James on 11/16/22.
//

import UIKit

class WouldYouRatherButton: UIButton {

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
        setTitle("Give me a famous quote", for: .normal)
        setTitleColor(.white, for: .normal)
        titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
        translatesAutoresizingMaskIntoConstraints = false
        
    }
}
