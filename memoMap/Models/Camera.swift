//
//  Camera.swift
//  memoMap
//
//  Created by Kimberly Gao on 11/5/22.
//

import Foundation
import AVFoundation
import SwiftUI

class Camera: NSObject, ObservableObject, AVCapturePhotoCaptureDelegate {
  @Published var isTaken = false
  
  @Published var session = AVCaptureSession()
  
  @Published var alert = false
  
  @Published var output = AVCapturePhotoOutput()
  
  @Published var preview = AVCaptureVideoPreviewLayer()
  
  @Published var isSaved = false
  
  @Published var photoData = Data(count: 0)
  
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
  
  func setUp() {
    do {
      
      self.session.beginConfiguration()
      
      let device = AVCaptureDevice.default(.builtInDualCamera, for: .video, position: .back)
      
      let input = try AVCaptureDeviceInput(device: device!)
      
      if self.session.canAddInput(input) {
        self.session.addInput(input)
      }
      
      if self.session.canAddOutput(self.output) {
        self.session.addOutput(self.output)
        
      }
      
      self.session.commitConfiguration()
      
    } catch {
      print(error.localizedDescription)
    }
  }
  
  func takePhoto() {
    DispatchQueue.global(qos: .background).async {
      self.output.capturePhoto(with: AVCapturePhotoSettings(), delegate: self)
      self.session.stopRunning()
    }
    
    DispatchQueue.main.async {
      withAnimation{self.isTaken.toggle()}
    }
  }
  
  func reTake() {
    DispatchQueue.global(qos: .background).async {
      self.session.startRunning()
      
      DispatchQueue.main.async {
        withAnimation{self.isTaken.toggle()}
        
        self.isSaved = false
      }
    }
  }
  
  func photoOutput(_ _output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
    if error != nil {
      return
    }
    
    guard let imageData = photo.fileDataRepresentation() else {return}
    
    self.photoData = imageData
    print("picture taken")
  }
  
  func savePhoto () {
    let image = UIImage(data: self.photoData)!
    
    UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
    self.isSaved = true
    print("saved successfully")
  }
}
