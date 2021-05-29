//
//  CharacterDetailController.swift
//  D&DCharManagerVIPER
//
//  Created by Egor on 29.05.2021.
//

import UIKit

class CharacterDetailController: UIViewController {
    //MARK: Outlets
    @IBOutlet weak var classIcon: UIImageView!
    @IBOutlet weak var raceIcon: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var strengthLabel: UILabel!
    @IBOutlet weak var agilityLabel: UILabel!
    @IBOutlet weak var wisdomLabel: UILabel!
    @IBOutlet weak var luckLabel: UILabel!
    
    //MARK: Variables
    private var interactor: CharacterDetailInteractor?
    private var presenter: CharacterDetailPresenter?

    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupModule()
    }
    
    //MARK: Methods
    private func setupModule() {
        presenter = CharacterDetailPresenter()
        presenter?.controller = self
        guard presenter != nil else { return }
        interactor = CharacterDetailInteractor(presenter: presenter!)
    }

    //MARK: Actions
    @IBAction func shareHandler(_ sender: Any) {
        
    }
    
    @IBAction func backHandler(_ sender: Any) {
        
    }
}
