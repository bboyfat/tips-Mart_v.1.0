//
//  CustomBlurView.swift
//  Tips-Mart
//
//  Created by Andrey Petrovskiy on 8/4/19.
//  Copyright © 2019 Andrey Petrovskiy. All rights reserved.
//

import UIKit

class CustomBlurView: UIView {

    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "eleph")
        imageView.frame = CGRect(x: 0, y: 0, width: 150, height: 150)
        imageView.clipsToBounds = true
        imageView.contentMode = .center
        imageView.layer.cornerRadius = imageView.frame.height / 2
        return imageView
    }()
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }
    override func layoutIfNeeded() {
        super.layoutIfNeeded()
        
    }
    
    func startAnimation(){
        self.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.7047570634)
        let firstLayer = addShapeLayer(strokeColor: #colorLiteral(red: 0.0386101231, green: 0.8220543265, blue: 0.5023989081, alpha: 1), lineWidth: 8, strokeEnd: 0)
        let trackLayer = addShapeLayer(strokeColor: .white, lineWidth: 8, strokeEnd: 1)
        firstLayer.lineCap = CAShapeLayerLineCap.round
        firstLayer.add(addAnim(with: 0.5), forKey: "basic")
        imageView.layer.addSublayer(trackLayer)
        imageView.layer.addSublayer(firstLayer)
        imageView.center = self.center
        self.addSubview(imageView)
    }
    func stopAnim(){
        self.removeFromSuperview()
    }
    
    func addShapeLayer(strokeColor: UIColor, lineWidth: CGFloat, strokeEnd: CGFloat ) -> CAShapeLayer{
        let shapeLayer = CAShapeLayer()
        shapeLayer.masksToBounds = false
        shapeLayer.strokeEnd = strokeEnd
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineWidth = lineWidth
        shapeLayer.strokeColor = strokeColor.cgColor
        let center = CGPoint(x: 75, y: 75)
        let path = UIBezierPath(arcCenter: center, radius: 75, startAngle: -CGFloat.pi / 2, endAngle: CGFloat.pi * 2, clockwise: true).cgPath
        shapeLayer.path = path
        return shapeLayer
    }
    
    
    func addAnim(with duration: CFTimeInterval) -> CABasicAnimation{
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        basicAnimation.toValue = 0.9
        basicAnimation.fromValue = 0.0
        basicAnimation.repeatCount = 15
        basicAnimation.duration = 1
        basicAnimation.fillMode = CAMediaTimingFillMode.removed
        basicAnimation.isRemovedOnCompletion = true
        return basicAnimation
    }
    
}
