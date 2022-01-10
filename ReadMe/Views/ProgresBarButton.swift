//
//  ProgresBarButton.swift
//  ReadMe
//
//  Created by FreeBird on 10/27/20.
//  Copyright © 2020 Jayesh. All rights reserved.
//

import UIKit

class ProgressBarButton: UIButton {
    var isActive:Bool = true
    var buttonStatus:ElectionType = .deselect
    private let backView:UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.isUserInteractionEnabled = false
      //  v.backgroundColor = #colorLiteral(red: 0.2941176471, green: 0.2588235294, blue: 0.5921568627, alpha: 1)
        return v
    }()
    
    private let progressView:UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.layer.cornerRadius = 19
        v.isUserInteractionEnabled = false
        return v
    }()
    
    private let progressValueLbl:UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = R.font.poppinsMedium(size: 14)
        l.textColor = .white
        l.textAlignment = .left
        return l
    }()
    var progressWidthAnchor:NSLayoutConstraint?
    override init(frame: CGRect) {
        super.init(frame: frame)
        render()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func render(){
        backView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(backView)
        backView.fillSuperview()
        addSubview(progressView)
        
        progressView.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: nil)
        progressWidthAnchor = progressView.widthAnchor.constraint(equalToConstant: 0)
        progressWidthAnchor?.isActive = true
        addSubview(progressValueLbl)
        progressValueLbl.centerVertically()
        progressValueLbl.left(16)
    }
    
    func setProgress(progress :CGFloat){
        progressValueLbl.text = "\(progress * 100)%"
        progressWidthAnchor?.isActive = false
        UIView.animate(withDuration: 0.5) {
            let totalWidth:CGFloat = self.frame.width == 0 ? 311.adjusted : self.frame.width
    
            self.progressWidthAnchor?.constant = totalWidth*progress
            self.progressWidthAnchor?.isActive = true
            self.changeTheme(with: self.buttonStatus)
        }
    }
    
    private func changeTheme(with status:ElectionType){
        switch status{
        case .selected:
            backView.backgroundColor = #colorLiteral(red: 0.2941176471, green: 0.2588235294, blue: 0.5921568627, alpha: 1)
            progressView.backgroundColor = #colorLiteral(red: 0.2352941176, green: 0.2078431373, blue: 0.4745098039, alpha: 1)
            progressValueLbl.textColor = .white
            setTitleColor(.white, for: .normal)
        case .deselect:
            backView.backgroundColor = .clear
            progressView.backgroundColor = .clear
            progressValueLbl.textColor = .clear
            setTitleColor(.primaryTextColor, for: .normal)
        case .isSelected:
            backView.backgroundColor = #colorLiteral(red: 0.9254901961, green: 0.9294117647, blue: 0.9607843137, alpha: 1)
            progressView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.05)
            progressValueLbl.textColor = .primaryTextColor
            setTitleColor(.primaryTextColor, for: .normal)
            
        }
    }
    
    
}

#if canImport(SwiftUI) && DEBUG
import SwiftUI

struct ProgressBarButtonRepresentable: UIViewRepresentable {

    func makeUIView(context: Context) -> UIView {
      
        return ProgressBarButton()
    }

    func updateUIView(_ view: UIView, context: Context) {

    }
}

@available(iOS 13.0, *)
struct ProgressBarButtonController_Preview: PreviewProvider {
    static var previews: some View {
        
        ProgressBarButtonRepresentable().previewLayout(.fixed(width: 375, height: 100))
    }
}

#endif


