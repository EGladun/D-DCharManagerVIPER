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
    
    func makeQRAndShow(with string: String) {
        if let qrcode = generateQRCode(from: string) {
            controller?.showQRCode(code: qrcode)
        }
    }
    
    private func generateQRCode(from string: String) -> UIImage? {
        let data = string.data(using: String.Encoding.utf8)
        
        if let filter = CIFilter(name: "CIQRCodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            let transform = CGAffineTransform(scaleX: 5, y: 5)
            
            if let output = filter.outputImage?.transformed(by: transform) {
                return UIImage(ciImage: output)
            }
        }
        
        return nil
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
