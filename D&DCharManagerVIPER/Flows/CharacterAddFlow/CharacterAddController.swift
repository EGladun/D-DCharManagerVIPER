//
//  CharacterAddController.swift
//  D&DCharManagerVIPER
//
//  Created by Egor on 29.05.2021.
//

import UIKit

class CharacterAddController: UIViewController {
    
    private var interactor: CharacterAddInteractor?
    private var presenter: CharacterAddPresenter?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupModule()
    }
    
    func setupModule() {
        presenter = CharacterAddPresenter()
        presenter?.controller = self
        guard presenter != nil else { return }
        interactor = CharacterAddInteractor(presenter: presenter!)
    }
}
