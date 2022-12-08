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

  @Published var photos = []
  @Published var images : [UIImage] = []
  @Published var photo1 = Data(count: 0)
  @Published var photo2 = Data(count: 0)
  
  @Published var image1Done = false
  
  @Published var showControls = true
  var backCameraOn = true
  @Published var flashMode : AVCaptureDevice.FlashMode = .off
  
  var backCamera : AVCaptureDevice!
  var frontCamera : AVCaptureDevice!
  
  var backInput : AVCaptureInput!
  var frontInput : AVCaptureInput!
  
  @Published var hasChecked = false
  
  
  
  // check camera usage permissions
  func check() {
    if hasChecked {
      return
    }
        
    switch AVCaptureDevice.authorizationStatus(for: .video) {
    case .authorized:
      setUp()
        hasChecked = true
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
    if let device = AVCaptureDevice.default(.builtInTripleCamera, for: .video, position: .back) {
      backCamera = device
      do {
        try backCamera.lockForConfiguration()
        let zoomFactor:CGFloat = 8
        backCamera.videoZoomFactor = zoomFactor
        backCamera.unlockForConfiguration()
      } catch {
        print("ZOOM ERROR")
      }
    } else {
      if let device = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back) {
        backCamera = device
      } else {
        fatalError("no back camera")
      }
    }
    
    if let device = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .front) {
      frontCamera = device
    } else {
      fatalError("no front camera")
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
//    self.preview = AVCaptureVideoPreviewLayer(session: self.session)
//    self.preview.frame = view.frame
//    self.preview.videoGravity = .resizeAspectFill
  }
  
  func takePhoto() {
    DispatchQueue.global(qos: .background).async {
      self.output.capturePhoto(with: self.getSettings(), delegate: self)
    }
    
    self.showControls = false
  }
  
  func photoOutput(_ _output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
    if error != nil {
      return
    }
    
    guard let imageData = photo.fileDataRepresentation() else {return}
    
    var photo = Data(count: 0)
    photo = imageData

    self.images.append(UIImage(data: photo)!)
    
    self.photos.append(photo)
    
    
    if photos.count == 1 {
      let secondsToDelay = 1.5
      DispatchQueue.main.async() {
        withAnimation{self.image1Done.toggle()}
      }
      self.flipCamera()
      DispatchQueue.main.asyncAfter(deadline: .now() + secondsToDelay)  {
        self.takePhoto()
      }
    } else {
//      self.session.stopRunning()
      
      DispatchQueue.main.async {
        withAnimation{self.isTaken.toggle()}
      }
    }
  }
  
  func reTake() {
    DispatchQueue.global(qos: .background).async {
      self.flipCamera()
//      self.session.startRunning()
      
      DispatchQueue.main.async {
//        withAnimation{self.isTaken.toggle()}
        self.image1Done = false
        self.isTaken = false
        self.photos = []
        self.images = []
        self.isSaved = false
        self.showControls = true
      }
      
      
    }
  }
  
  func reset() {
    DispatchQueue.main.async {
//      withAnimation{self.isTaken.toggle()}
      
      self.image1Done = false
      self.isTaken = false
      self.photos = []
      self.images = []
      self.isSaved = false
      self.showControls = true

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
  
  func getSettings() -> AVCapturePhotoSettings {
    let settings = AVCapturePhotoSettings()

        if backCameraOn && backCamera.hasFlash {
            settings.flashMode = flashMode
        } else if frontCamera.hasFlash {
            settings.flashMode = flashMode
        }
    
        return settings
  }

  
  func toggleFlash() {
    if self.flashMode == .off {
      self.flashMode = .on
    } else {
      self.flashMode = .off
    }
  }
  
  func savePhoto () {
    let image = UIImage(data: self.photo1)!
    
    UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
    self.isSaved = true
    print("saved successfully")
  }
  

}
