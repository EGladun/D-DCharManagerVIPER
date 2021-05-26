//
//  Coordinator.swift
//  D&DCharManagerVIPER
//
//  Created by Egor on 23.05.2021.
//

import Foundation

class ApplicationCoordinator {
    
    private var router: Router
    private var factory = ControllersFactory()
    
    private var charListView: CharactersListController?
    
    init(router: Router) {
        self.router = router
    }
    
    func start() {
        runListFlow()
    }
    
    private func runListFlow() {
        charListView = factory.makeCharactersListController()
        
        router.push(charListView)
    }
    
}

