//
//  ViewController.swift
//  PrimeiroMVVM
//
//  Created by Rodrigo Policante Martins on 23/10/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var generateButton: UIButton!
    
    private var viewModel: MinhaViewModelProtocol

    init(viewModel: MinhaViewModelProtocol){
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        viewModel = MinhaViewModel()
        super.init(coder: coder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
//        messageLabel.text = "Toque no botão para gerar sua mensagem"
//        generateButton.configuration?.title = "Gerar"
        setupBind()
//        viewModel.getRandomJoke()
    }

    private func setupBind(){
        viewModel.showLoading = { [weak self] in
            self?.generateButton.configuration?.showsActivityIndicator = true
            self?.generateButton.configuration?.title = nil
            self?.generateButton.isEnabled = false
        }

        viewModel.hideLoading = { [weak self] in
            self?.generateButton.configuration?.showsActivityIndicator = false
            self?.generateButton.isEnabled = true
            self?.generateButton.configuration?.title = "Gerar"
        }

        viewModel.showMessage = { [weak self] value in
            self?.messageLabel.text = value
        }
    }

    // Quando tocar no botão Gerar
    @IBAction func onGenerateDidTap(_ sender: Any) {
        viewModel.getRandomJoke()
    }
}

