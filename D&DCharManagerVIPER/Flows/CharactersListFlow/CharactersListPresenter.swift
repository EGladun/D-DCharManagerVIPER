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
    
    func makeAlert(title: String, message: String?, btnTitle: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        controller?.showAlert(alert)
    }
}
