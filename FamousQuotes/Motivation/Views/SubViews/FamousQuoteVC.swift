//
//  FamousQuoteVC.swift
//  Motivation
//
//  Created by James on 11/17/22.
//

import UIKit
protocol ChangeButtonTextColorDelegate {
    func changeButtonTextColor()
}
protocol ParentViewBackgroundColorChangeDelagate {
    
    func didTapButton(color: UIColor)
    func callMyselfStupid()
}

class FamousQuoteVC: UIViewController {
    var authors: String
    var texts: String
    var selectionDelegate: ParentViewBackgroundColorChangeDelagate?
    var textColorDelegate: ChangeButtonTextColorDelegate?

    
    init(author: String, text: String) {
        
        authors = author
        texts = text
        super.init(nibName: nil, bundle: nil)
        print(text)
    }
    
    deinit {
        //print("IM GONNA DIE")
        authors = ""
        texts = ""
    }
    
    required init? (coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let dismissAndChangeColorButton = DismissAndChangeColorButton()
    
    var motivationalText = UILabel()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemRed
        configureViewController()
        
    }
    
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
        view.addSubview(dismissAndChangeColorButton)
        view.addSubview(motivationalText)
        
        dismissAndChangeColorButton.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)
        dismissAndChangeColorButton.translatesAutoresizingMaskIntoConstraints = false
        motivationalText.translatesAutoresizingMaskIntoConstraints = false
        
        motivationalText.layer.borderWidth = 1
        motivationalText.numberOfLines = 12
        motivationalText.textAlignment = .center
        motivationalText.adjustsFontForContentSizeCategory = true
        motivationalText.font = .systemFont(ofSize: 40)
        motivationalText.layer.cornerRadius = 23
        motivationalText.layer.masksToBounds = true
        motivationalText.font = UIFont.systemFont(ofSize: 23)
        motivationalText.textColor = .brown
        
        motivationalText.text = texts + "  -  " + authors
        motivationalText.backgroundColor = .systemBackground
        
        NSLayoutConstraint.activate([
            
            
            motivationalText.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            motivationalText.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            motivationalText.widthAnchor.constraint(equalToConstant: 350),
            motivationalText.heightAnchor.constraint(equalToConstant: 350),
            
            dismissAndChangeColorButton.topAnchor.constraint(equalTo: motivationalText.bottomAnchor, constant: 50),
            dismissAndChangeColorButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            dismissAndChangeColorButton.widthAnchor.constraint(equalToConstant: 350),
            
            
            
            
        ])
        
        
    }
    @objc func dismissVC() {
        selectionDelegate?.didTapButton(color: .systemRed)
        selectionDelegate?.callMyselfStupid()
        textColorDelegate?.changeButtonTextColor()
        
        
        navigationController?.popViewController(animated: true)
    }
}
