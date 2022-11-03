//
//  CameraController.swift
//  memoMap
//
//  Created by Kimberly Gao on 11/2/22.
//

import UIKit

class CameraController: UIViewController {
  @IBOutlet var imageView: UIImageView!
  @IBOutlet var button: UIButton!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    imageView.backgroundColor = .secondarySystemBackground
    
    button.backgroundColor = .systemBlue
    button.setTitle("Take Picture",
                    for: .normal)
    button.setTitleColor(.white, for: .normal)
  }
  
  @IBAction func didTapButton() {
    let vc = UIImagePickerController()
    vc.sourceType = .camera
    vc.allowsEditing = true
    vc.delegate = self
    present(vc, animated: true)
  }
}

extension CameraController: UIImagePickerControllerDelegate,
UINavigationControllerDelegate {
  func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
    picker.dismiss(animated: true, completion: nil)
  }
  
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    guard let image = info[UIImagePickerController.InfoKey.originalImage] as?
      UIImage else {
      return
    }
    imageView.image = image
  }
}

