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
    
    var onBack: (()->Void)?
    
    var hero: HeroCharacter?
    private var textForSharing: String = "" // Текст для генерации QR-кода
    
    private var isSetup: Bool = false

    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupModule()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let hero = self.hero {
            interactor?.makeHeroDetail(hero: hero)
        }
    }
    
    //MARK: Methods
    private func setupModule() {
        guard !isSetup else {return}
        presenter = CharacterDetailPresenter()
        presenter?.controller = self
        guard presenter != nil else { return }
        interactor = CharacterDetailInteractor(presenter: presenter!)
        isSetup.toggle()
    }
    
    func loadId(_ id: Int) {
        if !isSetup {
            setupModule()
        }
        interactor?.loadHeroWith(id: id)
    }
    
    func setupFromPresenter(data: CharacterDetailModel) {
        classIcon.image = data.classImage
        raceIcon.image = data.raceImage
        nameLabel.text = data.name
        strengthLabel.text = data.strength
        agilityLabel.text = data.agility
        wisdomLabel.text = data.wisdom
        luckLabel.text = data.luck
        
        textForSharing = data.shareText
    }
    
    func showQRCode(code: UIImage) {
        let vc = QRCOdeController()
        vc.loadImage(code)
        vc.modalPresentationStyle = .formSheet
        self.present(vc, animated: true, completion: nil)
    }

    //MARK: Actions
    @IBAction func shareHandler(_ sender: Any) {
        interactor?.generateQr(with: textForSharing)
    }
    
    @IBAction func backHandler(_ sender: Any) {
        onBack?()
    }
}
