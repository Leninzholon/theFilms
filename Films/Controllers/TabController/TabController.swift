//
//  TapController.swift
//  Films
//
//  Created by apple on 13.10.2022.
//

import UIKit


class TabController: UITabBarController, UITabBarControllerDelegate {
//MARK: - Paroperties
    
//MARK: - lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupControllers()
        self.delegate = self
    }
    
    //MARK: - helpers funcs
    fileprivate func setupControllers() {
        tabBar.tintColor = .white
        let navMainViewController = teamplayNavController(rootViewController: MainViewController(collectionViewLayout: UICollectionViewFlowLayout()), image: UIImage(systemName: "film.fill"), slectImage: UIImage(systemName: "film.fill"))
        let navFavoriteController = teamplayNavController(rootViewController: FavoriteFilmsController(), image: UIImage(systemName: "heart"), slectImage: UIImage(systemName: "heart.fill"))
        tabBar.backgroundColor = .white
        tabBar.tintColor = .black
        
        viewControllers = [
            navMainViewController,
            navFavoriteController
        ]
    }
//MARK: - helper func
    private func teamplayNavController(rootViewController: UIViewController = UIViewController(),
                                       image: UIImage?, slectImage: UIImage?) -> UINavigationController{
        let controller = rootViewController
        let navController = UINavigationController(rootViewController: controller)
        navController.tabBarItem.image = image
        navController.tabBarItem.selectedImage = slectImage
        return navController
    }
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        if viewController == self.viewControllers?[0] {
              print("First tab")
            
            NotificationCenter.default.post(name: .internetDown, object: nil, userInfo: nil)

          }

}

}
