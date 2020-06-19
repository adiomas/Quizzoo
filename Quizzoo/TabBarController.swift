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

        let nav1 = generateNavController(vc: ViewController(), title: "QUIZ", image: #imageLiteral(resourceName: "quizes"))
        let nav2 = generateNavController(vc: ViewController(), title: "Second", image: #imageLiteral(resourceName: "quizes"))
        let nav3 = generateNavController(vc: ViewController(), title: "Third", image: #imageLiteral(resourceName: "quizes"))
        
        UINavigationBar.appearance().prefersLargeTitles = true
        viewControllers = [nav1,nav2,nav3]
        
       
    }
    
    func generateNavController(vc : UIViewController, title: String, image: UIImage) -> UINavigationController {
        vc.navigationItem.title = title
        let navController = UINavigationController(rootViewController: vc)
        navController.title = title
        navController.tabBarItem.image = image
        return navController
    }
    
    

  

}
