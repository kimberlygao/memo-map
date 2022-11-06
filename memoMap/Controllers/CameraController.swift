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
  
}
