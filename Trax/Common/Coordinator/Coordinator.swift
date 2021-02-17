//
//  Coordinator.swift
//  Trax
//
//  Created by Adar Tzeiri on 16/02/2021.
//

import UIKit

protocol Coordinator: AnyObject {
    var childCoordinators : [Coordinator] { get set }
    var navigationContoller: UINavigationController { get set }
    
    func start()
}
