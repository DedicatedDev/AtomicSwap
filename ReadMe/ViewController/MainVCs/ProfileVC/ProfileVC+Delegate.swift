//
//  ProfileVC+Delegate.swift
//  ReadMe
//
//  Created by FreeBird on 10/27/20.
//  Copyright © 2020 Jayesh. All rights reserved.
//

import UIKit

extension ProfileVC:UICollectionViewDataSource,UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: PostItemCell.reuseIdentifier(),
                for: indexPath) as! PostItemCell
            let image = images[indexPath.item]
            cell.imgView.image = image
            return cell
    }
    
 
    func collectionView(collectionView: UICollectionView, sizeForSectionHeaderViewForSection section: Int) -> CGSize {

        return header?.systemLayoutSizeFitting(CGSize(width: collectionView.frame.width, height: UIView.layoutFittingExpandedSize.height),
                                                      withHorizontalFittingPriority: .required, // Width is fixed
                                                      verticalFittingPriority: .fittingSizeLevel) ?? .init(width: collectionView.frame.width, height: 400)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch currentPageType {
        case .mine:
            header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: MainUserInfoCell.reuseIdentifier(), for: indexPath) as! MainUserInfoCell
            let myheader = header as! MainUserInfoCell
             myheader.onCalculated = {
                collectionView.collectionViewLayout.invalidateLayout()
            }
            return header ?? UICollectionReusableView()
        default:
            header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: OtherUserInfoCell.reuseIdentifier(), for: indexPath) as! OtherUserInfoCell
            let myheader = header as! OtherUserInfoCell
             myheader.onCalculated = {
                collectionView.collectionViewLayout.invalidateLayout()
            }
            return header ?? UICollectionReusableView()
        }

    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        coordinator?.openDetailedPost(with: datasource[indexPath.row])
        
    }
}


//MARK: PinterestLayoutDelegate
extension ProfileVC: PinterestLayoutDelegate {
    
    func collectionView(collectionView: UICollectionView,
                        heightForImageAtIndexPath indexPath: IndexPath,
                        withWidth: CGFloat) -> CGFloat {
        let image = images[indexPath.item]
        
        return image.height(forWidth: withWidth)
    }
    
    func collectionView(collectionView: UICollectionView,
                        heightForAnnotationAtIndexPath indexPath: IndexPath,
                        withWidth: CGFloat) -> CGFloat {
        return 0
    }
}
