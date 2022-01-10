//
//  FilterOptionView.swift
//  ReadMe
//
//  Created by FreeBird on 10/27/20.
//  Copyright © 2020 Jayesh. All rights reserved.
//

import UIKit

class FilterOptionView: UIView {
    let openBtn:UIButton = {
        let b = UIButton()
        b.translatesAutoresizingMaskIntoConstraints = false
        b.setTitleColor(#colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.9490196078, alpha: 1), for: .normal)
        b.titleLabel?.font = R.font.poppinsMedium(size: 14)
        b.setTitle("All", for: .normal)
        b.withHeight(29)
        b.backgroundColor = #colorLiteral(red: 0.4431372549, green: 0.462745098, blue: 0.6431372549, alpha: 0.9)
        b.layer.cornerRadius = 14.5
        b.contentEdgeInsets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 25)
        b.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        return b
    }()
    let currentOptionLbl:InsetLabel = {
        let l = InsetLabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = R.font.poppinsMedium(size: 14)
        l.textColor = #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.9490196078, alpha: 1)
        l.alpha = 0
        l.backgroundColor = #colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 0.5)
        l.layer.cornerRadius = 14.5
        l.clipsToBounds = true
        l.text = "Michigan of University"
        l.height(29)
        l.contentInsets = UIEdgeInsets(top: 0, left: 12, bottom:  0, right: 12)
        return l
    }()
    var items:[String] = ["All","Michigan State","Michigan of University"]
    let dropdownImgView:UIImageView = {
        let v = UIImageView(image: R.image.dropdown())
        v.translatesAutoresizingMaskIntoConstraints = false
      //  v.backgroundColor = .lightGray
        v.contentMode = .scaleAspectFill
        return v
    }()
    var options:[String] = []{
        didSet{
            itemBtns.removeAll()
            optionStack.safelyRemoveArrangedSubviews()
            options.forEach({
                let b = UIButton()
                b.titleLabel?.font = R.font.poppinsMedium(size: 14)
                b.setTitleColor(#colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.9490196078, alpha: 1), for: .normal)
                b.tag = tag
                b.setTitle($0, for: .normal)
                b.contentHorizontalAlignment = .left
                b.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
                b.addTarget(self, action: #selector(selectItem(sender:)), for: .touchUpInside)
                itemBtns.append(b)
                optionStack.addArrangedSubview(b)
                tag += 1
            })
        }
    }
    var itemBtns:[UIButton] = []
    let optionStack = UIStackView()
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        render()
        setupAction()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func render(){

        optionStack.translatesAutoresizingMaskIntoConstraints = false
        optionStack.axis = .vertical
        optionStack.spacing = 5
        optionStack.alignment = .fill
        optionStack.distribution = .fillEqually
        optionStack.backgroundColor = #colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 0.5)
        optionStack.layer.cornerRadius = 8
        optionStack.isUserInteractionEnabled = true
        optionStack.safelyRemoveArrangedSubviews()
        itemBtns.removeAll()
        optionStack.widthAnchor.constraint(greaterThanOrEqualToConstant: 180).isActive = true
        let headerStack = UIStackView(arrangedSubviews: [UIView(),openBtn])
        openBtn.widthAnchor.constraint(greaterThanOrEqualToConstant: 67).isActive = true
        headerStack.translatesAutoresizingMaskIntoConstraints = false
        headerStack.spacing = 0
        headerStack.alignment = .fill
        headerStack.distribution = .fill
        
        let totalStack = UIStackView(arrangedSubviews: [headerStack,optionStack])
        totalStack.translatesAutoresizingMaskIntoConstraints = false
        totalStack.axis = .vertical
        totalStack.spacing = 10
        totalStack.alignment = .fill
        totalStack.distribution = .fill
        totalStack.isUserInteractionEnabled = true
        addSubview(totalStack)
        totalStack.fillSuperview()
        openBtn.addSubview(dropdownImgView)
        dropdownImgView.centerVertically()
        dropdownImgView.right(10)
        
        addSubview(currentOptionLbl)
        currentOptionLbl.anchor(top: openBtn.bottomAnchor, leading: nil, bottom: nil, trailing: openBtn.trailingAnchor,padding: UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0))
    }
    
    func setupAction(){
        openBtn.addTarget(self, action: #selector(openDropDwon), for: .touchUpInside)
    }
    @objc func openDropDwon(){
        currentOptionLbl.alpha = 0
        if itemBtns.count == 0{
            options = items
        }else{
            options.removeAll()
        }
    }
    
    @objc func selectItem(sender:UIButton){
        openBtn.setTitle(sender.currentTitle, for: .normal)
        if sender.currentTitle == "All"{
            currentOptionLbl.text = items[1]
            currentOptionLbl.alpha = 1
        }else{
            currentOptionLbl.alpha = 0
        }
        options.removeAll()
    }
}

#if canImport(SwiftUI) && DEBUG
import SwiftUI

struct FilterOptionViewRepresentable: UIViewRepresentable {

    func makeUIView(context: Context) -> UIView {
      
        return FilterOptionView()
    }

    func updateUIView(_ view: UIView, context: Context) {

    }
}

@available(iOS 13.0, *)
struct FilterOptionViewController_Preview: PreviewProvider {
    static var previews: some View {
        
        FilterOptionViewRepresentable().previewLayout(.fixed(width: 375, height: 200))
    }
}

#endif
