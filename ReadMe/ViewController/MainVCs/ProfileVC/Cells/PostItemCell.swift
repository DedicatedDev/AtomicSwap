//
//  PostItemCell.swift
//  ReadMe
//
//  Created by FreeBird on 10/27/20.
//  Copyright © 2020 Jayesh. All rights reserved.
//

import UIKit
class PostItemCell: UICollectionViewCell {
    
    let imgView:UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        render()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func render(){
        addSubview(imgView)
        imgView.fillContainer()
    }
}
