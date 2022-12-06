//
//  ImageAnnotationView.swift
//  memoMap
//
//  Created by Fiona Chiu on 2022/11/16.
//

import UIKit
import MapKit
import Foundation


//class ImageAnnotationView: MKAnnotationView {
//    private lazy var containerView: UIView = {
//        let view = UIView(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
//        view.backgroundColor = .white
//        view.layer.cornerRadius = 16.0
//        return view
//    }()
//
//    private var imageView: UIImageView = {
//        let imageview = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
//        imageview.translatesAutoresizingMaskIntoConstraints = false
//        imageview.image = UIImage(named: "bg")
//        imageview.layer.cornerRadius = 10.0
//        imageview.layer.masksToBounds = true
//        imageview.clipsToBounds = true
//        return imageview
//    }()
//
//    private lazy var bottomCornerView: UIView = {
//        let view = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
//        view.translatesAutoresizingMaskIntoConstraints = false
//        view.backgroundColor = .white
//        view.layer.cornerRadius = 4.0
//        return view
//    }()
//
//    // MARK: Initialization
////    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
////        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
////
//////        self.glyphImage = self.test
//////        self.markerTintColor = #colorLiteral(red: 0.9597842097, green: 0.9428868294, blue: 0.9317237735, alpha: 1)
//////        configure(for: annotation)
////    }
//    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
//        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
//        configure(for: annotation)
//        setupView()
//    }
//
//    override var annotation: MKAnnotation? {
//        didSet { configure(for: annotation) }
//    }
//
//    override var image: UIImage? {
//        get {
//            return self.imageView.image
//        }
//        set {
//            self.imageView.image = newValue
//        }
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    func configure(for annotation: MKAnnotation?) {
//        displayPriority = .required
//
//        // if doing clustering, also add
//        // clusteringIdentifier = ...
//    }
//
//    private func setupView() {
//        containerView.addSubview(bottomCornerView)
//        bottomCornerView.topAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -15.0).isActive = true
//        bottomCornerView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
//        bottomCornerView.widthAnchor.constraint(equalToConstant: 24).isActive = true
//        bottomCornerView.heightAnchor.constraint(equalToConstant: 24).isActive = true
//
//        let angle = (39.0 * CGFloat.pi) / 180
//        let transform = CGAffineTransform(rotationAngle: angle)
//        bottomCornerView.transform = transform
//
//        containerView.addSubview(imageView)
//        containerView.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
//        addSubview(containerView)
//        imageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8.0).isActive = true
//        imageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 8.0).isActive = true
//        imageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8.0).isActive = true
//        imageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -8.0).isActive = true
////        imageView.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
//    }
//}



class ImageAnnotationView: MKAnnotationView {
    
    private lazy var containerView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
        view.backgroundColor = .white
        view.layer.cornerRadius = 8.0
        return view
    }()

    private var imageView: UIImageView = {
        let imageview = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        imageview.translatesAutoresizingMaskIntoConstraints = false
        imageview.image = UIImage(named: "bg")
        imageview.layer.cornerRadius = 10.0
        imageview.layer.masksToBounds = true
        imageview.clipsToBounds = true
        return imageview
    }()

    private lazy var bottomCornerView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 4.0
        return view
    }()

    // WORKING PIN SECTION
    override var annotation: MKAnnotation? {
        didSet { configure(for: annotation) }
    }

//    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
//        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
//        self.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
//        self.imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
//        self.addSubview(self.imageView)
////        self.glyphImage = self.test
////        self.markerTintColor = #colorLiteral(red: 0.9597842097, green: 0.9428868294, blue: 0.9317237735, alpha: 1)
//        self.imageView.layer.cornerRadius = 10.0
//        self.imageView.layer.masksToBounds = true
//        configure(for: annotation)
//    }

    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
//        self.imageView = imageView
//        self.imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        containerView.addSubview(bottomCornerView)
        bottomCornerView.topAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -15.0).isActive = true
        bottomCornerView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        bottomCornerView.widthAnchor.constraint(equalToConstant: 24).isActive = true
        bottomCornerView.heightAnchor.constraint(equalToConstant: 24).isActive = true

        let angle = (39.0 * CGFloat.pi) / 180
        let transform = CGAffineTransform(rotationAngle: angle)
        self.bottomCornerView.transform = transform

        containerView.addSubview(imageView)
        containerView.frame = CGRect(x: 0, y: 0, width: 70, height: 70)
        imageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8.0).isActive = true
        imageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 8.0).isActive = true
        imageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8.0).isActive = true
        imageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -8.0).isActive = true
        
        self.frame = CGRect(x: 0, y: 0, width: 70, height: 70)
        
        self.addSubview(containerView)
        
//        self.glyphImage = self.test
//        self.markerTintColor = #colorLiteral(red: 0.9597842097, green: 0.9428868294, blue: 0.9317237735, alpha: 1)
//        self.imageView.layer.cornerRadius = 10.0
//        self.imageView.layer.masksToBounds = true
        configure(for: annotation)
    }

    override var image: UIImage? {
        get {
            return self.imageView.image
        }
        set {
            self.imageView.image = newValue
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(for annotation: MKAnnotation?) {
        displayPriority = .required

        // if doing clustering, also add
        // clusteringIdentifier = ...
    }
}

//struct LocationAnnotationView_Previews: PreviewProvider {
//    static var previews: some View {
//        LocationAnnotationView()
//    }
//}
