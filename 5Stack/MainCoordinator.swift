//
//  MainCoordinator.swift
//  5Stack
//
//  Created by Joseph McCraw on 2/19/20.
//  Copyright © 2020 Joseph McCraw. All rights reserved.
//

import UIKit

class MainCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = FriendListVC.instantiate()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: false)
    }
    
    func editFriend(friend: Friend) {
        let vc = FriendEditVC.instantiate()
        vc.coordinator = self
        vc.friend = friend
        navigationController.pushViewController(vc, animated: true)
    }
    
    func updateFriend(friend: Friend) {
        guard let vc = navigationController.viewControllers.first as? FriendListVC else { return }
        print(vc.friends)
        vc.updateFriend(friend: friend)
    }
}
