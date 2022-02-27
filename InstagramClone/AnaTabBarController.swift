//
//  AnaTabBarController.swift
//  InstagramClone
//
//  Created by Mustafa on 22.02.2022.
//

import Foundation
import UIKit
import Firebase

class AnaTabBarController : UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        if Auth.auth().currentUser == nil {
            DispatchQueue.main.async {
                let oturumAcController = OturumAcController()
                let navController = UINavigationController(rootViewController: oturumAcController)
                navController.modalPresentationStyle = .fullScreen
                self.present(navController, animated: true, completion: nil)
            }
            return
        }
        gorunumuOlustur()
    }

    func gorunumuOlustur(){
        let anaNavController = navControllerOlustur(seciliOlmayanIcon: #imageLiteral(resourceName: "Ana_Ekran_Secili_Degil"), seciliIcon: #imageLiteral(resourceName: "Ana_Ekran_Secili"), rootViewController: KullaniciProfilController(collectionViewLayout: UICollectionViewFlowLayout()))
        let araNavController = navControllerOlustur(seciliOlmayanIcon: #imageLiteral(resourceName: "Ara_Secili_Degil"), seciliIcon: #imageLiteral(resourceName: "Ara_Secili"))
        let ekleNavController = navControllerOlustur(seciliOlmayanIcon: #imageLiteral(resourceName: "Ekle_Secili_Degil"), seciliIcon: #imageLiteral(resourceName: "Ekle_Secili_Degil"))
        let begeniNavController = navControllerOlustur(seciliOlmayanIcon: #imageLiteral(resourceName: "Begeni_Secili_Degil"), seciliIcon: #imageLiteral(resourceName: "Begeni_Secili"))


        let layout = UICollectionViewFlowLayout()
        let kullaniciProfilController =  KullaniciProfilController(collectionViewLayout: layout)
        let kullaniciProfilNavController = UINavigationController(rootViewController: kullaniciProfilController)
        kullaniciProfilNavController.tabBarItem.image = #imageLiteral(resourceName: "Profil")
        kullaniciProfilNavController.tabBarItem.selectedImage = #imageLiteral(resourceName: "Profil_Secili")
        tabBar.tintColor = .black


        viewControllers = [anaNavController, araNavController, ekleNavController,begeniNavController, kullaniciProfilNavController]

        guard let itemler = tabBar.items else { return }

        for item in itemler {
            item.imageInsets = UIEdgeInsets(top: 5, left: 0, bottom: -5, right: 0)
        }
    }

    fileprivate func navControllerOlustur(seciliOlmayanIcon: UIImage, seciliIcon: UIImage, rootViewController : UIViewController = UIViewController())-> UINavigationController {
        let rootController = rootViewController
        let navController = UINavigationController(rootViewController: rootController)
        navController.tabBarItem.image = seciliOlmayanIcon
        navController.tabBarItem.selectedImage = seciliIcon
        return navController
    }
}

extension AnaTabBarController : UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {

        guard let index = viewControllers?.firstIndex(of: viewController) else { return true }
        if index == 2 {
            let layout = UICollectionViewFlowLayout()

            let fotografSeciciContoller = FotografSeciciController(collectionViewLayout: layout)

            let navController = UINavigationController(rootViewController: fotografSeciciContoller)
            navController.modalPresentationStyle = .fullScreen
            present(navController, animated: true, completion: nil)
            return false

        }
        return true
    }
}
