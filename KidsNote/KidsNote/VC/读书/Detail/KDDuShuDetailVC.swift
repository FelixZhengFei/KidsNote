//
//  KDDuShuDetailVC.swift
//  KidsNote
//
//  Created by 郑强飞 on 2018/8/27.
//  Copyright © 2018年 郑强飞. All rights reserved.
//

import UIKit
import SDWebImage

class KDDuShuDetailVC: KNBaseVC {

    @IBOutlet weak var siImageView: UIImageView!
    @IBOutlet weak var middelCameraView: UIView!
    @IBOutlet weak var bottoCarmeaView: UIView!
    @IBOutlet weak var luyinView: UIView!
    var hasImage:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "静夜思"
        updateViews()
        siImageView.sd_setImage(with: URL(string: "http://i65.tinypic.com/wgzrww.jpg"), placeholderImage: UIImage(named: "header"))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func showTheVidioToWebView(_ sender: Any) {
        let vc = SMWebVC()
        vc.urlString  = "https://m.qbaobei.com/v/video_569.html"

        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func tokenPhotoButtonClicked(_ sender: Any) {
        openCammer()
    }
    
}

extension KDDuShuDetailVC:UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    fileprivate func updateViews() {
        middelCameraView.isHidden = hasImage
        bottoCarmeaView.isHidden = !hasImage
        bottoCarmeaView.isHidden = !hasImage
    }
    fileprivate func openCammer() {
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            let  cameraPicker = UIImagePickerController()
            cameraPicker.delegate = self
            cameraPicker.allowsEditing = true
            cameraPicker.sourceType = .camera
            //在需要的地方present出来
            self.present(cameraPicker, animated: true, completion: nil)
        } else {
            print("不支持拍照")
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        //获得照片
        let image:UIImage = info[UIImagePickerControllerEditedImage] as! UIImage
        siImageView.image = image
        hasImage = true
        self.dismiss(animated: true, completion: nil)
        updateViews()
    }
}
