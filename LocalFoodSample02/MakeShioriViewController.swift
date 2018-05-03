//
//  MakeShioriViewController.swift
//  LocalFoodSample02
//
//  Created by Ryuton on 2018/05/04.
//  Copyright © 2018年 LikeLake. All rights reserved.
//

import UIKit
import RealmSwift

class MakeShioriViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    @IBAction func backButtonTapped(_ sender: UIBarButtonItem) {
        
        let storyboard: UIStoryboard = self.storyboard!
        let nextView = storyboard.instantiateViewController(withIdentifier: "ShioriViewController")
        let navi = UINavigationController(rootViewController: nextView)
        // #todo アニメーションの設定
        // navi.modalTransitionStyle = .coverVertical
        self.present(navi, animated: true, completion: nil)
    }
    

}
