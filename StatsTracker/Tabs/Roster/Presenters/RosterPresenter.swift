//
//  RosterPresenter.swift
//  StatsTracker
//
//  Created by Rachel Anderson on 5/5/20.
//  Copyright © 2020 Rachel Anderson. All rights reserved.
//

import Foundation

protocol RosterPresenterDelegate: AnyObject {
    func addPressed()
    func goToPlayerPage(viewModel: PlayerViewModel)
}

class RosterPresenter: Presenter {
    
    //MARK: Properties
    weak var delegate: RosterPresenterDelegate?
    weak var vc: RosterViewController!
    var viewModel: RosterViewModel
    
    //MARK: Initialization
    init(vc: RosterViewController, delegate: RosterPresenterDelegate?) {
        self.vc = vc
        self.delegate = delegate
        self.viewModel = RosterViewModel()
    }
}

extension RosterPresenter: RosterPresenterProtocol {
    
    func onViewWillAppear() {
        vc.navigationItem.title = Constants.Titles.rosterTitle
    }
    
    func addPressed() {
        delegate?.addPressed()
    }
    
    func addPlayer(_ player: PlayerViewModel) {
        viewModel.cellViewModels[player.gender.rawValue].append(player)
        vc.updateWithViewModel(viewModel: viewModel)
    }
    
    func goToPlayerPage(viewModel: PlayerViewModel) {
        delegate?.goToPlayerPage(viewModel: viewModel)
    }
}
