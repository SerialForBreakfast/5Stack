//
//  Coordinator.swift
//  5Stack
//
//  Created by Joseph McCraw on 2/19/20.
//  Copyright © 2020 Joseph McCraw. All rights reserved.
//

import UIKit

protocol Coordinator {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    
    func start()
}
