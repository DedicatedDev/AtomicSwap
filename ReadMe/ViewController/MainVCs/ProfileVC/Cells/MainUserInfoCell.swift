//
//  MainUserInfoCell.swift
//  ReadMe
//
//  Created by FreeBird on 10/27/20.
//  Copyright © 2020 Jayesh. All rights reserved.
//

import UIKit

class MainUserInfoCell: UICollectionReusableView {
    
    let profileImgView:UIImageView = {
        let iv = UIImageView(image: R.image.profileUserImg())
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFill
        iv.withSize(CGSize(width: 72, height: 72))
        iv.layer.cornerRadius = 36
        iv.clipsToBounds = true
        return iv
    }()
    
    var onCalculated:(()->())?
    
    let idLbl:UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = R.font.poppinsMedium(size: 14)
        l.textColor = .primaryDisbledTextColor
        l.text = "@JohnTome"
        l.textAlignment = .center
        return l
    }()
    
    let followersView:FollowView = {
        let v = FollowView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.caption = "850"
        v.value = "Followers"
        return v
    }()
    
    let followingView:FollowView = {
        let v = FollowView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.caption = "450"
        v.value = "Following"
        return v
    }()
    
    let LikesView:FollowView = {
        let v = FollowView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.caption = "100"
        v.value = "Likes"
        return v
    }()
    
    let mainBioLbl:UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.textAlignment  = .center
        l.text = "Lorem ipsum dolor sit amet,consectetur adipiscing elit  Maecenas a molestie purus."
        l.font = R.font.poppinsRegular(size: 12)
        l.textColor = .primaryTextColor
        l.numberOfLines = 0
        return l
    }()
    
    let editProfileBtn:UIButton = {
        let b = UIButton()
        b.translatesAutoresizingMaskIntoConstraints = false
        b.setTitle("Eidt Profile", for: .normal)
        b.backgroundColor = .mainBgColor
        b.setTitleColor(.primaryDisbledTextColor, for: .normal)
        b.layer.borderWidth = 1
        b.layer.borderColor = UIColor.dividerColor.cgColor
        b.withSize(CGSize(width: 109, height: 39))
        b.layer.cornerRadius = 19.5
        b.titleLabel?.font = R.font.poppinsMedium(size: 14)
        return b
    }()
    
    let tabs : WMSegment = {
        let s = WMSegment()
        s.selectorType = .bottomBar
        s.SelectedFont = R.font.poppinsMedium(size: 14)!
        s.normalFont = R.font.poppinsMedium(size: 14)!
        s.buttonTitles  = "Asked,Answered"
        s.textColor = .primaryTextColor
        s.selectorColor = #colorLiteral(red: 0.2941176471, green: 0.2588235294, blue: 0.5921568627, alpha: 1)
        s.selectorTextColor = #colorLiteral(red: 0.2941176471, green: 0.2588235294, blue: 0.5921568627, alpha: 1)
        s.bottomBarHeight = 1
        s.layer.cornerRadius = 1.5
        s.layer.borderColor = .none
        s.withHeight(50)
        s.setSelectedIndex(0)
        s.selectedSegmentIndex = 0
        s.isEnableDivider = true
        return s
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        render()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func render(){
        
        let followStack = UIStackView(arrangedSubviews: [followersView,followingView,LikesView])
        followStack.translatesAutoresizingMaskIntoConstraints = false
        followStack.axis = .horizontal
        followStack.spacing = 24
        followStack.alignment = .center
        followStack.distribution = .fillEqually
//        stack(hstack(UIView(),profileImgView,UIView(),distribution:.equalCentering),idLbl,followStack,mainBioLbl,editProfileBtn,tabs, spacing: 16, alignment: .fill, distribution: .fill).padTop(16).padBottom(16).padLeft(16).padRight(16)
        
        addSubview(profileImgView)
        profileImgView.centerHorizontally()
        profileImgView.top(12)

        addSubview(idLbl)
        idLbl.centerHorizontally()
        idLbl.topAnchor.constraint(equalTo: profileImgView.bottomAnchor, constant: 8).isActive = true
        


        addSubview(followStack)
        followStack.anchor(top: idLbl.bottomAnchor, leading: nil, bottom: nil, trailing: nil)
        followStack.centerHorizontally()


        addSubview(mainBioLbl)

        addSubview(tabs)
        tabs.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor,padding: UIEdgeInsets(top: 0, left: 16, bottom: 16, right: 16))

        tabs.heightAnchor.constraint(equalToConstant: 56).isActive = true

        addSubview(editProfileBtn)
        editProfileBtn.centerHorizontally()
        editProfileBtn.bottomAnchor.constraint(equalTo: tabs.topAnchor, constant: -24).isActive = true
        addSubview(mainBioLbl)

        mainBioLbl.anchor(top: followStack.bottomAnchor, leading: leadingAnchor, bottom: editProfileBtn.topAnchor, trailing: trailingAnchor,padding: UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16))
        mainBioLbl.setContentHuggingPriority(.defaultHigh, for: .vertical)
    }
    

    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        
        let newLayoutAttributes =  UICollectionViewLayoutAttributes(forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, with: IndexPath(row: 0, section: 0))
        newLayoutAttributes.frame = CGRect(x: 0, y: 0, width: 400, height: 1000)
        onCalculated?()
        return newLayoutAttributes
    }
}
