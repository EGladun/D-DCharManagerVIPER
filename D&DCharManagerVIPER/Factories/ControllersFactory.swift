//
//  ControllersFactory.swift
//  D&DCharManagerVIPER
//
//  Created by Egor on 27.05.2021.
//

import Foundation

class ControllersFactory {
    
    func makeCharactersListController() -> CharactersListController {
        return CharactersListController.controllerFromStoryboard(.main)
    }
    
    func makeCharacterDetailController() -> CharacterDetailController {
        return CharacterDetailController.controllerFromStoryboard(.main)
    }
    
}
