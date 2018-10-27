//
//  ConfettiButton.swift
//  Confetti
//
//  Created by jinsei shima on 2018/10/27.
//  Copyright © 2018 jinsei shima. All rights reserved.
//

import UIKit

final class ConfettiButton: UIButton {
    
    private let confettiView: ConfettiView = .init()
    
    override init (frame : CGRect) {
        super.init(frame : frame)
        setup()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        setup()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        confettiView.frame = bounds
        insertSubview(confettiView, at: 0)
    }
    
    private func setup(){
        clipsToBounds = false
        insertSubview(confettiView, at: 0)
    }
    
    func animate () {
        self.confettiView.animate()
    }
    
    func likeBounce (_ duration: TimeInterval) {
        
        transform = .identity
        UIView.animateKeyframes(
            withDuration: duration,
            delay: 0,
            options: [.allowUserInteraction, .beginFromCurrentState],
            animations: {
                UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1/5, animations: {
                    self.transform = CGAffineTransform(scaleX: 1.6, y: 1.6)
                })
                UIView.addKeyframe(withRelativeStartTime: 1/5, relativeDuration: 1/5, animations: {
                    self.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
                })
                UIView.addKeyframe(withRelativeStartTime: 2/5, relativeDuration: 1/5, animations: {
                    self.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
                })
                UIView.addKeyframe(withRelativeStartTime: 3/5, relativeDuration: 1/5, animations: {
                    self.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
                })
                UIView.addKeyframe(withRelativeStartTime: 4/5, relativeDuration: 1/5, animations: {
                    self.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                })
        },
            completion: nil
        )
    }
    
    func unLikeBounce (_ duration: TimeInterval) {
        
        transform = .identity
        UIView.animateKeyframes(
            withDuration: duration,
            delay: 0,
            options: [.allowUserInteraction, .beginFromCurrentState],
            animations: {
                UIView.addKeyframe(withRelativeStartTime: 1/5, relativeDuration: 1/5, animations: {
                    self.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
                })
                UIView.addKeyframe(withRelativeStartTime: 3/5, relativeDuration: 1/5, animations: {
                    self.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
                })
                UIView.addKeyframe(withRelativeStartTime: 4/5, relativeDuration: 1/5, animations: {
                    self.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                })
        },
            completion: nil
        )
    }
}


final class ConfettiView: UIView{
    
    private var explosionInLayer:CAEmitterLayer!
    private var explosionOutLayer:CAEmitterLayer!

    private let chargeBirthRate = "emitterCells.charge.birthRate"
    private let explosionBirthRate1 = "emitterCells.explosion1.birthRate"
    private let explosionBirthRate2 = "emitterCells.explosion2.birthRate"

    override init (frame : CGRect) {
        super.init(frame : frame)
        setup()
    }
    
    convenience init () {
        self.init(frame:CGRect.zero)
        setup()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        setup()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let center = CGPoint(x: bounds.midX, y: bounds.midY)
        explosionInLayer.emitterPosition = center
        explosionOutLayer.emitterPosition = center
    }
    
    private func setup(){
        
        clipsToBounds = false
        isUserInteractionEnabled = false
        
        let image1 = UIImage(named: "sub1")
        let image2 = UIImage(named: "sub2")
        let image3 = UIImage(named: "sub3")
        let particleScale: CGFloat = 0.10
        let particleScaleRange: CGFloat = 0.04
        
        let explosionOutCell = CAEmitterCell()
        explosionOutCell.name = "explosion1"
        explosionOutCell.alphaRange = 0.40
        explosionOutCell.alphaSpeed = -1.0
        explosionOutCell.lifetime = 0.8
        explosionOutCell.lifetimeRange = 0.4
        explosionOutCell.birthRate = 0
        explosionOutCell.velocity = 50.00
        explosionOutCell.velocityRange = 8.00
        explosionOutCell.contents = image1?.cgImage
        explosionOutCell.scale = particleScale
        explosionOutCell.scaleRange = particleScaleRange
        
        let explosionOutCell2 = CAEmitterCell()
        explosionOutCell2.name = "explosion2"
        explosionOutCell2.alphaRange = 0.40
        explosionOutCell2.alphaSpeed = -1.0
        explosionOutCell2.lifetime = 0.8
        explosionOutCell2.lifetimeRange = 0.4
        explosionOutCell2.birthRate = 0
        explosionOutCell2.velocity = 50.00
        explosionOutCell2.velocityRange = 8.00
        explosionOutCell2.contents = image3?.cgImage
        explosionOutCell2.scale = particleScale
        explosionOutCell2.scaleRange = particleScaleRange
        
        explosionOutLayer = CAEmitterLayer()
        explosionOutLayer.name = "emitterLayer"
        explosionOutLayer.emitterShape = CAEmitterLayerEmitterShape.circle
        explosionOutLayer.emitterMode = CAEmitterLayerEmitterMode.outline
        explosionOutLayer.emitterSize = CGSize(width: 30, height: 0)
        explosionOutLayer.emitterCells = [explosionOutCell, explosionOutCell2]
        explosionOutLayer.renderMode = CAEmitterLayerRenderMode.oldestFirst
        layer.addSublayer(explosionOutLayer)
        
        let explosionInCell = CAEmitterCell()
        explosionInCell.name = "charge"
        explosionInCell.alphaRange = 0.40
        explosionInCell.alphaSpeed = -1.0
        explosionInCell.lifetime = 0.4
        explosionInCell.lifetimeRange = 0.2
        explosionInCell.birthRate = 0
        explosionInCell.velocity = -10.0
        explosionInCell.velocityRange = 0.0
        explosionInCell.contents = image2?.cgImage
        explosionInCell.scale = particleScale
        explosionInCell.scaleRange = particleScaleRange
        
        explosionInLayer = CAEmitterLayer()
        explosionInLayer.name = "emitterLayer"
        explosionInLayer.emitterShape = CAEmitterLayerEmitterShape.circle
        explosionInLayer.emitterMode = CAEmitterLayerEmitterMode.outline
        explosionInLayer.emitterSize = CGSize(width: 30, height: 0)
        explosionInLayer.emitterCells = [explosionInCell]
        explosionInLayer.renderMode = CAEmitterLayerRenderMode.oldestFirst
        layer.addSublayer(explosionInLayer)
    }
    
    func animate () {
        explosionInLayer.beginTime = CACurrentMediaTime()
        explosionInLayer.setValue(60, forKeyPath: chargeBirthRate)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.explode()
        }
    }
    
    private func explode () {
        explosionInLayer.setValue(0, forKeyPath: chargeBirthRate)
        explosionOutLayer.beginTime = CACurrentMediaTime()
        explosionOutLayer.setValue(180, forKeyPath: explosionBirthRate1)
        explosionOutLayer.setValue(180, forKeyPath: explosionBirthRate2)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.stop()
        }
    }
    
    private func stop () {
        explosionInLayer.setValue(0, forKeyPath: chargeBirthRate)
        explosionOutLayer.setValue(0, forKeyPath: explosionBirthRate1)
        explosionOutLayer.setValue(0, forKeyPath: explosionBirthRate2)
    }
    
}
