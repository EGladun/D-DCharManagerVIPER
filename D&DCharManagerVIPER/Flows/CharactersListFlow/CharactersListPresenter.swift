//
//  CharactersListPresenter.swift
//  D&DCharManagerVIPER
//
//  Created by Egor on 27.05.2021.
//

import Foundation
import UIKit

class CharactersListPresenter {
    
    open weak var controller: CharactersListController?
    
    func updateHeroesArray(array: [HeroCharacter]) {
        controller?.reloadTableView(with: array)
    }
}
