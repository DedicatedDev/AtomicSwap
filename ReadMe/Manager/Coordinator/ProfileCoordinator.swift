//
//  ProfileCoordinator.swift
//  PointGenie
//
//  Created by FreeBird on 10/24/20.
//  Copyright © 2020 azcona enterprise. All rights reserved.
//

import UIKit
class ProfileCoordinator: Coordinator {
    
    weak var parentCoordinator:MainCoordinator?
    var childCoordinator: [Coordinator] = []
    var navigationController: UINavigationController
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        // we'll add code here
        let vc = ProfileVC()
        vc.coordinator = self
        vc.tabBarItem = UITabBarItem(title: nil, image: R.image.profileIcon(), tag: 1)
        navigationController.pushViewController(vc, animated: false)
    }
    
    func openDetailedPost(with questionType:QuestionType){
        let vc = DetailedPostRenderVC()
        vc.data = questionType
        //navigationController.isNavigationBarHidden = true
        navigationController.pushViewController(vc, animated: true)
        
    }
}

