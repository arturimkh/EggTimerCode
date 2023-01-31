//
//  ViewController.swift
//  EggTimerCode
//
//  Created by Artur Imanbaev on 30.01.2023.
//

import UIKit

class ViewController: UIViewController {
    var stack = UIStackView()
    let progressBar: UIProgressView = {
        $0.progress = 0
        $0.progressTintColor = .yellow
        $0.trackTintColor = .darkGray
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIProgressView())
    let titleLabel: UILabel = {
        $0.text = "How do you like your eggs?"
        $0.textAlignment = .center
        $0.textColor = .darkGray
        $0.font = .systemFont(ofSize: 30)
        $0.numberOfLines = 2
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
    let titles = ["Soft": 5.0,"Medium": 7.0,"Hard": 15.0]
    var totalTime = 0.0
    var secondPassed = 0.0
    var timer = Timer()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.5797027946, green: 0.9166823626, blue: 0.8194941282, alpha: 1)
        setupStack()
    }
    func setupStack(){
        view.addSubview(stack)
        stack.axis = .vertical
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.addArrangedSubview(titleLabel)
        let eggStack = UIStackView()
        eggStack.axis = .horizontal
        eggStack.distribution = .fillEqually
        for (hardness,min) in titles {
            let title = hardness
            let egg = EggView()
            egg.config(self, action: #selector(printHardness), with: title)
            eggStack.addArrangedSubview(egg)
        }
        stack.addArrangedSubview(eggStack)
        let progressView = UIView()
        progressView.addSubview(progressBar)
        stack.addArrangedSubview(progressView)
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 1),
            view.safeAreaLayoutGuide.bottomAnchor.constraint(equalToSystemSpacingBelow: stack.bottomAnchor, multiplier: 1),
            view.safeAreaLayoutGuide.trailingAnchor.constraint(equalToSystemSpacingAfter: stack.trailingAnchor, multiplier: 5),
            stack.leadingAnchor.constraint(equalToSystemSpacingAfter: view.safeAreaLayoutGuide.leadingAnchor, multiplier: 5),
            progressBar.topAnchor.constraint(equalToSystemSpacingBelow: progressView.topAnchor, multiplier: 1),
            progressBar.leadingAnchor.constraint(equalToSystemSpacingAfter: progressView.leadingAnchor, multiplier: 1),
            progressView.trailingAnchor.constraint(equalToSystemSpacingAfter: progressBar.trailingAnchor, multiplier: 1),
            progressView.bottomAnchor.constraint(equalToSystemSpacingBelow: progressBar.bottomAnchor, multiplier: 1),
            progressBar.heightAnchor.constraint(equalToConstant: 15),
        ])
    }
    @objc func printHardness(_ sender: UIButton){
        timer.invalidate()
        let seconds = 60.0
        progressBar.progress = 0.0
        secondPassed = 0.0
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        if let title = sender.currentTitle {
            totalTime = (self.titles[title]! * seconds)
        }
    }
    @objc func updateTimer(){
        if secondPassed < totalTime {
            progressBar.setProgress(Float(secondPassed/totalTime), animated: true)
            secondPassed+=1
        } else{
            titleLabel.text! = "Done"
        }
    }


}

