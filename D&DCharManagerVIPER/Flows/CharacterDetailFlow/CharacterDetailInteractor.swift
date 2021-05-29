//
//  CharacterDetailInteractor.swift
//  D&DCharManagerVIPER
//
//  Created by Egor on 29.05.2021.
//

import Foundation

class CharacterDetailInteractor {
    
    private var presenter: CharacterDetailPresenter?
    
    init(presenter: CharacterDetailPresenter) {
        self.presenter = presenter
    }
    
    func makeHeroDetail(hero: HeroCharacter) {
        presenter?.makeStructAndLoad(hero: hero)
    }
    
}
