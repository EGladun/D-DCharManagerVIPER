//
//  CharactersListInteractor.swift
//  D&DCharManagerVIPER
//
//  Created by Egor on 27.05.2021.
//

import Foundation
import Firebase

class CharactersListInteractor {
    
    var presenter: CharactersListPresenter
    
    var charList: [HeroCharacter] = [] {
        didSet {
            presenter.updateHeroesArray(array: charList)
        }
    }
    
    init(presenter: CharactersListPresenter) {
        self.presenter = presenter
    }
    
    func fetchCharacters() {
        charList.removeAll()
        let db = Firestore.firestore()
        
        db.collection("Characters").getDocuments { (snapshot, error) in
            guard let snapshot = snapshot else {
                print(error?.localizedDescription ?? "")
                return
            }
            
            for document in snapshot.documents {
                let data = document.data()
                let newHero = HeroCharacter(name: data["name"] as? String ?? "Error name",
                                            race: Race(string: data["race"] as? String ?? "human"),
                                            gClass: Class(string: data["class"] as? String ?? ""),
                                            stats: CharStats(strenght: data["strength"] as! Int, agility: data["agility"] as! Int, wisdom: data["wisdom"] as! Int, luck: data["luck"] as! Int),
                                            id: data["id"] as? Int ?? 0)
                self.charList.append(newHero)
            }
        }
    }
    
    func deleteCharacter(_ index: Int) {
        let id = charList[index].id
        let db = Firestore.firestore()
        db.collection("Characters").whereField("id", isEqualTo: id).getDocuments { (snapshot, error) in
            if let error = error {
                self.presenter.makeAlert(title: "Error", message: error.localizedDescription, btnTitle: "Ok")
            } else {
                for document in snapshot!.documents {
                    document.reference.delete()
                }
                self.charList.remove(at: index)
                self.presenter.updateHeroesArray(array: self.charList)
            }
        }
    }
    
}
