//
//  Ans1Cell.swift
//  ReadMe
//
//  Created by FreeBird on 10/26/20.
//  Copyright © 2020 Jayesh. All rights reserved.
//

import UIKit
import AnimatedCollectionViewLayout
class AnswerChoiceCell: UICollectionViewCell {

    var vm:AnswerChoiceCellVM?{
        didSet{
            questions = vm?.questions ?? []
            electionTitleLbl.text = vm?.topic
        }
    }
    let imageGallery:UICollectionView = {
        let layout = AnimatedCollectionViewLayout()
        layout.scrollDirection = .horizontal
        layout.animator = ZoomOutAttributesAnimator(scaleRate: 1.5)
      //  layout.animator = EaseInOutAttributtesAnimator()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.isPagingEnabled = true
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = .mainBgColor
        return cv
    }()
    
    var sampleImags:[UIImage] = [#imageLiteral(resourceName: "wordAnsImg"),#imageLiteral(resourceName: "12"),#imageLiteral(resourceName: "13"),#imageLiteral(resourceName: "AnswerToSee")]
    
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
        l.text = "Pick a name for me"
        l.textAlignment = .center
        return l
    }()
    
    let loveBtn:UIButton = {
        let b = UIButton()
        b.translatesAutoresizingMaskIntoConstraints = false
        b.backgroundColor = .dividerColor
        b.setTitle("Love ❤️ ", for: .normal)
        b.setTitleColor(.primaryTextColor, for: .normal)
        b.titleLabel?.font = R.font.poppinsMedium(size: 14)
        b.layer.cornerRadius = 19
        b.height(38)
        return b
    }()
    
    let babyBtn:UIButton = {
        let b = UIButton()
        b.translatesAutoresizingMaskIntoConstraints = false
        b.backgroundColor = .dividerColor
        b.setTitle("Baby 😍 ", for: .normal)
        b.setTitleColor(.primaryTextColor, for: .normal)
        b.titleLabel?.font = R.font.poppinsMedium(size: 14)
        b.layer.cornerRadius = 19
        b.height(38)
        return b
    }()
    
    let heartBreakerBtn:UIButton = {
        let b = UIButton()
        b.translatesAutoresizingMaskIntoConstraints = false
        b.backgroundColor = .dividerColor
        b.setTitle("Heartbreaker 💔 ", for: .normal)
        b.setTitleColor(.primaryTextColor, for: .normal)
        b.titleLabel?.font = R.font.poppinsMedium(size: 14)
        b.layer.cornerRadius = 19
        b.height(38)
        return b
    }()
    
    let headerView:HeaderView = {
        let v = HeaderView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    var cellDiplayMode:CellDisplayMode = .ask{
        didSet{
            if cellDiplayMode == .result{
                itemBtns.forEach({
                    $0.buttonStatus = .isSelected
                    $0.setProgress(progress: CGFloat(2*$0.tag)*0.1)
                    $0.isUserInteractionEnabled = false
                })
            }
        }
    }
    let electionBtnStack = UIStackView()
    var itemBtns:[ProgressBarButton] = []
    var questions:[String] = ["Love ❤️ ","Baby 😍 ","Heartbreaker 💔 "]{
        didSet{
            electionBtnStack.safelyRemoveArrangedSubviews()
            var tag:Int = 0
            questions.forEach({
                let itemBtn = ProgressBarButton()
                itemBtn.tag = tag
                itemBtn.clipsToBounds = true
                itemBtn.translatesAutoresizingMaskIntoConstraints = false
                itemBtn.backgroundColor = .dividerColor
                itemBtn.setTitle($0, for: .normal)
                itemBtn.setTitleColor(.primaryTextColor, for: .normal)
                itemBtn.titleLabel?.font = R.font.poppinsMedium(size: 14)
                itemBtn.layer.cornerRadius = 19
                itemBtn.height(38)
                itemBtn.addTarget(self, action: #selector(onTappedBtn(sender:)), for: .touchUpInside)
                itemBtns.append(itemBtn)
                electionBtnStack.addArrangedSubview(itemBtn)
                tag += 1
            })
        }
    }
    
    let filterOptionView:FilterOptionView = {
        let v = FilterOptionView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    let pageControl: UIPageControl = {
        let p = UIPageControl()
        p.translatesAutoresizingMaskIntoConstraints = false
        p.pageIndicatorTintColor = #colorLiteral(red: 0.7024049163, green: 0.70252496, blue: 0.7023879886, alpha: 1)
        p.currentPageIndicatorTintColor = .primaryTextColor
        
        return p
    }()
    
    @objc func onTappedBtn(sender:UIButton){
        itemBtns.forEach({
            if $0.tag == sender.tag{
                $0.isActive = true
                $0.buttonStatus = .selected
                $0.setProgress(progress: 0.7)
            }else{
                $0.buttonStatus = .isSelected
                $0.setProgress(progress: 0.5)
            }
        })
    }
    
    @objc func tapped(){
        print("tagddd","okay")
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        render()
        addAction()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func render(){
        backgroundColor = .mainBgColor
        pageControl.numberOfPages = sampleImags.count
        contentView.addSubview(imageGallery)
        imageGallery.anchor(top: contentView.topAnchor, leading: contentView.leadingAnchor, bottom: nil, trailing: contentView.trailingAnchor)
        imageGallery.height(517.adjustedh)
        
        let bottomStack = UIStackView(arrangedSubviews: [loveRateView,commentRateView,UIView(),rateView])
        bottomStack.translatesAutoresizingMaskIntoConstraints = false
        bottomStack.axis = .horizontal
        bottomStack.spacing = 10
        bottomStack.distribution = .fill
        
        contentView.addSubview(bottomStack)
        bottomStack.height(25)
        bottomStack.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: contentView.trailingAnchor,padding: UIEdgeInsets(top: 0, left: 16, bottom: 16, right: 16))
        
        contentView.addSubview(electionView)
        electionView.anchor(top: nil, leading: contentView.leadingAnchor, bottom: bottomStack.topAnchor, trailing: contentView.trailingAnchor,padding: UIEdgeInsets(top: 0, left: 16, bottom: 16, right: 16))
        //electionView.height(221.adjustedh)
        
       // let electionBtnStack = UIStackView(arrangedSubviews: [loveBtn,babyBtn,heartBreakerBtn])
        electionBtnStack.translatesAutoresizingMaskIntoConstraints = false
        electionBtnStack.axis = .vertical
        electionBtnStack.spacing = 8
        electionBtnStack.alignment = .fill
        electionBtnStack.distribution = .fillEqually
        electionBtnStack.isUserInteractionEnabled = true
        electionView.addSubview(electionTitleLbl)
        electionTitleLbl.anchor(top: electionView.topAnchor, leading: electionView.leadingAnchor, bottom: nil, trailing: electionView.trailingAnchor,padding: UIEdgeInsets(top: 16, left: 16, bottom: 0, right: 13))
        
        electionView.addSubview(electionBtnStack)
        electionBtnStack.anchor(top: electionTitleLbl.bottomAnchor, leading: electionView.leadingAnchor, bottom: electionView.bottomAnchor, trailing: electionView.trailingAnchor,padding: UIEdgeInsets(top: 16, left: 16, bottom: 24, right: 16))
        
        contentView.addSubview(headerView)
        headerView.anchor(top: contentView.topAnchor, leading: contentView.leadingAnchor, bottom: nil, trailing: contentView.trailingAnchor,padding: UIEdgeInsets(top: 8, left: 16, bottom: 0, right: 16))
        headerView.height(40)
        contentView.addSubview(filterOptionView)
        filterOptionView.anchor(top: contentView.topAnchor, leading: nil, bottom: nil, trailing: contentView.trailingAnchor,padding: UIEdgeInsets(top: 8, left: 0, bottom: 0, right: 16))
        
        filterOptionView.currentOptionLbl.text = "Michigan State"
        filterOptionView.currentOptionLbl.alpha = 1
        
        contentView.addSubview(pageControl)
        pageControl.anchor(top: nil, leading: contentView.leadingAnchor, bottom: electionView.topAnchor, trailing: contentView.trailingAnchor,padding: UIEdgeInsets(top: 0, left: 0, bottom: 6, right: 0))
    }
    
    private func addAction(){
        imageGallery.delegate = self
        imageGallery.dataSource = self
        imageGallery.register(UserMediaCell.self, forCellWithReuseIdentifier: UserMediaCell.reuseIdentifier())
    }
}
