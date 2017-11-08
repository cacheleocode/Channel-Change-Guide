//
//  CollectionViewCell.swift
//  Channel Change Guide
//
//  Created by DOMINGUEZ, LEO on 10/17/17.
//  Copyright © 2017 DOMINGUEZ, LEO. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    @IBOutlet fileprivate weak var collectionView: UICollectionView!
    @IBOutlet weak var keyartView: UIImageView!
    @IBOutlet weak var pipView: UIView!
    @IBOutlet weak var titleView: UILabel!
    @IBOutlet weak var logoView: UIImageView!
    @IBOutlet weak var metadataView: UILabel!
    @IBOutlet weak var gradientView: UIImageView!
    @IBOutlet weak var badgeView: UIImageView!
    @IBOutlet weak var timeView: UILabel!
    @IBOutlet weak var durationView: UILabel!
}

extension CollectionViewCell {
    var collectionViewOffset: CGFloat {
        set { collectionView.contentOffset.x = newValue }
        get { return collectionView.contentOffset.x }
    }
}
