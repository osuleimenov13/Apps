//
//  ViewController.swift
//  FlagGame
//
//  Created by Olzhas Suleimenov on 14.07.2022.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    
    var countries = [String]()
    var score = 0
    var correctAnswer = 0
    var totalAnswers = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
        
        
        // Modifying Flag buttons style and design
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor
        
        button1.configuration?.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        button2.configuration?.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        button3.configuration?.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        
        askQuestion()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .play, target: self, action: #selector(showScore))
    }

    func askQuestion(action: UIAlertAction! = nil) {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        
        title = "\(countries[correctAnswer].uppercased())    Score: \(score)"
    }

    @IBAction func buttonTapped(_ sender: UIButton) {
        var alertTitle: String
        
        if sender.tag == correctAnswer {
            alertTitle = "Correct"
            score += 1
        } else{
            alertTitle = "Wrong! It's \(countries[sender.tag]) flag!"
            score -= 1
        }
        
        totalAnswers += 1
        title = "\(countries[correctAnswer].uppercased())    Score: \(score)"
                
        if totalAnswers < 5 {
            let ac = UIAlertController(title: alertTitle, message: "Your score is \(score)", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
            present(ac, animated: true)
        } else {
            let ac = UIAlertController(title: sender.tag == correctAnswer ? "Congratulations!" : alertTitle, message: "Your final score is \(score)", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "New Game", style: .default, handler: askQuestion))
            present(ac, animated: true)
            
            score = 0
            totalAnswers = 0
        }
    }
    
    @objc private func showScore() {
        let ac = UIAlertController(title: "Your score: \(score)", message: nil, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
}

