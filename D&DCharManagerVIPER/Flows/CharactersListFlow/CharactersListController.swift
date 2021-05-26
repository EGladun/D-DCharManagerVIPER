//
//  CharactersListController.swift
//  D&DCharManagerVIPER
//
//  Created by Egor on 27.05.2021.
//

import UIKit

class CharactersListController: UIViewController {
    
    @IBOutlet weak var charactersTable: UITableView!
    
    var interactor: CharactersListInteractor?
    var presenter: CharactersListPresenter?
    
    var heroesArray: [HeroCharacter] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        setupModule()
        setupTable()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        interactor?.fetchCharacters()
    }
    
    private func setupModule() {
        presenter = CharactersListPresenter()
        presenter?.delegate = self
        guard presenter != nil else { return }
        interactor = CharactersListInteractor(presenter: presenter!)
    }
    
    private func setupTable() {
        charactersTable.delegate = self
        charactersTable.dataSource = self
        charactersTable.registerCellNib(CharacterCell.self)
    }

    @IBAction func plusButtonHandler(_ sender: Any) {
        //
    }
}

extension CharactersListController: CharactersPresenterDelegate {
    func reloadTableView(with data: [HeroCharacter]) {
        heroesArray = data
        charactersTable.reloadData()
    }
}

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
    
}
