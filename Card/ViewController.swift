//
//  ViewController.swift
//  Card
//
//  Created by 原田悠嗣 on 2019/08/10.
//  Copyright © 2019 原田悠嗣. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // viewの動作をコントロールする
    @IBOutlet weak var baseCard: UIView!
    // スワイプ中にgood or bad の表示
    @IBOutlet weak var likeImage: UIImageView!
    // ユーザーカード
    @IBOutlet weak var person1: UIView!
    @IBOutlet weak var image1: UIImageView!
    @IBOutlet weak var personName1: UILabel!
    @IBOutlet weak var personJob1: UILabel!
    @IBOutlet weak var personOrigin1: UILabel!
    
    @IBOutlet weak var person2: UIView!
    @IBOutlet weak var image2: UIImageView!
    @IBOutlet weak var personName2: UILabel!
    @IBOutlet weak var personJob2: UILabel!
    @IBOutlet weak var personOrigin2: UILabel!
    
    // ベースカードの中心
    var centerOfCard: CGPoint!
    // ユーザーカードの配列
    var personList: [UIView] = []
    // どちらのビュー表示させるか
    var selectedCardCount: Int = 0
    // 次に表示させるユーザーリストの番号
    var nextShowViewCount: Int = 2
    //今表示されているユーザーリストの番号
    var showViewCount: Int = 0
    
    
    // ユーザーリスト
    let userList: [UserData] = [
        
        UserData(name: "津田梅子", image: #imageLiteral(resourceName: "津田梅子"), job: "教師", homeTown: "千葉", backColor: #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)),
        UserData(name: "ジョージワシントン", image: #imageLiteral(resourceName: "ジョージワシントン"), job: "大統領", homeTown: "アメリカ", backColor: #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)),
        UserData(name: "ガリレオガリレイ", image: #imageLiteral(resourceName: "ガリレオガリレイ"), job: "物理学者", homeTown: "イタリア", backColor: #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)),
        UserData(name: "板垣退助", image: #imageLiteral(resourceName: "板垣退助"), job: "議員", homeTown: "高知", backColor: #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)),
        UserData(name: "ジョン万次郎", image: #imageLiteral(resourceName: "ジョン万次郎"), job: "冒険家", homeTown: "アメリカ", backColor: #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1))
    ]
    // 「いいね」をされた名前の配列
    var likedName: [String] = []
    
    // viewのレイアウト処理が完了した時に呼ばれる
    override func viewDidLayoutSubviews() {
        // ベースカードの中心を代入
        centerOfCard = baseCard.center
    }
    
    // ロード完了時に呼ばれる
    override func viewDidLoad() {
        super.viewDidLoad()
        personList.append(person1)
        personList.append(person2)
    }
    
    // セグエによる遷移前に呼ばれる
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "ToLikedList" {
            let vc = segue.destination as! LikedListTableViewController
            // LikedListTableViewControllerのlikedName(左)にViewCountrollewのLikedName(右)を代入
            vc.likedName = likedName
        }
    }
    
    // 完全に遷移が行われ、スクリーン上からViewControllerが表示されなくなったときに呼ばれる
    override func viewDidDisappear(_ animated: Bool) {
        // カウント初期化
        selectedCardCount = 0
        showViewCount = 0
        nextShowViewCount = 2
        // リストの初期化
        likedName = []
        // ビューを整理する
        self.view.sendSubviewToBack(person2)
        // alpha値を戻す処理
        person1.alpha = 1
        person2.alpha = 2
        
        // 2枚のビュー初期化
        // 一人目出す
        checkUserCard(showViewNumber: 0)
        // 二枚目を出すようにする
        selectedCardCount = 1
        // 2人目出す
        checkUserCard(showViewNumber: 1)
        // カウント元に戻す
        selectedCardCount = 0
    }
    // ベースカードを元に戻す
    func resetCard() {
        // 位置を戻す
        baseCard.center = centerOfCard
        // 角度を戻す
        baseCard.transform = .identity
    }
    
    // ユーザーカードを次に進める処理
    func nextUserView() {
        // 後ろに持ってく
        self.view.sendSubviewToBack(personList[selectedCardCount])
        // 真ん中に戻す
        personList[selectedCardCount].center = centerOfCard
        personList[selectedCardCount].transform = .identity
        
        // ビュー全員写したら、真っ白にする
        if nextShowViewCount < userList.count {
            checkUserCard(showViewNumber: nextShowViewCount)
        } else {
            // 背面のビューを見えなくする
            person2.alpha = 0
        }
        // 次のカードいく
        nextShowViewCount += 1
        showViewCount += 1
        
        if showViewCount >= userList.count {
            person1.alpha = 0
            // 遷移の処理
            performSegue(withIdentifier: "ToLikedList", sender: self)
        }
        selectedCardCount = showViewCount % 2
    }
    
    func checkUserCard(showViewNumber: Int) {
        // 表示されているカードの名前を保管
        let user = userList[showViewNumber]
        // 表示するビューを管理する
        if selectedCardCount == 0 {
            // ビューの背景の色
            person1.backgroundColor = user.backColor
            // ラベルに名前を表示させる
            personName1.text = user.name
            // ラベルに職業を表示させる
            personJob1.text = user.job
            // ラベルに出身地を表示させる
            personOrigin1.text = user.homeTown
            // 画像を表示させる
            image1.image = user.image
        } else {
            // ビューの背景に色をつける
            person2.backgroundColor = user.backColor
            // ラベルに名前を表示させる
            personName2.text = user.name
            // ラベルに職業を表示させる
            personJob2.text = user.job
            // ラベルに出身地を表示させる
            personOrigin2.text = user.homeTown
            // 画像を表示させる
            image2.image = user.image
        }
    }
    func farCard(distance: CGFloat, button: UIButton?) {
        UIView.animate(withDuration: 0.5, animations: {
            // ユーザーカードを左にとばす
            // X座標をdistance分飛ばす
            self.personList[self.selectedCardCount].center = CGPoint(x: self.personList[self.selectedCardCount].center.x + distance, y :self.personList[self.selectedCardCount].center.y)
        })
        
        // ボタンかスワイプかを判断させる
        if button != nil {
            // ボタンを使えなくする(連打防止)
            button?.isEnabled = false
            // 0.5秒のdelayをかける
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                self.nextUserView()
                button?.isEnabled = true
            })
            
        } else {
            // 次の人物を写す
            nextUserView()
        }
        // ベースカードを元に戻す
        resetCard()
    }
    
    
    // スワイプ処理
    @IBAction func swipeCard(_ sender: UIPanGestureRecognizer) {
        
        // ベースカード
        let card = sender.view!
        // 動いた距離
        let point = sender.translation(in: view)
        // 取得できた距離をcard.centerに加算
        card.center = CGPoint(x: card.center.x + point.x, y: card.center.y + point.y)
        // ユーザーカードにも同じ動きをさせる
        personList[selectedCardCount].center = CGPoint(x: card.center.x + point.x, y:card.center.y + point.y)
        // 元々の位置と移動先との差
        let xfromCenter = card.center.x - view.center.x
        // 角度をつける処理
        card.transform = CGAffineTransform(rotationAngle: xfromCenter / (view.frame.width / 2) * -0.785)
        // ユーザーカードに角度をつける
        personList[selectedCardCount].transform = CGAffineTransform(rotationAngle: xfromCenter / (view.frame.width / 2) * -0.785)
        
        // likeImageの表示のコントロール
        if xfromCenter > 0 {
            // goodを表示
            likeImage.image = #imageLiteral(resourceName: "いいね")
            likeImage.isHidden = false
        } else if xfromCenter < 0 {
            // badを表示
            likeImage.image = #imageLiteral(resourceName: "よくないね")
            likeImage.isHidden = false
        }
        
        // 元の位置に戻す処理
        if sender.state == UIGestureRecognizer.State.ended {
            
            if card.center.x < 50 {
                // 左に大きくスワイプしたときの処理
                farCard(distance: -500, button: nil)
                // likeImageを隠す
                likeImage.isHidden = true
            } else if card.center.x > self.view.frame.width - 50 {
                // likeImageを隠す
                likeImage.isHidden = true
                // いいねリストに追加
                likedName.append(userList[showViewCount].name)
                // 右に大きくスワイプしたときの処理
                farCard(distance: 500, button: nil)
            } else {
                // アニメーションをつける
                UIView.animate(withDuration: 0.5, animations: {
                    // ユーザーカードを元の位置に戻す
                    self.personList[self.selectedCardCount].center = self.centerOfCard
                    // ユーザーカードの角度を元の位置に戻す
                    self.personList[self.selectedCardCount].transform = .identity
                    // ベースカードの角度と位置を戻す
                    self.resetCard()
                    // likeImageを隠す
                    self.likeImage.isHidden = true
                })
            }
        }
    }
    
    // よくないねボタン
    @IBAction func dislikeButtonTapped(_ sender: UIButton) {
        // カードバイバイ  左
        farCard(distance: -500, button: sender)
    }
    // いいねボタン
    @IBAction func likeButtonTaped(_ sender: UIButton) {
        sender.isEnabled = false
        // いいねリストに追加
        likedName.append(userList[showViewCount].name)
        // カードバイバイ　右
        farCard(distance: 500, button: sender)
    }
}
