//
//  CharactersListController.swift
//  D&DCharManagerVIPER
//
//  Created by Egor on 27.05.2021.
//

import UIKit

class CharactersListController: UIViewController {
    //MARK: Outlets
    @IBOutlet weak var charactersTable: UITableView!
    
    //MARK: Variables
    var interactor: CharactersListInteractor?
    var presenter: CharactersListPresenter?
    
    var onNewHero: (()->Void)?
    var onHeroDetail: ((HeroCharacter)->Void)?
    
    var heroesArray: [HeroCharacter] = []

    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupModule()
        setupTable()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        interactor?.fetchCharacters()
    }
    
    //MARK: Methods
    private func setupModule() {
        presenter = CharactersListPresenter()
        presenter?.controller = self
        guard presenter != nil else { return }
        interactor = CharactersListInteractor(presenter: presenter!)
    }
    
    private func setupTable() {
        charactersTable.delegate = self
        charactersTable.dataSource = self
        charactersTable.registerCellNib(CharacterCell.self)
    }
    
    func reloadTableView(with data: [HeroCharacter]) {
        heroesArray = data
        charactersTable.reloadData()
    }
    
    func showAlert(_ alert: UIAlertController) {
        self.present(alert, animated: true, completion: nil)
    }

    //MARK: Actions
    @IBAction func plusButtonHandler(_ sender: Any) {
        onNewHero?()
    }
}

//MARK: Extensions
extension CharactersListController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return heroesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: CharacterCell.self)) as? CharacterCell
        cell?.selectionStyle = .none
        cell?.fillData(with: heroesArray[indexPath.row])
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard indexPath.row < heroesArray.count else {
            return
        }
        let hero = heroesArray[indexPath.row]
        onHeroDetail?(hero)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            interactor?.deleteCharacter(indexPath.row)
        }
    }
}
