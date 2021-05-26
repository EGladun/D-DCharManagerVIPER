//
//  CharactersListPresenter.swift
//  D&DCharManagerVIPER
//
//  Created by Egor on 27.05.2021.
//

import Foundation
import UIKit

protocol CharactersPresenterDelegate: AnyObject {
    func reloadTableView(with data: [HeroCharacter])
}

class CharactersListPresenter {
    
    open weak var delegate: CharactersPresenterDelegate?
    
    func updateHeroesArray(array: [HeroCharacter]) {
        delegate?.reloadTableView(with: array)
    }
}
