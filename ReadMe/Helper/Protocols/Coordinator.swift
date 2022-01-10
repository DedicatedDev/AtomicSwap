//
//  Coordinator.swift
//  PointGenie
//
//  Created by FreeBird on 10/24/20.
//  Copyright © 2020 azcona enterprise. All rights reserved.
//

import UIKit
protocol Coordinator {
    var childCoordinator:[Coordinator]{get set}
    var navigationController:UINavigationController{get set}
    func start()
}


