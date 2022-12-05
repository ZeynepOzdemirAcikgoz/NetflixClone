//
//  HeroHeaderUIView.swift
//  NetflixClone
//
//  Created by Zeynep Özdemir Açıkgöz on 5.12.2022.
//

import UIKit

class HeroHeaderUIView: UIView {

    private let heroImageView : UIImageView={
        
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "heroImage")
        
        return imageView
    }()
    
    private func addGradient(){
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
        
            UIColor.clear.cgColor,
            UIColor.systemBackground.cgColor
        ]
        gradientLayer.frame = bounds
        layer.addSublayer(gradientLayer)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(heroImageView)
        addGradient()
        
        
    }
    
    override func layoutSubviews() {// tabloya çerçeve veriyoruz
        super.layoutSubviews()
        heroImageView.frame = bounds
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
}
