//
//  TabBarController.swift
//  NotesPro
//
//  Created by Timur Baimukhambet on 02.08.2023.
//

import UIKit

class TabBarController: UITabBarController {

    override func loadView() {
        super.loadView()

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func setupViewControllers() {
        let mainVC = MainViewController()
        let libraryVC = LibraryViewController()
        mainVC.tabBarItem.title = "something"
        mainVC.tabBarItem.image = UIImage(systemName: "house.fill")
        libraryVC.tabBarItem.title = ""
        libraryVC.tabBarItem.image = UIImage(systemName: "archivebox.fill")
        
    }
    
    func setupAppearance() {
        let appearance = UITabBarAppearance()
        appearance.backgroundColor = .black
        tabBarController?.tabBar.standardAppearance = appearance
        tabBarController?.tabBar.tintColor = .white
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
