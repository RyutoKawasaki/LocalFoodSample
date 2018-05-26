//
//  MakeShioriViewController.swift
//  LocalFoodSample02
//
//  Created by Ryuton on 2018/05/04.
//  Copyright © 2018年 LikeLake. All rights reserved.
//

import UIKit

class MakeShioriViewController: UIViewController {

    @IBOutlet weak var shioriTitleLabel: UILabel!
    var selectedShioriTitle: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        shioriTitleLabel.text = selectedShioriTitle
        shioriTitleLabel.textAlignment = NSTextAlignment.center
        
        // #todo ナビゲーションバータイトル設定
        // #todo ステータスバー色設定
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    @IBAction func backButtonTapped(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
