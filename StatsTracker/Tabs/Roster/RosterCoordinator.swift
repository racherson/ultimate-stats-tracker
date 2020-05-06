//
//  RosterCoordinator.swift
//  StatsTracker
//
//  Created by Rachel Anderson on 4/9/20.
//  Copyright © 2020 Rachel Anderson. All rights reserved.
//

import UIKit

class RosterCoordinator: Coordinator {
    
    //MARK: Properties
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    var rootVC: RosterViewController!

    //MARK: Initialization
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        self.setLargeTitles()
        
        // Create new view controller
        let vc = RosterViewController.instantiate(.roster)
        vc.presenter = RosterPresenter(vc: vc, delegate: self)
        
        // Create tab item
        vc.tabBarItem = UITabBarItem(title: Constants.Titles.rosterTitle, image: UIImage(systemName: "person.3"), tag: 1)
        rootVC = vc
        
        navigationController.pushViewController(vc, animated: true)
    }
}

extension RosterCoordinator: RosterPresenterDelegate {
    func addPressed() {
        let vc = NewPlayerViewController.instantiate(.roster)
        vc.presenter = NewPlayerPresenter(vc: vc, delegate: self)
        let navController = UINavigationController(rootViewController: vc)
        navigationController.present(navController, animated: true, completion: nil)
    }
    
    func goToPlayerPage(viewModel: PlayerViewModel) {
        let vc = PlayerDetailViewController.instantiate(.roster)
        vc.presenter = PlayerDetailPresenter(vc: vc, delegate: self, viewModel: viewModel)
        navigationController.pushViewController(vc, animated: true)
    }
}

extension RosterCoordinator: NewPlayerPresenterDelegate {
    func cancelPressed() {
        navigationController.dismiss(animated: true, completion: nil)
    }
    
    func savePressed(player: PlayerViewModel) {
        rootVC.presenter.addPlayer(player)
        navigationController.dismiss(animated: true, completion: nil)
    }
}

extension RosterCoordinator: PlayerDetailPresenterDelegate {
}
