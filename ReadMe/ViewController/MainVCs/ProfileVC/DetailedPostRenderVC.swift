//
//  DetailedPostRenderVC.swift
//  ReadMe
//
//  Created by FreeBird on 10/27/20.
//  Copyright © 2020 Jayesh. All rights reserved.
//

import UIKit

class DetailedPostRenderVC: UIViewController {
    weak var coordinator:ProfileCoordinator?
    var data:QuestionType = .compare(CompareCellVM())
    override func viewDidLoad() {
        super.viewDidLoad()
        render(with: data)
    }
    

    func render(with dataType:QuestionType){
        
        let leftBtn = UIButton()
        leftBtn.setImage(R.image.backArrow(), for: .normal)
        leftBtn.frame = CGRect(x: 0, y: 0, width: 100, height: 44)
        leftBtn.setTitle("Profile", for: .normal)
        leftBtn.contentHorizontalAlignment = .left
        leftBtn.titleLabel?.font = R.font.poppinsMedium(size: 14)
        leftBtn.setTitleColor(.primaryTextColor, for: .normal)
        leftBtn.titleEdgeInsets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftBtn)
        leftBtn.addTarget(self, action:#selector(popVC), for: .touchUpInside)
        
        view.backgroundColor = .mainBgColor
        var subView = UIView()
        switch dataType{
        case .compare(_):
            subView = CompareCell()
        case .ansChoice(let vm):
            let tempV = AnswerChoiceCell()
            tempV.vm = vm
            tempV.cellDiplayMode = .result
            subView = tempV
        case .rate(_):
            subView = RateCell()
        }
        
        view.addSubview(subView)
        subView.fillSuperviewSafeAreaLayoutGuide()
    }
    
    @objc func popVC(){
        navigationController?.popViewController(animated: true)
    }
}
