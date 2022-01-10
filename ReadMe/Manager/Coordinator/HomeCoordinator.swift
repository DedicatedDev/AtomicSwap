//
//  HomeCoordinator.swift
//  PointGenie
//
//  Created by FreeBird on 10/24/20.
//  Copyright © 2020 azcona enterprise. All rights reserved.
//

import UIKit
import Rswift
class HomeCoordinator: NSObject, Coordinator,UINavigationControllerDelegate {
    weak var parentCoordinator:MainCoordinator?
    var childCoordinator: [Coordinator] = []
    var navigationController: UINavigationController
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        // we'll add code here
        navigationController.delegate = self
        let vc = HomeVC()
        vc.coordinator = self
        vc.tabBarItem = UITabBarItem(title: nil, image: R.image.homeOutline(), tag: 0)
        navigationController.pushViewController(vc, animated: false)
    }
    
    func explorComment(){
//        let vc = UIViewController()
//        vc.coordinator = self
//        navigationController.pushViewController(vc, animated: true)
    }
    
    func openOthersProfile(){
        let vc = ProfileVC()
        vc.currentPageType = .other
        vc.coordinatorWithHome = self
      //  addBackBtn()
        navigationController.isNavigationBarHidden = false
        navigationController.push(viewController: vc)
      //  navigationController.pushViewController(vc, animated: true)
    }
    

    
    @objc private func popVC(){
        navigationController.setNavigationBarHidden(true, animated: false)
        navigationController.popViewController(animated: true)
    }
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        // Read the view controller we’re moving from.
        guard let fromViewController = navigationController.transitionCoordinator?.viewController(forKey: .from) else {
            return
        }

        // Check whether our view controller array already contains that view controller. If it does it means we’re pushing a different view controller on top rather than popping it, so exit.
        if navigationController.viewControllers.contains(fromViewController) {
            return
        }

        // We’re still here – it means we’re popping the view controller, so we can check whether it’s a buy view controller
        if let vc = fromViewController as? ProfileVC {
            // We're popping a buy view controller; end its coordinator
        
        }
        
    
    }
}
