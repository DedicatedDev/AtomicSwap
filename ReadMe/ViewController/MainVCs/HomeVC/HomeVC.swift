//
//  HomeVC.swift
//  ReadMe
//
//  Created by FreeBird on 10/26/20.
//  Copyright © 2020 Jayesh. All rights reserved.
//

import UIKit
import AnimatedCollectionViewLayout
class HomeVC: UIViewController {
    weak var coordinator:HomeCoordinator?
    
    enum DataItem {
        case answerChoice(AnswerChoiceCellVM)
        case compare(CompareCellVM)
        case rate(RateImgVM)
    }
    
    var datasource:[DataItem] = [.answerChoice(AnswerChoiceCellVM(topic: "Pick a name for me", questions: ["Love ❤️ ","Baby 😍 ","Heartbreaker 💔 "], electionResult: ElectionModel(numberOfLove: 100, numberOfComment: 50, numberOfAnswer: 200), userInfo: UserInfoModel(id: nil, userName: "Lina Henry", profileImgs: [R.image.profile()!], profileImgUrls: nil, fullName: "Lina Henry", followers: 850, followings: 120, likes: 70))),.compare(CompareCellVM()),.rate(RateImgVM()),.answerChoice(AnswerChoiceCellVM(topic: "Am I Cute", questions: ["Yes ","No"], electionResult: ElectionModel(numberOfLove: 100, numberOfComment: 50, numberOfAnswer: 200), userInfo: UserInfoModel(id: nil, userName: "Lina Henry", profileImgs: [R.image.profile()!], profileImgUrls: nil, fullName: "Lina Henry", followers: 850, followings: 120, likes: 70))),.answerChoice(AnswerChoiceCellVM(topic: "what’s my favorite food?", questions: ["Italian ❤️ "," Maxican 😍 ","Indian 💔"], electionResult: ElectionModel(numberOfLove: 100, numberOfComment: 50, numberOfAnswer: 200), userInfo: UserInfoModel(id: nil, userName: "Lina Henry", profileImgs: [R.image.profile()!], profileImgUrls: nil, fullName: "Lina Henry", followers: 850, followings: 120, likes: 70)))]
    
    let collectionView:UICollectionView = {
        let layout = AnimatedCollectionViewLayout()
        layout.scrollDirection = .vertical
        layout.animator = PageOffsetAttributesAnimator(scaleRate: 0.1)
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.isPagingEnabled = true
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
        
    }()
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        render()
        addAction()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if collectionView.contentOffset.y != 0 {
            collectionView.contentOffset.y = 0
        }
    }

    private func render(){
        view.backgroundColor = .white
        view.addSubview(collectionView)
        collectionView.fillSuperviewSafeAreaLayoutGuide()

    }
    
    func setupHeaderView(){
       
        
    }
    
    private func addAction(){
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .mainBgColor
        collectionView.register(AnswerChoiceCell.self, forCellWithReuseIdentifier: AnswerChoiceCell.reuseIdentifier())
        collectionView.register(CompareCell.self, forCellWithReuseIdentifier: CompareCell.reuseIdentifier())
        collectionView.register(RateCell.self, forCellWithReuseIdentifier: RateCell.reuseIdentifier())
        
        
    }
}


#if canImport(SwiftUI) && DEBUG
import SwiftUI
struct HomeVCViewRepresentable: UIViewControllerRepresentable {
    
    func makeUIViewController(context: Context) -> HomeVC {
        return HomeVC()
    }
    func updateUIViewController(_ uiViewController: HomeVC, context: Context) {
    }
}

@available(iOS 13.0, *)
struct HomeVC_Preview: PreviewProvider {
    static var previews: some View {
        return Group {
            HomeVCViewRepresentable().previewDevice(PreviewDevice(stringLiteral: "iPhone 11"))
                .edgesIgnoringSafeArea(.all)
                .edgesIgnoringSafeArea(.all)
            HomeVCViewRepresentable().previewDevice(PreviewDevice(stringLiteral: "iPhone 8"))
                .edgesIgnoringSafeArea(.all)
        }
        
    }
}
#endif
