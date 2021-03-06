//
//  CallLinePresenterTests.swift
//  StatsTrackerTests
//
//  Created by Rachel Anderson on 5/17/20.
//  Copyright © 2020 Rachel Anderson. All rights reserved.
//

import XCTest
import ViewControllerPresentationSpy
@testable import StatsTracker

class CallLinePresenterTests: XCTestCase {
    
    var sut: CallLinePresenter!
    var vc: CallLineViewControllerSpy!
    var vm: CallLineCellViewModelSpy!
    
    private var playPointCalled: Int = 0
    
    override func setUp() {
        vc = CallLineViewControllerSpy()
        vm = CallLineCellViewModelSpy()
        sut = CallLinePresenter(vc: vc, delegate: self, vm: vm)
        vc.presenter = sut
        super.setUp()
    }
    
    override func tearDown() {
        sut = nil
        vc = nil
        vm = nil
        super.tearDown()
    }
    
    func testOnViewWillAppear() throws {
        XCTAssertEqual(0, vc.updateVMCalled)
        // When
        sut.onViewWillAppear()
        // Then
        XCTAssertEqual(1, vc.updateVMCalled)
    }
    
    func testStartPoint_fullLine() throws {
        XCTAssertEqual(0, vm.fullLineCalled)
        // Given
        vm.fullLineBool = true
        // When
        sut.startPoint()
        // Then
        XCTAssertEqual(1, vm.fullLineCalled)
    }
    
    func testStartPoint_notFullLine() throws {
        let alertVerifier = AlertVerifier()
        
        // Given
        vm.fullLineBool = false
        // When
        sut.startPoint()
        // Then
        alertVerifier.verify(
            title: Constants.Alerts.startGameTitle,
            message: Constants.Alerts.startGameAlert,
            animated: true,
            actions: [
                .destructive(TestConstants.Alerts.cancel),
                .default(TestConstants.Alerts.confirm),
            ],
            presentingViewController: vc
        )
    }
    
    func testExecutingActionForConfirmButton_shouldStartPoint() throws {
        let alertVerifier = AlertVerifier()
        XCTAssertEqual(0, playPointCalled)
        XCTAssertEqual(0, vm.addPointsCalled)
        
        // Given
        vm.fullLineBool = false
        // When
        sut.startPoint()
        // When
        try alertVerifier.executeAction(forButton: TestConstants.Alerts.confirm)
        // Then
        XCTAssertEqual(1, playPointCalled)
        XCTAssertEqual(1, vm.addPointsCalled)
    }
    
    func testSelectPlayer() throws {
        XCTAssertEqual(0, vm.selectPlayerCalled)
        // Given
        let indexPath = IndexPath(row: 0, section: 1)
        // When
        let _ = sut.selectPlayer(at: indexPath)
        // Then
        XCTAssertEqual(1, vm.selectPlayerCalled)
    }
    
    func testEndGame() throws {
        XCTAssertEqual(0, vm.endGameCalled)
        // When
        sut.endGame()
        // Then
        XCTAssertEqual(1, vm.endGameCalled)
    }
}

//MARK: CallLinePresenterDelegate
extension CallLinePresenterTests: CallLinePresenterDelegate {
    func playPoint() {
        playPointCalled += 1
    }
}

//MARK: CallLineCellViewModelDelegate
extension CallLinePresenterTests: CallLineCellViewModelDelegate {
    func endGame(items: [[PlayerViewModel]]) { }
}

//MARK: CallLineViewControllerSpy
class CallLineViewControllerSpy: CallLineViewController {
    
    var updateVMCalled: Int = 0
    
    override func updateWithViewModel(vm: CallLineCellViewModelProtocol) {
        updateVMCalled += 1
    }
}

//MARK: CallLineCellViewModelSpy
class CallLineCellViewModelSpy: NSObject, CallLineCellViewModelProtocol {
    var selectedPlayers: [PlayerViewModel] = []
    
    var fullLineBool = false
    var fullLineCalled: Int = 0
    var selectPlayerCalled: Int = 0
    var endGameCalled: Int = 0
    var addPointsCalled: Int = 0
    var clearLineCalled: Int = 0
    
    func fullLine() -> Bool {
        fullLineCalled += 1
        return fullLineBool
    }
    
    func selectPlayer(at indexPath: IndexPath) -> IndexPath? {
        selectPlayerCalled += 1
        return indexPath
    }
    
    func endGame() {
        endGameCalled += 1
    }
    
    func addPointsToPlayers() {
        addPointsCalled += 1
    }
    
    func clearLine() {
        clearLineCalled += 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
}
