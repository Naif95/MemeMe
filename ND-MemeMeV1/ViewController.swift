//
//  ViewController.swift
//  ND-MemeMeV1
//
//  Created by Naif on 01/10/2019.
//  Copyright © 2019 Udacity. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var toolBar: UIToolbar!
    @IBOutlet weak var camButton: UIBarButtonItem!
    @IBOutlet weak var imagePickerView: UIImageView!
    @IBOutlet weak var topText: UITextField!
    @IBOutlet weak var bottomText: UITextField!
    @IBOutlet weak var navBar: UINavigationBar!
    
    var meme:  Meme!
    
    struct Meme {
        let topText: String
        let bottmText: String
        let originalImage: UIImage
        let memedImage: UIImage
    }
    
    
    let memeTextAttributes: [NSAttributedString.Key: Any] = [
        .strokeColor: UIColor.black,
        .foregroundColor: UIColor.white,
        .font: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        .strokeWidth:  -4.0
    ]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        config(textField: topText, text: "TOP")
        config(textField: bottomText, text: "BOTTOM")
    }
    
    func config(textField: UITextField, text: String)
    {
        textField.delegate = self
        textField.text = text
        textField.defaultTextAttributes = memeTextAttributes
        textField.textAlignment = .center
        textField.backgroundColor = .clear
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        camButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        navBar.isHidden = true
        super.viewWillAppear(animated)
        subscribeToKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }
    
    
    func openImagePicker (_ sourceType: UIImagePickerController.SourceType)
    {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = sourceType
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func pickImageFromAlbum(_ sender: Any) {
        
        openImagePicker(.photoLibrary)
    }
    
    @IBAction func pickAnImageFromCamera(_ sender: Any) {
        openImagePicker(.camera)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            imagePickerView.image = image
            imagePickerView.contentMode = .scaleAspectFit
            navBar.isHidden = false
        }
        dismiss(animated: true, completion: nil)
    }
    
    func subscribeToKeyboardNotifications() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(_ notification:Notification) {
        
        if bottomText.isEditing {
            view.frame.origin.y -= getKeyboardHeight(notification)
        }
    }
    
    @objc func keyboardWillHide(_ notification:Notification) {
        
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.cgRectValue.height
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true;
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.text == "TOP" || textField.text == "BOTTOM"   {
            textField.text = nil
        }
    }
    
    func generateMemedImage() -> UIImage {
        
        hideToolBars(true)
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        
        hideToolBars(false)
        
        
        return memedImage
    }
    
    func hideToolBars (_ isHidden: Bool)
    {
        navBar.isHidden = isHidden
        toolBar.isHidden = isHidden
    }
    
    func save(memedImage: UIImage) {
        let meme = Meme(topText: topText.text!, bottmText: bottomText.text!, originalImage: imagePickerView.image!, memedImage: memedImage)
        self.meme = meme
    }
    
    @IBAction func shareButton(_ sender: Any) {
        
        
        let image = generateMemedImage()
        let controller = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        controller.popoverPresentationController?.sourceView = self.view
        controller.completionWithItemsHandler = { (activity, success, items, error) in
            if success {
                self.save(memedImage: image)
            }
        }
        present(controller, animated: true, completion: nil)
        
    }
}

