//
//  BaseVC.swift
//  Demo
//
//  Created by Vivek Purohit on 08/02/21.
//

import UIKit

class BaseVC: UIViewController {
    override func viewDidLoad() {
        setupNavTheme()
    }
}
//MARK:- Navigation Setup
extension BaseVC {
    func setupNavTheme() {
        navigationController?.navigationBar.barTintColor = UIColor.cyan
    }
}
