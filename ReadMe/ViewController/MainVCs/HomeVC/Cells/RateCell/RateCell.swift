//
//  RateCell.swift
//  ReadMe
//
//  Created by FreeBird on 10/26/20.
//  Copyright © 2020 Jayesh. All rights reserved.
//

import UIKit
import AnimatedCollectionViewLayout

class RateCell: UICollectionViewCell{
    let imageGallery:UICollectionView = {
        let layout = AnimatedCollectionViewLayout()
        layout.scrollDirection = .horizontal
        layout.animator = ZoomOutAttributesAnimator(scaleRate: 1.5)
      //  layout.animator = EaseInOutAttributtesAnimator()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.isPagingEnabled = true
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = .lightGray
        return cv
    }()
    
    let loveRateView:RateView = {
        let v = RateView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.rateItemImgView.image = R.image.heartIcon()
        v.rateItemValueLbl.text = "100"
        return v
    }()
    
    let commentRateView:RateView = {
        let v = RateView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.rateItemImgView.image = R.image.commetIcon()
        v.rateItemValueLbl.text = "200"
        return v
    }()
    
    let rateView:RateView = {
        let v = RateView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.rateItemImgView.image = R.image.answerIcon()
        v.rateItemValueLbl.text = "50"
        return v
    }()
    
    let electionView:UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .white
        v.layer.borderWidth = 1
        v.layer.borderColor = UIColor.dividerColor.cgColor
        v.layer.cornerRadius = 12
        v.layer.zPosition = 10
        return v
    }()
    
    let electionTitleLbl:UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = R.font.poppinsSemiBold(size: 18)
        l.textColor = .primaryTextColor
        l.text = "Would you party with me?"
        l.textAlignment = .center
        return l
    }()
   
    
    
    let rateSlider:RateSlider = {
        let rs = RateSlider()
        rs.translatesAutoresizingMaskIntoConstraints = false
        return rs
    }()
    
    let headerView:HeaderView = {
        let v = HeaderView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    let filterOptionView:FilterOptionView = {
        let v = FilterOptionView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    var sampleImags:[UIImage] = [#imageLiteral(resourceName: "14"),#imageLiteral(resourceName: "15"),#imageLiteral(resourceName: "AnswerToSee")]


    override init(frame: CGRect) {
        super.init(frame: frame)
        render()
        addAction()
    }
    
    let pageControl: UIPageControl = {
        let p = UIPageControl()
        p.translatesAutoresizingMaskIntoConstraints = false
        p.pageIndicatorTintColor = #colorLiteral(red: 0.7024049163, green: 0.70252496, blue: 0.7023879886, alpha: 1)
        p.currentPageIndicatorTintColor = .primaryTextColor
        
        return p
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func render(){
        backgroundColor = .mainBgColor
        contentView.addSubview(imageGallery)
        
        pageControl.numberOfPages = sampleImags.count
        let bottomStack = UIStackView(arrangedSubviews: [loveRateView,commentRateView,UIView(),rateView])
        bottomStack.translatesAutoresizingMaskIntoConstraints = false
        bottomStack.axis = .horizontal
        bottomStack.spacing = 10
        bottomStack.distribution = .fill
        imageGallery.anchor(top: contentView.topAnchor, leading: contentView.leadingAnchor, bottom: nil, trailing: contentView.trailingAnchor)
        contentView.addSubview(bottomStack)
        bottomStack.height(25)
        bottomStack.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: contentView.trailingAnchor,padding: UIEdgeInsets(top: 0, left: 16, bottom: 16, right: 16))
        
        contentView.addSubview(electionView)
        electionView.anchor(top: imageGallery.bottomAnchor, leading: contentView.leadingAnchor, bottom: bottomStack.topAnchor, trailing: contentView.trailingAnchor,padding: UIEdgeInsets(top: -16, left: 16, bottom: 16, right: 16))
    
        electionView.addSubview(electionTitleLbl)
        electionTitleLbl.anchor(top: electionView.topAnchor, leading: electionView.leadingAnchor, bottom: nil, trailing: electionView.trailingAnchor,padding: UIEdgeInsets(top: 16, left: 16, bottom: 0, right: 13))
        
        electionView.addSubview(rateSlider)
        rateSlider.anchor(top: electionTitleLbl.bottomAnchor, leading: electionView.leadingAnchor, bottom: electionView.bottomAnchor, trailing: electionView.trailingAnchor,padding: UIEdgeInsets(top: 15, left: 15, bottom: 7, right: 15))
    
        contentView.addSubview(headerView)
        headerView.anchor(top: contentView.topAnchor, leading: contentView.leadingAnchor, bottom: nil, trailing: contentView.trailingAnchor,padding: UIEdgeInsets(top: 8, left: 16, bottom: 0, right: 16))
        headerView.height(40)
        contentView.addSubview(filterOptionView)
        filterOptionView.anchor(top: contentView.topAnchor, leading: nil, bottom: nil, trailing: contentView.trailingAnchor,padding: UIEdgeInsets(top: 8, left: 0, bottom: 0, right: 16))
        
        filterOptionView.currentOptionLbl.text = "Michigan State"
        filterOptionView.currentOptionLbl.alpha = 1
  
       // imageGallery.height(517.adjustedh)
        contentView.addSubview(pageControl)
        pageControl.anchor(top: nil, leading: contentView.leadingAnchor, bottom: electionView.topAnchor, trailing: contentView.trailingAnchor,padding: UIEdgeInsets(top: 0, left: 0, bottom: 6, right: 0))
        
    }
    
    private func addAction(){
        imageGallery.delegate = self
        imageGallery.dataSource = self
        imageGallery.register(UserMediaCell.self, forCellWithReuseIdentifier: UserMediaCell.reuseIdentifier())
    }
}
