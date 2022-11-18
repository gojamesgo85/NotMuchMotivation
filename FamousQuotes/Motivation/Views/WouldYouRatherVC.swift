//
//  WouldYouRatherVC.swift
//  Motivation
//
//  Created by James on 11/16/22.
//

import UIKit



struct FamousQuote: Decodable {
    let author: String
    let text: String
    
    private enum CodingKeys :String, CodingKey {
        case author = "author"
        case text = "text"
    }

    init(from decoder :Decoder) throws {
        if let container = try? decoder.container(keyedBy: CodingKeys.self) {
            self.author = try container.decode(String.self, forKey: .author)
            self.text = try container.decode(String.self, forKey: .text)
        } else {
            self.author = "Jeff"
            self.text = "Boobs are cool"
        }
    }
}

class WouldYouRatherVC: UIViewController, ParentViewBackgroundColorChangeDelagate, ChangeButtonTextColorDelegate {
    func callMyselfStupid() {
        famousPersonQuoteButton.titleLabel?.text = "I'm a ding dong"
    }
    

    
    func changeButtonTextColor() {
        famousPersonQuoteButton.setTitleColor(.systemGreen, for: .normal)
    }
    
    func didTapButton(color: UIColor) {
        view.backgroundColor = .systemCyan
    }
    
    var tempText = ""
    var tempText2 = ""
    
    init() {
        super.init(nibName: nil, bundle: nil)
        WYRNetworkRequest()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let famousPersonQuoteButton = WouldYouRatherButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGreen
        configureSubViews()
        
    }
    
    func configureSubViews() {
        view.addSubview(famousPersonQuoteButton)
        famousPersonQuoteButton.translatesAutoresizingMaskIntoConstraints = false
        famousPersonQuoteButton.addTarget(self, action: #selector(loadText), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            famousPersonQuoteButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -300),
            famousPersonQuoteButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            famousPersonQuoteButton.heightAnchor.constraint(equalToConstant: 50),
            famousPersonQuoteButton.widthAnchor.constraint(equalToConstant: 300),
        ])
    }
    
    @objc func loadText() {
        DispatchQueue.main.async {
            let famousQuoteVC = FamousQuoteVC(author: self.tempText, text: self.tempText2)
            famousQuoteVC.selectionDelegate = self
            famousQuoteVC.textColorDelegate = self
            self.navigationController?.pushViewController(famousQuoteVC, animated: true)
            self.WYRNetworkRequest()
        }

    }
    
    
    func WYRNetworkRequest() {
        let headers = [
            "X-RapidAPI-Key": "bc9a73da7dmshad208c4b6a57bf9p13e4f3jsnf6beb9575ddb",
            "X-RapidAPI-Host": "famous-quotes4.p.rapidapi.com"
        ]
        
        let request = NSMutableURLRequest(url: NSURL(string: "https://famous-quotes4.p.rapidapi.com/random?category=all&count=2")! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                print(error!)
            } else {
                let _ = response as? HTTPURLResponse
                guard let data = data, let array = try? JSONDecoder().decode([FamousQuote].self, from: data) else {
                    print("fuck")
                        return
                }
                    self.tempText = array.first!.author
                    self.tempText2 = array.first!.text
            }
        })
        
        dataTask.resume()
    }
}
