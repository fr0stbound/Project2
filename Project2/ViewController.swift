//
//  ViewController.swift
//  Project2
//
//  Created by Aleksey Isaev on 12.04.2023.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    
    var countries = [String]()
    var score = 0
    var correctAnswer = 0
    var attemps = 5
    var usedAttemps = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
        
        button1.layer.borderWidth = 2
        button2.layer.borderWidth = 2
        button3.layer.borderWidth = 2
        
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor
        
        askQuestion()
    }

    func askQuestion(action: UIAlertAction! = nil) {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        
        title = "\(countries[correctAnswer].uppercased()), your score: \(score)"
    }

    @IBAction func buttonTapped(_ sender: UIButton) {
        var title: String?
        
        if usedAttemps < 5 {
            usedAttemps += 1
            if sender.tag == correctAnswer {
                title = "Correct!"
                score += 1
            } else {
                title = "Wrong! That's the flag of \(countries[sender.tag].capitalized)"
                score -= 1
            }
        }
        
        if attemps != usedAttemps {
            let ac = UIAlertController(title: title, message: "Your score is \(score).", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
            present(ac, animated: true)
        } else {
            let ac = UIAlertController(title: "Game over!", message: "Your final score is \(score) from \(attemps).", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "New game?", style: .default, handler: askQuestion))
            present(ac, animated: true)
            usedAttemps = 0
            score = 0
        }
    }
}

