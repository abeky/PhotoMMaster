//
//  ViewController.swift
//  PhotoMater
//
//  Created by 阿部一真 on 2018/04/16.
//  Copyright © 2018年 阿部一真. All rights reserved.
//

import UIKit
import Accounts

class ViewController: UIViewController, UINavigationControllerDelegate ,UIImagePickerControllerDelegate {
    @IBOutlet var photoImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onTappedCameraButton() {
        presentPickerController(sourceType: .camera)
    }
    
    @IBAction func onTappedAlbumButton() {
        presentPickerController(sourceType: .photoLibrary)
    }
    
    @IBAction func onTappedTextButton() {
        if photoImageView.image != nil {
            photoImageView.image = drawText(image: photoImageView.image!)
        }else {
            print("画像がありません")
        }
    }
    
    @IBAction func onTappedIllustButton() {
        if photoImageView.image != nil {
            photoImageView.image = drawMaskImage(image: photoImageView.image!)
        }else {
            print("画像がありません")
        }
    }
    
    @IBAction func onTappedUpLoadButton() {
        if photoImageView.image != nil {
            //共有するアイテムを設定
            let activityIndicator = UIActivityViewController(
                activityItems: [photoImageView.image!, "#PhotoMaster"],
                applicationActivities: nil)
            self.present(activityIndicator, animated: true, completion: nil)
        }else {
            print("画像がありません")
        }
    }
    
    func presentPickerController(sourceType: UIImagePickerControllerSourceType) {
        if UIImagePickerController.isSourceTypeAvailable(sourceType) {
            let picker = UIImagePickerController()
            picker.sourceType = sourceType
            picker.delegate = self
            self.present(picker, animated: true, completion: nil)
        }
    }
    
    //写真が選択された時に呼ばれるメソッド
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        self.dismiss(animated: true, completion: nil)
        
        //画像を出力
        photoImageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
    }
    
    func drawText(image: UIImage) -> UIImage {
        //テキスト内容の設定
        let text = "Life is Tech!"
        
        //textFontAttributes: 文字の特性[フォントとサイズ、カラー、スタイル]の設定
        let textAttributes = [
            NSAttributedStringKey.font: UIFont(name: "Arial", size: 120)!,
            NSAttributedStringKey.foregroundColor: UIColor.red
        ]
        
        //グラフィクスコンテキストの生成と編集開始
        UIGraphicsBeginImageContext(image.size)
        
        //組み込んだ写真を書き出す
        image.draw(in: CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height))
        
        //定義
        let margin: CGFloat = 5.0 //余白
        let textRect = CGRect(x: margin, y: margin, width: image.size.width - margin, height: image.size.height - margin)
        
        text.draw(in: textRect, withAttributes: textAttributes)
        
        //グラフィクスコンテキストの画像の生成
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        
        //グラフィクスコンテキストの編集終了
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
    func drawMaskImage(image: UIImage) -> UIImage {
        let maskImage = UIImage(named: "ahirudayo")!
        
        UIGraphicsBeginImageContext(image.size)
        
        image.draw(in: CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height))
        
        let margin: CGFloat = 50.0
        
        let maskRect = CGRect(x: image.size.width - maskImage.size.width - margin, y: image.size.height - maskImage.size.height - margin, width: maskImage.size.width, height: maskImage.size.height)
        
        maskImage.draw(in: maskRect)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
}

