//
//  ViewController.swift
//  Motivation
//
//  Created by James on 11/15/22.
//

import UIKit



struct MotivationalQuote: Decodable {
    let quote : String
    
}
class ViewController: UIViewController {
   
    var newText = ""
    
    init() {
        
        
        super.init(nibName: nil, bundle: nil)
        motivationalNetworkRequest()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    
    let motivateMeButton = MotivateButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBlue
        configureSubViews()
    }
    
    func configureSubViews() {
        view.addSubview(motivateMeButton)
        motivateMeButton.translatesAutoresizingMaskIntoConstraints = false
        motivateMeButton.addTarget(self, action: #selector(quickText), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            motivateMeButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -300),
            motivateMeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            motivateMeButton.heightAnchor.constraint(equalToConstant: 50),
            motivateMeButton.widthAnchor.constraint(equalToConstant: 300),
        ])
    }
    
    @objc func quickText() {
        DispatchQueue.main.async {
            self.present(MotivationVC(text: self.newText ), animated: true)
            self.motivationalNetworkRequest()
        }
    }
    
     func motivationalNetworkRequest() {
        
        let headers = [
            "content-type": "application/json",
            "X-RapidAPI-Key": "bc9a73da7dmshad208c4b6a57bf9p13e4f3jsnf6beb9575ddb",
            "X-RapidAPI-Host": "pquotes.p.rapidapi.com"
        ]
        let parameters = ["topic": "fun"] as [String : Any]
        
        let postData = try? JSONSerialization.data(withJSONObject: parameters, options: [])
        
        let request = NSMutableURLRequest(url: NSURL(string: "https://pquotes.p.rapidapi.com/api/quote")! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headers
        request.httpBody = postData as Data?
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                print(error!)
            } else {
                let _ = response as? HTTPURLResponse
                
                let motivation = try? JSONDecoder().decode(MotivationalQuote.self, from: data!)
                if let motivation = motivation {
                    self.newText = motivation.quote
                }
            }
        })
        
        dataTask.resume()
        
    }
    
}

