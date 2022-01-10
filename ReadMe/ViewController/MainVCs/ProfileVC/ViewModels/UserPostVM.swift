//
//  UserPostViewModel.swift
//  ReadMe
//
//  Created by FreeBird on 10/27/20.
//  Copyright © 2020 Jayesh. All rights reserved.
//

import UIKit

enum QuestionType {
    case compare(CompareCellVM)
    case ansChoice(AnswerChoiceCellVM)
    case rate(RateImgVM)
}

struct UserPostVM {
    let postId:Int?
    let image:UIImage?
    let imagUrl:URL?
    let questionType:QuestionType
}
