//
//  CollectionViewTableViewCell.swift
//  NetflixClone
//
//  Created by Zeynep Özdemir Açıkgöz on 5.12.2022.
//

import UIKit

class CollectionViewTableViewCell: UITableViewCell {

  static let identifier = "CollectionViewTableViewCell"
    
    override init (style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .systemMint
        
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }

}
