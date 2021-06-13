//
//  CharacterDetailInteractor.swift
//  D&DCharManagerVIPER
//
//  Created by Egor on 29.05.2021.
//

import Foundation
import Firebase

class CharacterDetailInteractor {
    
    private var presenter: CharacterDetailPresenter?
    
    init(presenter: CharacterDetailPresenter) {
        self.presenter = presenter
    }
    
    func loadHeroWith(id: Int) {
        let db = Firestore.firestore()
        db.collection("Characters").whereField("id", isEqualTo: id).getDocuments { (snapshot, error) in
            guard let snapshot = snapshot else {
                print(error?.localizedDescription ?? "")
                return
            }
            
            for document in snapshot.documents {
                let data = document.data()
                let detailedHero = HeroCharacter(name: data["name"] as? String ?? "Error name",
                                            race: Race(string: data["race"] as? String ?? "human"),
                                            gClass: Class(string: data["class"] as? String ?? ""),
                                            stats: CharStats(strenght: data["strength"] as! Int, agility: data["agility"] as! Int, wisdom: data["wisdom"] as! Int, luck: data["luck"] as! Int),
                                            id: data["id"] as? Int ?? 0)
                self.presenter?.makeStructAndLoad(hero: detailedHero)
            }
        }
    }
    
    func makeHeroDetail(hero: HeroCharacter) {
        presenter?.makeStructAndLoad(hero: hero)
    }
    
    func generateQr(with string: String) {
        presenter?.makeQRAndShow(with: string)
    }
    
}
