//
//  CharacterDetailPresenter.swift
//  D&DCharManagerVIPER
//
//  Created by Egor on 29.05.2021.
//

import Foundation
import UIKit

class CharacterDetailPresenter {
    
    open weak var controller: CharacterDetailController?
    
    func makeStructAndLoad(hero: HeroCharacter) {
        let shareText = "ddcmanvip://\(hero.id)"
        let model = CharacterDetailModel(classImage: UIImage(named: hero.gClass.string), raceImage: UIImage(named: hero.race.string), name: hero.name, strength: "Strength: \(hero.stats.strenght)", agility: "Agility: \(hero.stats.agility)", wisdom: "Wisdom: \(hero.stats.wisdom)", luck: "Luck: \(hero.stats.luck)", shareText: shareText)
        controller?.setupFromPresenter(data: model)
    }
    
}

struct CharacterDetailModel {
    var classImage: UIImage?
    var raceImage: UIImage?
    var name: String
    var strength: String
    var agility: String
    var wisdom: String
    var luck: String
    var shareText: String
}
