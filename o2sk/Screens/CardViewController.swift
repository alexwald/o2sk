//
//  CardViewController.swift
//  o2sk
//
//  Created by alex on 27/03/2024.
//

import UIKit

class CardViewController: UIViewController {
    let dependencies: CardDependencies
    let cardStatus = RoundedButton(frame: .zero)
    let cardCode = RoundedButton(frame: .zero)

    let scratchButton = RoundedButton(frame: .zero)
    let activateButton = RoundedButton(frame: .zero)

    var card = ScratchCard(code: UUID().uuidString, state: .unscratched)
    
    // MARK: - Init
    static func instantiate(with dependencies: CardDependencies) -> Self {
        return self.init(dependencies: dependencies)
    }

    required init(dependencies: CardDependencies) {
        self.dependencies = dependencies
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        refreshUI()
    }
    
    func setup() {
        view.backgroundColor = UIColor(named: "AWSessionBackground")
        
        cardStatus.cornerRadius = 10
        cardStatus.backgroundColor = .white
        cardStatus.translatesAutoresizingMaskIntoConstraints = false
        cardStatus.setTitleColor(.gray, for: [])
        view.addSubview(cardStatus)

        cardCode.cornerRadius = 10
        cardCode.backgroundColor = .white
        cardCode.translatesAutoresizingMaskIntoConstraints = false
        cardCode.setTitleColor(.gray, for: [])

        view.addSubview(cardCode)

        scratchButton.setTitle(NSLocalizedString("Scratch", comment: ""), for: .normal)
        scratchButton.cornerRadius = 10
        scratchButton.addTarget(self, action: #selector(scratchButtonTapped), for: .touchUpInside)

        activateButton.setTitle(NSLocalizedString("Activate", comment: ""), for: .normal)
        activateButton.cornerRadius = 10
        activateButton.addTarget(self, action: #selector(activateButtonTapped), for: .touchUpInside)
        
        let stackView = UIStackView(arrangedSubviews: [scratchButton, activateButton])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            cardStatus.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            cardStatus.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            cardStatus.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            cardStatus.heightAnchor.constraint(equalToConstant: 60),
            
            cardCode.topAnchor.constraint(equalTo: cardStatus.bottomAnchor, constant: 10),
            cardCode.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            cardCode.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            cardCode.heightAnchor.constraint(equalToConstant: 60),
            
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: +10),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            stackView.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    func refreshUI() {
        cardStatus.setTitle("Card Status: \(card.state.localizedString())", for: .normal)
        cardCode.setTitle("Card Code: \(card.state == .scratched || card.state == .activated ? card.code : "")", for: .normal)

        scratchButton.isEnabled = card.state == .unscratched
        activateButton.isEnabled = card.state == .scratched
    }
    
    // MARK: - IBActions
    @objc func scratchButtonTapped() {
        let scratchVC = ScratchViewController(card: card, completionHandler: { scratchedCard in
            self.card = scratchedCard
            print("scratch vc completed with card: \(self.card)")
            self.navigationController?.popViewController(animated: true)

        })
        self.navigationController?.show(scratchVC, sender: self)
    }
    
    @objc func activateButtonTapped() {
        let activateVC = ActivationViewController(dependencies: dependencies, card: card, completionHandler: { activatedCard in
            self.card = activatedCard
            self.refreshUI()
            print("activation vc completed with card: \(self.card)")
            self.navigationController?.popViewController(animated: true)

        })
        show(activateVC, sender: self)
    }
}
