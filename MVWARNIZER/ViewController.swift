//
//  ViewController.swift
//  MVWARNIZER
//
//  Created by Han on 6/29/18.
//  Copyright © 2018 Han. All rights reserved.
//

import UIKit
import ASExtendedCircularMenu

let TOP_SPACE: CGFloat = 60

class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, ASCircularButtonDelegate {

    @IBOutlet weak var menuButton: ASCircularMenuButton!
    @IBOutlet weak var movView: UIView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var galleryButton: UIButton!
    
    var imagePicker: UIImagePickerController!
    var buttonImages: [UIImage] = [#imageLiteral(resourceName: "trash_icon"), #imageLiteral(resourceName: "rotate_left"), #imageLiteral(resourceName: "share_icon"), #imageLiteral(resourceName: "rotate_right"), #imageLiteral(resourceName: "pencil_icon")]
    var originalImageView: UIImageView!
    var originalView: UIView!
    
    var rotationAmount: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        configureDynamicCircularMenuButton(button: menuButton, numberOfMenuItems: 5)
        menuButton.menuButtonSize = .small
        
    }

    func buttonForIndexAt(_ menuButton: ASCircularMenuButton, indexForButton: Int) -> UIButton {
        let button: UIButton = UIButton()
        button.setBackgroundImage(buttonImages[indexForButton], for: .normal)

        return button
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func onGetPhoto(_ sender: Any) {
        
        let alert = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
            self.openCamera()
        }))
        
        alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { _ in
//            self.openGallary()
        }))
        
        alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
        
        if let presenter = alert.popoverPresentationController {
            presenter.sourceView = galleryButton
        }
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func openCamera()
    {
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerControllerSourceType.camera))
        {
            imagePicker.sourceType = UIImagePickerControllerSourceType.camera
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }
        else
        {
            let alert  = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func openGallary()
    {
        imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        imagePicker.allowsEditing = true
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        movView.isHidden = true
        
        if originalView != nil{
            originalView.removeFromSuperview()
        }
        
        putImage(image: info[UIImagePickerControllerEditedImage] as! UIImage)
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    func putImage(image: UIImage){
        
        let imageWidth: CGFloat = image.size.width
        let imageHeight: CGFloat = image.size.height
        
        if imageHeight > imageWidth{
            
            originalView = UIView.init()
            originalImageView = UIImageView.init(image: image)
            
            let height: CGFloat = contentView.frame.height - TOP_SPACE
            let width: CGFloat = height * (imageWidth / imageHeight)
            
            originalView.frame = CGRect.init(x: (contentView.frame.width - imageWidth) / 2, y: contentView.frame.height - TOP_SPACE / 2, width: width, height: height)
            contentView.addSubview(originalView)
            
            originalImageView.frame = CGRect.init(x: 0, y: 0, width: originalView.frame.width, height: originalView.frame.height)
            originalView.addSubview(originalImageView)
            
            originalView.backgroundColor = UIColor.white
            
        }else{
            
            originalView = UIView.init()
            originalImageView = UIImageView.init(image: image)
            
            let height: CGFloat = contentView.frame.width * (imageHeight / imageWidth)
            let width: CGFloat = contentView.frame.width
            
            originalView.frame = CGRect.init(x: 0, y: (contentView.frame.height - height) / 2 , width: width, height: height)
            contentView.addSubview(originalView)
            
            originalImageView.frame = CGRect.init(x: 0, y: 0, width: originalView.frame.width, height: originalView.frame.height)
            originalView.addSubview(originalImageView)
            
            originalView.backgroundColor = UIColor.white
            
        }
        
    }
    
    func didClickOnCircularMenuButton(_ menuButton: ASCircularMenuButton, indexForButton: Int, button: UIButton) {
        
//        if indexForButton == 3{
//
//            rotationAmount += 1
//            originalView.transform = originalView.transform.rotated(by: CGFloat(M_PI_2))
//            setProperFrame(view: originalView)
//
//
//        }
        
    }
    
//    func setProperFrame(view: UIView){
//
//        let w: CGFloat = view.frame.width
//        let h: CGFloat = view.frame.height
//
//        if h > w{
//
//            let height: CGFloat = contentView.frame.height - TOP_SPACE
//            let width: CGFloat = height * (w / h)
//
//            view.frame = CGRect.init(x: (contentView.frame.width - width) / 2, y: contentView.frame.height - TOP_SPACE / 2, width: width, height: height)
//
//        }else{
//
//            let height: CGFloat = contentView.frame.width * (h / w)
//            let width: CGFloat = contentView.frame.width
//
//            view.frame = CGRect.init(x: 0, y: (contentView.frame.height - height) / 2 , width: width, height: height)
//
//        }
//
//    }
    
    
    
}

