//
//  LampVC.swift
//  LampUI
//
//  Created by O'ral Nabiyev on 27/02/24.
//

import UIKit

class LampVC: UIViewController {
    
    @IBOutlet weak var lightImg: UIImageView! {
        didSet {
            lightImg.isHidden = true
        }
    }
    
    @IBOutlet weak var opacityNumLbl: UILabel!
    
    @IBOutlet weak var slider: UISlider! {
        didSet {
            slider.value = 0
        }
    }
    
    @IBOutlet weak var onAndOffView: UIView! {
        didSet {
            onAndOffView.backgroundColor = .tred.withAlphaComponent(0.15)
            onAndOffView.layer.maskedCorners = [.layerMinXMinYCorner]
            onAndOffView.layer.cornerRadius = 50
        }
    }
    
    @IBOutlet weak var onAndOffLbl: UILabel! {
        didSet {
            onAndOffLbl.text = "OFF"
            onAndOffLbl.textColor = .tred
        }
    }
    
    @IBOutlet weak var pullDownLbl: UILabel! {
        didSet {
            pullDownLbl.transform = CGAffineTransform(rotationAngle: CGFloat.pi*(3/2))
        }
    }
    
    @IBOutlet weak var handleView: UIView! {
        didSet {
            handleView.layer.borderWidth = 2
            handleView.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            handleView.layer.cornerRadius = 25
        }
    }
    
    @IBOutlet weak var threadView: UIView!
    
    @IBOutlet weak var opacityStackView: UIStackView! {
        didSet {
            opacityStackView.isHidden = true
        }
    }
    
    var locYHandleView: CGFloat = 0
    var locYThreadView: CGFloat = 0
    var locYPullDownLbl: CGFloat = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpPanGesture()
    locYHandleView = handleView.center.y
    locYThreadView = threadView.center.y
    locYPullDownLbl = pullDownLbl.center.y
    }
    
    func setUpPanGesture() {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panned (_:)))
        self.handleView.addGestureRecognizer(panGesture)
    }

    @objc func panned(_ gesture: UIPanGestureRecognizer) {
        let location = gesture.location(in: self.view)

        
        if gesture.state == .changed {
            handleView.center.y = location.y
            threadView.center.y = handleView.center.y - 650
            pullDownLbl.center.y = handleView.center.y - pullDownLbl.frame.height+20
        } else if gesture.state == .ended {
            if location.y > self.view.frame.height/2 {
                if onAndOffLbl.text == "OFF" {
                    onAndOffLbl.text = "ON"
                    onAndOffLbl.textColor = .tgreen
                    onAndOffView.backgroundColor = .tgreen.withAlphaComponent(0.15)
                    opacityStackView.isHidden = false
                    lightImg.isHidden = false
                    slider.value = 1
                    lightImg.alpha = 1
                    opacityNumLbl.text = "1.00"
                } else {
                    onAndOffLbl.text = "OFF"
                    onAndOffLbl.textColor = .tred
                    onAndOffView.backgroundColor = .tred.withAlphaComponent(0.15)
                    opacityStackView.isHidden = true
                    lightImg.isHidden = true
                    slider.value = 0
                    lightImg.alpha = 0
                    opacityNumLbl.text = "0.00"
                }
            }
            UIView.animateKeyframes(withDuration: 0.8, delay: 0) { [self] in
                handleView.center.y = locYHandleView
                threadView.center.y = locYThreadView
                pullDownLbl.center.y = locYPullDownLbl
            }
        }
        
    }
    
    @IBAction func sliderSwipe(_ sender: Any) {
        let number = CGFloat(slider.value)
        let roundedNumber = String(format: "%.2f", number)
        lightImg.alpha = CGFloat(number)
        opacityNumLbl.text = roundedNumber
    }
    
    

}
