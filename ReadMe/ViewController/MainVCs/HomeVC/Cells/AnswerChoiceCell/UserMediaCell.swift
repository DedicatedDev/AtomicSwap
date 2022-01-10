//
//  UserMediaCell.swift
//  ReadMe
//
//  Created by FreeBird on 10/26/20.
//  Copyright © 2020 Jayesh. All rights reserved.
//

import UIKit
class UserMediaCell: UICollectionViewCell{
    let imgView:UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.image = R.image.wordAnsImg()
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
        contentView.addSubview(imgView)
        imgView.fillSuperview()
    }
}
