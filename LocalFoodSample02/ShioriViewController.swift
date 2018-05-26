//
//  ShioriViewController.swift
//  LocalFoodSample02
//
//  Created by Ryuton on 2018/05/04.
//  Copyright © 2018年 LikeLake. All rights reserved.
//

import UIKit
import RealmSwift

class ShioriViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var ShioriCollectionView: UICollectionView!
    var shioriItem: Results<Shiori>!
    var selectedLabel = ""
    var createdShioriTitle = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 永続化されているデータを取りだす
        do {
            let realm = try Realm()
            shioriItem = realm.objects(Shiori.self)
            ShioriCollectionView.reloadData()
        } catch {
            
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // 画面が表示される際にtableViewのデータを再読み込みする
        ShioriCollectionView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    // セルが表示されるときに呼ばれる処理 ひとつのセルを描画する毎に呼ばれる
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ShioriListCustomCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath as IndexPath) as! ShioriListCustomCell
        
        // todoItemに代入されたデータをobject:NSArrayに代入
        let object = shioriItem[indexPath.row]
        
        //cellのtextLabelのtextにobjectのtitleプロパティを代入
        cell.shioriLabel.text = object.shioriTitle
        
        // #todo 表紙画像設定
        cell.shioriImage.image = UIImage(named: "smile.png")
        
        return cell
    }
    
    // セクションの数
    // #todo セクション追加 作成共有したしおり、Finishedしおり
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    // 表示するセルの数
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return shioriItem.count
    }
    
    // セルタップで画面遷移 ----------------------------
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // 選択されたセルのしおりタイトル取得
        selectedLabel = shioriItem[indexPath.row].shioriTitle
        print("タップされたしおりタイトル = \(selectedLabel)")
        // #todo [indexPath.row] から画像名を探し、UImage を設定
        
        if selectedLabel != "" {
            // 遷移先にしおりタイトルを渡す
            let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.createdOrSelectedShioriTitle = selectedLabel
            performSegue(withIdentifier: "toMakeShioriViewController",sender: nil)
            
        }
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
//        // セルタップ時のSegue準備
//        if (segue.identifier == "toMakeShioriViewController") {
//            let subVC: MakeShioriViewController = (segue.destination as? MakeShioriViewController)!
//
//            // #todo SubViewController のselectedImgに選択された画像を設定する
//            subVC.selectedShioriTitle = selectedLabel
//        }
//        // しおり作成時のSegue準備
//        if (segue.identifier == "toMakeShioriViewControllerFromButton") {
//            let subVC: MakeShioriViewController = (segue.destination as? MakeShioriViewController)!
//            subVC.selectedShioriTitle = createdShioriTitle
//            // #todo SubViewController のselectedImgに選択された画像を設定する
//        }
//    }
    
    // #todo EditButtonでshiori削除、編集
    // TableViewのCellの削除を行った際に、Realmに保存したデータを削除する
//    func collectionView(_ collectionView: UICollectionView, commit editingStyle: UICollectionViewCellEditingStyle, forRowAt indexPath: IndexPath) {
//
//
//        if editingStyle == UITableViewCellEditingStyle.delete {
//            do {
//                let realm = try Realm()
//                try realm.write {
//                    realm.delete(self.todoItem[indexPath.row])
//                }
//                tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.fade)
//            } catch {
//            }
//            tableView.reloadData()
//        }
//    }

    
    @IBAction func plusButtonTapped(_ sender: AnyObject) {
        // しおりタイトル入力アラート表示
        showShioriTitleInputAlert()
    }
    
    // しおり作成時のタイトル入力
    func showShioriTitleInputAlert() {
        
        let alert = UIAlertController(title: "新しいしおり", message: "このしおりの名前を入力してください。", preferredStyle: .alert)
        
        // OKボタンの設定
        let okAction = UIAlertAction(title: "OK", style: .default, handler: { (action:UIAlertAction!) -> Void in
            // OKを押した時入力されていたテキストを表示
            if let textFields = alert.textFields {
                
                // アラートに含まれるすべてのテキストフィールドを調べる
                for textField in textFields {
                    // #todo しおりの名前保存
                    let newShiori = Shiori()
                    
                    // textFieldに入力したデータをnewTodoのtitleに代入
                    // Shioriクラスのプロパティ
                    newShiori.shioriTitle = textField.text!
                    
                    // 上記で代入したテキストデータを永続化するための処理
                    do {
                        let realm = try Realm()
                        try realm.write({ () -> Void in
                            realm.add(newShiori)
                            print("Shiori Saved")
                        })
                    } catch {
                        print("Save is Faild")
                    }
                    
                    print("しおりの名前 = \(textField.text!)")
                    self.createdShioriTitle = textField.text!
                }
            }
            
            // 画面遷移
            // 遷移先に値渡す
            let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.createdOrSelectedShioriTitle = self.createdShioriTitle
            self.performSegue(withIdentifier: "toMakeShioriViewController",sender: nil)
        })
        
        // キャンセルボタンの設定
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        // OKボタン追加
        alert.addAction(okAction)
        // 最初はOKボタン無効化しておく
        okAction.isEnabled = false
        // キャンセルボタン追加
        alert.addAction(cancelAction)
        
        
        // Add a text field to the alert
        alert.addTextField { (textField) in
            
            textField.placeholder = "しおりの名前"
            // キーボードを自動的に出す
            textField.becomeFirstResponder()
            
            // Observe the UITextFieldTextDidChange notification to be notified in the below block when text is changed
            NotificationCenter.default.addObserver(forName: .UITextFieldTextDidChange, object: textField, queue: OperationQueue.main, using: {_ in
                
                // Being in this block means that something fired the UITextFieldTextDidChange notification.
                    
                // Access the textField object from alertController.addTextField(configurationHandler:) above and get the character count of its non whitespace characters
                let textCount = textField.text?.trimmingCharacters(in: .whitespacesAndNewlines).count ?? 0
                let textIsNotEmpty = textCount > 0
                
                // If the text contains non whitespace characters, enable the OK Button
                okAction.isEnabled = textIsNotEmpty
            })
        }
        
        alert.view.setNeedsLayout() // シミュレータの種類によっては、これがないと警告が発生
        
        // アラートを画面に表示
        self.present(alert, animated: true, completion: nil)
    }
    
}
