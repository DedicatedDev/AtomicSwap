//
//  HeaderView.swift
//  ReadMe
//
//  Created by FreeBird on 10/26/20.
//  Copyright © 2020 Jayesh. All rights reserved.
//

import UIKit

class HeaderView: UIView {
    var delegate:OpenOthersProfileDelegate?
    let profileImgView:UIImageView = {
        let v = UIImageView(image: #imageLiteral(resourceName: "Profile.png"))
        v.translatesAutoresizingMaskIntoConstraints = false
        v.layer.cornerRadius = 20
        v.clipsToBounds = true
        return v
    }()
    
    let profileNameLbl:UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = R.font.poppinsMedium(size: 14)
        l.textColor = .white
        l.text = "Lina Henry"
        return l
    }()
    
    let follwBtn:UIButton = {
        let b = UIButton()
        b.translatesAutoresizingMaskIntoConstraints = false
        b.setTitle("Follow", for: .normal)
        b.setTitleColor(#colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.9490196078, alpha: 1), for: .normal)
        b.titleLabel?.font = R.font.poppinsMedium(size: 14)
        b.layer.cornerRadius = 14.5
        b.backgroundColor = #colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 0.5)
        return b
    }()
    
    let filterOptionView:FilterOptionView = {
        let v = FilterOptionView(frame: CGRect(x: 0, y: 0, width: 120, height: 100))
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        render()
        addAction()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func render(){
        addSubview(profileImgView)
        profileImgView.withSize(CGSize(width: 40, height: 40))
        profileImgView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        profileImgView.left(0)
        
        addSubview(profileNameLbl)
        profileNameLbl.centerYTo(profileImgView.centerYAnchor)
        profileNameLbl.leadingAnchor.constraint(equalTo: profileImgView.trailingAnchor, constant: 12).isActive = true
       
       
    }
    
    private func addAction(){
        profileImgView.isUserInteractionEnabled = true
        profileNameLbl.isUserInteractionEnabled = true
        let tab1 = UITapGestureRecognizer(target: self, action: #selector(openProfile))
        let tab2 = UITapGestureRecognizer(target: self, action: #selector(openProfile))
        profileImgView.addGestureRecognizer(tab1)
        profileNameLbl.addGestureRecognizer(tab2)
    }
    
    @objc func openProfile(){
        delegate?.openOtherProfile()
    }
}
