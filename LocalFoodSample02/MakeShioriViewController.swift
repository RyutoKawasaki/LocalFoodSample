//
//  MakeShioriViewController.swift
//  LocalFoodSample02
//
//  Created by Ryuton on 2018/05/04.
//  Copyright © 2018年 LikeLake. All rights reserved.
//

import UIKit

class MakeShioriViewController: UIViewController {

    var selectedShioriTitle = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        // ナビゲーションバータイトル設定
        navigationItem.title = appDelegate.createdOrSelectedShioriTitle
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    @IBAction func backButtonTapped(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
