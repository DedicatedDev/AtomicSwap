//
//  HomeVC+Delegate.swift
//  ReadMe
//
//  Created by FreeBird on 10/26/20.
//  Copyright © 2020 Jayesh. All rights reserved.
//

import UIKit
extension HomeVC:UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{


    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
       // datasource.count
        return datasource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch datasource[indexPath.row]{
        case .answerChoice(let vm):
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AnswerChoiceCell.reuseIdentifier(), for: indexPath) as! AnswerChoiceCell
            cell.vm = vm
            cell.headerView.delegate = self
            return cell
        case .compare(let vm):
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CompareCell.reuseIdentifier(), for: indexPath) as! CompareCell
            cell.headerView.delegate = self
            return cell
        case .rate(let vm):
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RateCell.reuseIdentifier(), for: indexPath) as! RateCell
            cell.headerView.delegate = self
            return cell
        }
       
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.bounds.size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
     
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        collectionView.collectionViewLayout.invalidateLayout()
    }
    
}

extension HomeVC:OpenOthersProfileDelegate{
    func openOtherProfile() {
        coordinator?.openOthersProfile()
    }
    
    
}
