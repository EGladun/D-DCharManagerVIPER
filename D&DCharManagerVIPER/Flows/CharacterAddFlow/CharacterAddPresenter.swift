//
//  CharacterAddPresenter.swift
//  D&DCharManagerVIPER
//
//  Created by Egor on 29.05.2021.
//

import Foundation
import UIKit
import Firebase

class CharacterAddPresenter {
    
    open weak var controller: CharacterAddController?
    
    var allRaces = Race.allCases
    var allClasses = Class.allCases
    
    func raceCount() -> Int {
        return Race.allCases.count
    }
    
    func classCount() -> Int {
        return Class.allCases.count
    }
    
    func updateViewWith(_ stats: CharStats, statsSum: Int) {
        let model = CharacterAddModel(strenght: "\(stats.strenght)",
                                      agility: "\(stats.agility)",
                                      wisdom: "\(stats.wisdom)",
                                      luck: "\(stats.luck)",
                                      strPlus: statsSum > 42,
                                      strMinus: stats.strenght == 1,
                                      aglPlus: statsSum > 42,
                                      aglMinus: stats.agility == 1,
                                      wsdPlus: statsSum > 42,
                                      wsdMinus: stats.wisdom == 1,
                                      luckPlus: statsSum > 42,
                                      luckMinus: stats.luck == 1)
        controller?.updateViewWith(model: model)
    }
    
    func saveAndExit(_ hero: HeroCharacter) {
        let heroDict = hero.toDictionary()
        let db = Firestore.firestore()
        db.collection("Characters").addDocument(data: heroDict)
        controller?.onBack?()
    }
    
    func makeAlert(error: ErrorType) {
        let alert: UIAlertController?
        switch error {
        case .emptyName:
            alert = UIAlertController(title: "Wrong name", message: "Enter right name, please", preferredStyle: .alert)
            alert?.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        }
        
        guard let alert = alert else { return }
        controller?.showAlert(alert)
    }
    
}

struct CharacterAddModel {
    var strenght: String
    var agility: String
    var wisdom: String
    var luck: String
    
    var strPlus: Bool
    var strMinus: Bool
    var aglPlus: Bool
    var aglMinus: Bool
    var wsdPlus: Bool
    var wsdMinus: Bool
    var luckPlus: Bool
    var luckMinus: Bool
}

enum ErrorType {
    case emptyName
}
