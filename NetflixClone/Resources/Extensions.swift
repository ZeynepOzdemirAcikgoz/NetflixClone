//
//  Extensions.swift
//  NetflixClone
//
//  Created by Zeynep Özdemir Açıkgöz on 7.12.2022.
//

import Foundation


extension String{
    
    // Headerlerin ilk harfi büyük olsun fonksiyonu
    func capitalizeFirstLetter() -> String {
        
        return self.prefix(1).uppercased() + self.lowercased().dropFirst()
        
    }
}
