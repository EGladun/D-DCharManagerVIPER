//
//  Coordinator.swift
//  D&DCharManagerVIPER
//
//  Created by Egor on 23.05.2021.
//

import Foundation

class ApplicationCoordinator {
    
    private var router: Router
    private var factory = ControllersFactory()
    
    private var charListView: CharactersListController?
    private var charDetailView: CharacterDetailController?
    private var charAddView: CharacterAddController?
    
    init(router: Router) {
        self.router = router
    }
    
    func start() {
        runListFlow()
    }
    
    func start(id: Int) {
        runListFlow()
        runHeroDetailFlow(hero: nil, id: id)
    }
    
    private func runListFlow() {
        charListView = factory.makeCharactersListController()
        
        charListView?.onNewHero = { [weak self] in
            self?.runNewHeroFlow()
        }
        
        charListView?.onHeroDetail = { [weak self] hero in
            self?.runHeroDetailFlow(hero: hero, id: nil)
        }
        
        router.push(charListView)
    }
    
    private func runNewHeroFlow() {
        charAddView = factory.makeCharacterAddController()
        
        charAddView?.onBack = { [weak self] in
            self?.router.popModule()
        }
        
        router.push(charAddView)
    }
    
    private func runHeroDetailFlow(hero: HeroCharacter?, id: Int?) {
        charDetailView = factory.makeCharacterDetailController()
        
        charDetailView?.onBack = { [weak self] in
            self?.router.popModule()
        }
        
        if let hero = hero {
            charDetailView?.hero = hero
        }
        
        if let id = id {
            charDetailView?.loadId(id)
        }
        
        router.push(charDetailView)
    }
}

