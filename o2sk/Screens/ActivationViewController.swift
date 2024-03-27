//
//  ActivationViewController.swift
//  o2sk
//
//  Created by alex on 27/03/2024.
//

import UIKit

class ActivationViewController: UIViewController {
    let dependencies: CardDependencies
    let activateButton = RoundedButton(frame: .zero)

    let activationCompletion: (ScratchCard) -> Void
    let card: ScratchCard
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    required init(dependencies: CardDependencies, card: ScratchCard, completionHandler: @escaping (ScratchCard) -> Void) {
        self.dependencies = dependencies
        self.activationCompletion = completionHandler
        self.card = card
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup() {
        view.backgroundColor = UIColor(named: "AWSessionBackground")
        self.title = NSLocalizedString("Card Activation", comment: "")
        
        activateButton.translatesAutoresizingMaskIntoConstraints = false
        activateButton.cornerRadius = 10
        
        activateButton.setTitle(NSLocalizedString("Activate Card", comment: ""), for: .normal)
        activateButton.addTarget(self, action: #selector(activateButtonTapped), for: .touchUpInside)

        view.addSubview(activateButton)
        
        NSLayoutConstraint.activate([
            activateButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: +15),
            activateButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            activateButton.heightAnchor.constraint(equalToConstant: 60),
            activateButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activateButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50)
        ])
    }
    
    func handleActivationError(error: Error) {
        let errorMessage = error.localizedDescription
        
        let alert = UIAlertController(title: NSLocalizedString("Activation Failure", comment: "activation error alert title"), message: errorMessage, preferredStyle: .alert)
        let cancel = UIAlertAction(title: NSLocalizedString("Cancel", comment: "cancel"), style: .destructive)
 
        alert.addAction(cancel)
        self.present(alert, animated: true)
    }
    
    // MARK: - IBActions
    @objc func activateButtonTapped() {
        Task {
            do {
                let model = try await self.dependencies.activationClient.activate(code: card.code)
                
                if !dependencies.activationValidator.isActivationValidFrom(response: model) {
                    handleActivationError(error: ActivationError.invalidCode)
                  return
                }
                
                print("\(model)")
                let activatedCard = ScratchCard(code: card.code, state: .activated)
                activationCompletion(activatedCard)

            } catch {
                handleActivationError(error: ActivationError.invalidRequest)
            }
        }
    }
}
