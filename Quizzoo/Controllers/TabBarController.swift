//
//  TabBarController.swift
//  Quizzoo
//
//  Created by Adrijan Omicevic on 16/06/2020.
//  Copyright © 2020 OmiApp. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
       
        let nav1 = generateNavController(vc: ViewController(viewModel: QuizViewModel()), title: "Quiz", image: #imageLiteral(resourceName: "quizes"))
        let nav2 = generateNavController(vc: SearchController(viewModel: QuizViewModel()), title: "Search", image: #imageLiteral(resourceName: "quizes"))
        let nav3 = generateNavController(vc: SettingsViewController(), title: "Settings", image: #imageLiteral(resourceName: "quizes"))
    
        viewControllers = [nav1,nav2,nav3]
    }

    override func viewWillAppear(_ animated: Bool) {
          navigationController?.isNavigationBarHidden  = true
      }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
    }
    
    func logoutFromTab() {
        
    }

    
    func generateNavController(vc : UIViewController, title: String, image: UIImage) -> UINavigationController {
        let navController = UINavigationController(rootViewController: vc)
        navController.title = title
        navController.tabBarItem.image = image
        return navController
    }
}
