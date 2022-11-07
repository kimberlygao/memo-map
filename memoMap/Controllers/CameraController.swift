//
//  Camera.swift
//  memoMap
//
//  Created by Kimberly Gao on 11/5/22.
//

import Foundation
import AVFoundation
import SwiftUI

class CameraController: UIViewController, ObservableObject, AVCapturePhotoCaptureDelegate {
  @Published var isTaken = false
  
  @Published var session = AVCaptureSession()
  
  @Published var alert = false
  
  @Published var output = AVCapturePhotoOutput()
  
  @Published var preview = AVCaptureVideoPreviewLayer()
  
  @Published var isSaved = false

  
  @Published var photo1 = Data(count: 0)
  @Published var photo2 = Data(count: 0)
  
  var image1 : UIImage = UIImage()
  var image2 : UIImage = UIImage()
  
  var image1Done = false
  
  var backCameraOn = true
  var flashOn = false
  
  var backCamera : AVCaptureDevice!
  var frontCamera : AVCaptureDevice!
  
  var backInput : AVCaptureInput!
  var frontInput : AVCaptureInput!
  
  // check camera usage permissions
  func check() {
    switch AVCaptureDevice.authorizationStatus(for: .video) {
    case .authorized:
      setUp()
      return
    case .notDetermined:
      AVCaptureDevice.requestAccess(for: .video) { (status) in
        if status {
          self.setUp()
        }
      }
    case .denied:
      self.alert.toggle()
      return
    default:
      return
    }
    
  }
  
  // set up session
  func setUp() {
    DispatchQueue.global(qos: .userInitiated).async{
      self.session.beginConfiguration()
      
      self.session.automaticallyConfiguresCaptureDeviceForWideColor = true
      
      self.setUpInputs()
      
      self.setUpOutput()
      
      self.session.commitConfiguration()
      
      self.session.startRunning()
    }
  }
  
  func setUpInputs() {
    if let device = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back) {
      backCamera = device
    } else {
      fatalError("no back camera")
    }
    
    if let device = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .front) {
      frontCamera = device
    } else {
      fatalError("no back camera")
    }
    
    guard let bInput = try? AVCaptureDeviceInput(device: backCamera) else {
      fatalError("could not create input device from back camera")
    }
    backInput = bInput
    if !session.canAddInput(backInput) {
      fatalError("could not add back camera input to capture session")
    }
    
    guard let fInput = try? AVCaptureDeviceInput(device: frontCamera) else {
      fatalError("could not create input device from front camera")
    }
    frontInput = fInput
    if !session.canAddInput(frontInput) {
      fatalError("could not add front camera input to capture session")
    }
    
    //connect back camera input to session
    session.addInput(backInput)
  }
  
  func setUpOutput() {
    if self.session.canAddOutput(self.output) {
      self.session.addOutput(self.output)
      
    }
  }
  
  func setUpPreviewLayer() {
    self.preview = AVCaptureVideoPreviewLayer(session: self.session)
    self.preview.frame = view.frame
    self.preview.videoGravity = .resizeAspectFill
  }
  
  func takePhoto() {
    DispatchQueue.global(qos: .background).async {
      
      if self.image1Done {
        print("TAKING IMaGE 2")
        self.output.capturePhoto(with: AVCapturePhotoSettings(), delegate: self)
        print("finished taking image 2")
      } else {
        self.output.capturePhoto(with: AVCapturePhotoSettings(), delegate: self)
        self.flipCamera()
      }
    
    }
    
    
  }
  
  func displayPhoto() {
    
  }
  
  func reTake() {
    DispatchQueue.global(qos: .background).async {
      self.session.startRunning()
      
      self.flipCamera()
      
      DispatchQueue.main.async {
        withAnimation{self.isTaken.toggle()}
        
        self.isSaved = false
        self.image1Done = false
      }
    }
  }
  
  
  func flipCamera() {
    session.beginConfiguration()
    if backCameraOn {
      session.removeInput(backInput)
      session.addInput(frontInput)
      backCameraOn = false
    } else {
      session.removeInput(frontInput)
      session.addInput(backInput)
      backCameraOn = true
    }
    
    session.commitConfiguration()

  }

  
  func toggleFlash() {
    let photoSetting = AVCapturePhotoSettings()
    
//    if flashOn
//    switch photoSetting.flashMode {
//      case .on:
//        print("on")
//      case .off:
//        print("off")
//      case .auto:
//        print("auto")
//    @unknown default:
//      <#fatalError()#>
//    }
  }
  
  func photoOutput(_ _output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
    if error != nil {
      return
    }
    
    guard let imageData = photo.fileDataRepresentation() else {return}
    
    if !image1Done {
      print("processing image 1")
      self.photo1 = imageData
      self.image1 = UIImage(data: self.photo1)!
      print(image1)
      
      DispatchQueue.main.async {
        withAnimation{self.image1Done.toggle()}
      }
      
      self.takePhoto()
    } else {
      print("processing image 2")
      self.photo2 = imageData
      self.image2 = UIImage(data: self.photo2)!
      print(image2)
      self.session.stopRunning()
      
      DispatchQueue.main.async {
        withAnimation{self.isTaken.toggle()}
      }
    }
    
  }
  
  func savePhoto () {
    let image = UIImage(data: self.photo1)!
    
    UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
    self.isSaved = true
    print("saved successfully")
  }
  

}
