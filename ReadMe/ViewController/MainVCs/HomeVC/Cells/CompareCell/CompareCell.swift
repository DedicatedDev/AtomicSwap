//
//  CompareCell.swift
//  ReadMe
//
//  Created by FreeBird on 10/26/20.
//  Copyright © 2020 Jayesh. All rights reserved.
//

import UIKit

class CompareCell: UICollectionViewCell {
    let rightView:ElectionImgView = {
        let l = ElectionImgView()
        l.tag = 0
        l.translatesAutoresizingMaskIntoConstraints = false
        l.imgView.image = #imageLiteral(resourceName: "rightCompareImg")
        return l
    }()
    
    let leftView:ElectionImgView = {
        let l = ElectionImgView()
        l.tag = 1
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    let electionResultView:ElectionResultView = {
        let v = ElectionResultView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    let electionTitleLbl:UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = R.font.poppinsMedium(size: 18)
        l.backgroundColor = .white
        l.layer.cornerRadius = 8
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        paragraphStyle.lineHeightMultiple = 1
        l.textAlignment = .center
        l.numberOfLines = 0
        l.attributedText = NSMutableAttributedString(string: "Which one makes me look\n younger?", attributes: [NSAttributedString.Key.kern: -0.17, NSAttributedString.Key.paragraphStyle: paragraphStyle,NSAttributedString.Key.foregroundColor:UIColor.primaryTextColor])
        l.setupShadow(opacity: 1.0, radius: 8, offset: CGSize(width: 0, height: 1), color: UIColor(red: 0.49, green: 0.537, blue: 0.704, alpha: 0.18))
        l.minimumScaleFactor = 0.2
        l.adjustsFontSizeToFitWidth = true
        return l
    }()
    
    let vsLbl:UILabel = {
        let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .white
        v.alpha = 0.8
        v.textAlignment = .center
        v.text = "vs"
        v.textColor = .primaryTextColor
        v.font = R.font.poppinsMedium(size: 14)
        v.withSize(CGSize(width: 46, height: 37))
        v.layer.cornerRadius = 4
        v.clipsToBounds = true
        return v
    }()
    
    let headerView:HeaderView = {
        let v = HeaderView()
        v.profileNameLbl.textColor = .primaryTextColor
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    var electionTopic:String?{
        didSet{
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineHeightMultiple = 1
            paragraphStyle.alignment = .center
            
            electionTitleLbl.attributedText = NSMutableAttributedString(string: "Which one makes me look\n younger?", attributes: [NSAttributedString.Key.kern: -0.17, NSAttributedString.Key.paragraphStyle: paragraphStyle,NSAttributedString.Key.foregroundColor:UIColor.primaryTextColor])
        }
    }
    
    let filterOptionView:FilterOptionView = {
        let v = FilterOptionView()
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
        backgroundColor = .mainBgColor

        
//        electionStack.heightAnchor.constraint(equalToConstant: 450.adjustedh).isActive = true
        
        contentView.addSubview(electionResultView)
        electionResultView.anchor(top: nil, leading: contentView.leadingAnchor, bottom: contentView.bottomAnchor, trailing: contentView.trailingAnchor, padding: UIEdgeInsets(top: 0, left: 16, bottom: 16, right: 16))
        electionResultView.height(25)
        
//
        contentView.addSubview(electionTitleLbl)
        electionTitleLbl.anchor(top: nil, leading: contentView.leadingAnchor, bottom: electionResultView.topAnchor, trailing: contentView.trailingAnchor, padding: UIEdgeInsets(top: 30.adjustedh, left: 15, bottom: 36.adjustedh, right: 15))
        
        electionTitleLbl.setContentHuggingPriority(.defaultHigh, for: .vertical)
        let electionStack = UIStackView(arrangedSubviews: [leftView,rightView])
        electionStack.translatesAutoresizingMaskIntoConstraints = false
        electionStack.alignment = .fill
        electionStack.axis = .horizontal
        electionStack.distribution = .fillEqually
        contentView.addSubview(electionStack)
        electionStack.anchor(top: contentView.topAnchor, leading: contentView.leadingAnchor, bottom: electionTitleLbl.topAnchor, trailing: contentView.trailingAnchor,padding: UIEdgeInsets(top: 64, left: 0, bottom: 30.adjustedh, right: 0))
        electionStack.withHeight(415.adjustedh)
        
        contentView.addSubview(vsLbl)
        vsLbl.centerYTo(leftView.imgView.centerYAnchor)
        vsLbl.centerXTo(centerXAnchor)
        
        contentView.addSubview(headerView)
        headerView.anchor(top: contentView.topAnchor, leading: contentView.leadingAnchor, bottom: nil, trailing: contentView.trailingAnchor,padding: UIEdgeInsets(top: 8, left: 16, bottom: 0, right: 16))
        headerView.height(40)
        
        contentView.addSubview(filterOptionView)
        filterOptionView.anchor(top: contentView.topAnchor, leading: nil, bottom: nil, trailing: contentView.trailingAnchor,padding: UIEdgeInsets(top: 8, left: 0, bottom: 0, right: 16))
        
        filterOptionView.currentOptionLbl.text = "Michigan State"
        filterOptionView.currentOptionLbl.alpha = 1
    }
    
    func addAction(){
        rightView.delegate = self
        leftView.delegate = self
    }
}



#if canImport(SwiftUI) && DEBUG
import SwiftUI

struct CompareCellRepresentable: UIViewRepresentable {

    func makeUIView(context: Context) -> UIView {
      
        return CompareCell()
    }

    func updateUIView(_ view: UIView, context: Context) {

    }
}

@available(iOS 13.0, *)
struct PlaceReportCellController_Preview: PreviewProvider {
    static var previews: some View {
        
        CompareCellRepresentable().previewLayout(.fixed(width: 375, height: 672))
    }
}

#endif


