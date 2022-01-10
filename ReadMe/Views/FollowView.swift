//
//  FollowView.swift
//  ReadMe
//
//  Created by FreeBird on 10/27/20.
//  Copyright © 2020 Jayesh. All rights reserved.
//

import UIKit
class FollowView: UIView {
    
    var caption:String?{
        didSet{
            captionLbl.text = caption
        }
    }
    var value:String?{
        didSet{
            valueLbl.text = value
        }
    }
    
    var isHiddenValueLbl:Bool = false{
        didSet{
            valueLbl.isHidden = isHiddenValueLbl
        }
    }
    var valueColor:UIColor?{
        didSet{
            valueLbl.textColor = valueColor
        }
    }
    
    private let captionLbl:UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = R.font.poppinsBold(size: 16)
        l.textColor = .primaryTextColor
        return l
    }()
    
    private let valueLbl:UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = R.font.poppinsRegular(size: 12)
        l.textColor = .primaryTextColor
        return l
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView(){
        stack(captionLbl,valueLbl, spacing: 5, alignment:.center, distribution: .fill).isUserInteractionEnabled = true
    }
    
}
