//
//  CharacterAddInteractor.swift
//  D&DCharManagerVIPER
//
//  Created by Egor on 29.05.2021.
//

import Foundation

class CharacterAddInteractor {
    
    private var presenter: CharacterAddPresenter?
    
    var selectedRace: Race = .human {
        didSet {
            print("New race is: \(selectedRace.string)")
        }
    }
    var selectedClass: Class = .knight {
        didSet {
            print("New class is: \(selectedClass.string)")
        }
    }
    
    var strength: Int = 5 {
        didSet {
            updateStatValues()
        }
    }
    var agility: Int = 5 {
        didSet {
            updateStatValues()
        }
    }
    var wisdom: Int = 5 {
        didSet {
            updateStatValues()
        }
    }
    var luck: Int = 5 {
        didSet {
            updateStatValues()
        }
    }
    
    var statSum: Int {
        return strength + agility + wisdom + luck
    }
    
    //MARK: Init
    init(presenter: CharacterAddPresenter) {
        self.presenter = presenter
    }
    
    func updateStatValues() {
        let stats = CharStats(strenght: strength, agility: agility, wisdom: wisdom, luck: luck)
        presenter?.updateViewWith(stats, statsSum: statSum)
    }
    
    func incrementStat(_ stat: HeroStat) {
        switch stat {
        case .strength:
            strength += 1
        case .agility:
            agility += 1
        case .wisdom:
            wisdom += 1
        case .luck:
            luck += 1
        }
    }
    
    func decrementStat(_ stat: HeroStat) {
        switch stat {
        case .strength:
            strength -= 1
        case .agility:
            agility -= 1
        case .wisdom:
            wisdom -= 1
        case .luck:
            luck -= 1
        }
    }
    
}

enum HeroStat {
    case strength, agility, wisdom, luck
}
