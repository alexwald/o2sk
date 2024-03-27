//
//  ScratchViewController.swift
//  o2sk
//
//  Created by alex on 27/03/2024.
//

import UIKit

class ScratchViewController: UIViewController {
    let scratchButton = RoundedButton(frame: .zero)

    let scratchCompletion: (ScratchCard) -> Void
    let card: ScratchCard
    
    var scratchTask: Task<Void, Error>? = nil

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    required init(card: ScratchCard, completionHandler: @escaping (ScratchCard) -> Void) {
        self.card = card
        self.scratchCompletion = completionHandler
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        scratchTask?.cancel()
        scratchTask = nil
    }
    
    func setup() {
        view.backgroundColor = UIColor(named: "AWSessionBackground")
        self.title = NSLocalizedString("Card Scratch", comment: "")
        
        scratchButton.translatesAutoresizingMaskIntoConstraints = false
        scratchButton.cornerRadius = 10
        
        scratchButton.setTitle(NSLocalizedString("Scratch Card", comment: ""), for: .normal)
        scratchButton.addTarget(self, action: #selector(scratchButtonTapped), for: .touchUpInside)

        view.addSubview(scratchButton)
        
        NSLayoutConstraint.activate([
            scratchButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: +15),
            scratchButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            scratchButton.heightAnchor.constraint(equalToConstant: 60),
            scratchButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            scratchButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50)
        ])
    }
    
    // MARK: - IBActions
    @objc func scratchButtonTapped() {
        scratchTask?.cancel()
        scratchTask = Task {
            try await Task.sleep(nanoseconds: 3_000_000_000)
            let card = ScratchCard(code: self.card.code, state: .scratched)
            self.scratchCompletion(card)
        }
    }
}
