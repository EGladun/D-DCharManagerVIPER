//
//  CharacterAddPresenter.swift
//  D&DCharManagerVIPER
//
//  Created by Egor on 29.05.2021.
//

import Foundation
import UIKit

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
