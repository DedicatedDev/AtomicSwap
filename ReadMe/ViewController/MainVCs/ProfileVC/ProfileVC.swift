//
//  ProfileVC.swift
//  ReadMe
//
//  Created by FreeBird on 10/26/20.
//  Copyright © 2020 Jayesh. All rights reserved.
//

import UIKit
class ProfileVC: UIViewController {
    
    weak var coordinator:ProfileCoordinator?
    weak var coordinatorWithHome:HomeCoordinator?
    
    
    var images: [UIImage] = [#imageLiteral(resourceName: "4"),#imageLiteral(resourceName: "5"),#imageLiteral(resourceName: "12"),#imageLiteral(resourceName: "6"),#imageLiteral(resourceName: "2"),#imageLiteral(resourceName: "8"),#imageLiteral(resourceName: "13"), #imageLiteral(resourceName: "4"),#imageLiteral(resourceName: "4"),#imageLiteral(resourceName: "5"),#imageLiteral(resourceName: "12"),#imageLiteral(resourceName: "6"),#imageLiteral(resourceName: "2"),#imageLiteral(resourceName: "8"),#imageLiteral(resourceName: "13")]
    var currentPageType:ProfileVCPageType = .mine
    var datasource:[QuestionType] = [
        .ansChoice(AnswerChoiceCellVM(topic: "Pick a name for me", questions: ["Love ❤️ ","Baby 😍 ","Heartbreaker 💔 "], electionResult: ElectionModel(numberOfLove: 100, numberOfComment: 50, numberOfAnswer: 200), userInfo: UserInfoModel(id: nil, userName: "Lina Henry", profileImgs: [R.image.profile()!], profileImgUrls: nil, fullName: "Lina Henry", followers: 850, followings: 120, likes: 70))),.rate(RateImgVM()),.compare(CompareCellVM()),
         .ansChoice(AnswerChoiceCellVM(topic: "what’s my favorite food?", questions: ["Italian ❤️ "," Maxican 😍 ","Indian 💔"], electionResult: ElectionModel(numberOfLove: 100, numberOfComment: 50, numberOfAnswer: 200), userInfo: UserInfoModel(id: nil, userName: "Lina Henry", profileImgs: [R.image.profile()!], profileImgUrls: nil, fullName: "Lina Henry", followers: 850, followings: 120, likes: 70))),
         .ansChoice(AnswerChoiceCellVM(topic: "Am I Cute?", questions: ["Yes","No"], electionResult: ElectionModel(numberOfLove: 100, numberOfComment: 50, numberOfAnswer: 200), userInfo: UserInfoModel(id: nil, userName: "Lina Henry", profileImgs: [R.image.profile()!], profileImgUrls: nil, fullName: "Lina Henry", followers: 850, followings: 120, likes: 70))),.rate(RateImgVM()),.compare(CompareCellVM()),.rate(RateImgVM()),.compare(CompareCellVM()),.rate(RateImgVM()),.compare(CompareCellVM()),.rate(RateImgVM()),.compare(CompareCellVM()),.rate(RateImgVM()),.compare(CompareCellVM()),.rate(RateImgVM()),.compare(CompareCellVM()),.rate(RateImgVM()),.compare(CompareCellVM()),.rate(RateImgVM()),.compare(CompareCellVM())]
    
    let collectionView:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
        
    }()
        
    var header:UICollectionReusableView?
    
    override func viewDidLoad() {
        view.backgroundColor = .mainBgColor
        super.viewDidLoad()
        setupLayout()
        setupCollectionViewInsets()
        navigationItem.title = "Jone Home"
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.primaryTextColor,NSAttributedString.Key.font:R.font.poppinsMedium(size: 14)!]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        if currentPageType == .other{
            
            let leftBtn = UIButton()
            leftBtn.setImage(R.image.backArrow(), for: .normal)
            leftBtn.frame = CGRect(x: 0, y: 0, width: 100, height: 44)
            leftBtn.contentHorizontalAlignment = .left
            leftBtn.titleLabel?.font = R.font.poppinsMedium(size: 14)
            leftBtn.setTitleColor(.primaryTextColor, for: .normal)
            leftBtn.titleEdgeInsets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
            navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftBtn)
            leftBtn.addTarget(self, action:#selector(popVC), for: .touchUpInside)
        }
        
        view.addSubview(collectionView)
        collectionView.fillSuperviewSafeAreaLayoutGuide()
        collectionView.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(PostItemCell.self, forCellWithReuseIdentifier: PostItemCell.reuseIdentifier())
        collectionView.register(MainUserInfoCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: MainUserInfoCell.reuseIdentifier())
        collectionView.register(OtherUserInfoCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: OtherUserInfoCell.reuseIdentifier())
       
    }
    
    //MARK: private
    
    private func setupCollectionViewInsets() {
        collectionView.backgroundColor = .clear
        collectionView.contentInset = UIEdgeInsets(
            top: 15,
            left: 5,
            bottom: 49,
            right: 5
        )
    }
    
    private func setupLayout() {
        let layout: PinterestLayout = {
            if let layout = UICollectionViewLayout() as? PinterestLayout {
                return layout
            }
            let layout = PinterestLayout()

            collectionView.collectionViewLayout = layout

            return layout
        }()
        
        layout.delegate = self
        layout.cellPadding = 5
        layout.numberOfColumns = 2
        
    }
    
    @objc func popVC(){
        navigationController?.isNavigationBarHidden = true
        coordinatorWithHome?.navigationController.pop()
    }
   
}




