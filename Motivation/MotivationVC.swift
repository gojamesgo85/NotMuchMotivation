//
//  MotivationVC.swift
//  Motivation
//
//  Created by James on 11/15/22.
//

import UIKit



class MotivationVC: UIViewController {
    var textStuff: String
    
    
   init(text: String) {

       textStuff = text
       super.init(nibName: nil, bundle: nil)
       print(text)
    }
    
    deinit {
        print("IM GONNA DIE")
        textStuff = ""
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    var motivationalText = UILabel()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemRed
        configureViewController()
       
    }
    

    func configureViewController() {
        view.backgroundColor = .systemBackground
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem = doneButton
        
        view.addSubview(motivationalText)
        
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
        
        motivationalText.text = textStuff
        motivationalText.backgroundColor = .systemBackground
        
        NSLayoutConstraint.activate([
        
            
            motivationalText.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            motivationalText.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            motivationalText.widthAnchor.constraint(equalToConstant: 350),
            motivationalText.heightAnchor.constraint(equalToConstant: 350)
            
        
        
        ])
        
        
    }
    @objc func dismissVC() {
        dismiss(animated: true)
    }
}
