//
//  CollectionViewController.swift
//  Channel Change Guide
//
//  Created by DOMINGUEZ, LEO on 10/17/17.
//  Copyright © 2017 DOMINGUEZ, LEO. All rights reserved.
//

import Foundation
import UIKit

enum LoadMoreStatus {
    case loading
    case finished
    case haveMore
}


private let reuseIdentifier = "Cell"

class CollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    var channels: Array = [
        "amc",
        "cbs",
        "cnn",
        "csn",
        "espn",
        "fox"
    ]
    
    var channelKeyarts: [UIImage] = [
        #imageLiteral(resourceName: "keyart_amc"),
        #imageLiteral(resourceName: "keyart_cbs"),
        #imageLiteral(resourceName: "keyart_cnn"),
        #imageLiteral(resourceName: "keyart_csn"),
        #imageLiteral(resourceName: "keyart_espn"),
        #imageLiteral(resourceName: "keyart_fox")
    ]
    
    var channelLogos: [UIImage] = [
        #imageLiteral(resourceName: "logo_amc"),
        #imageLiteral(resourceName: "logo_cbs"),
        #imageLiteral(resourceName: "logo_cnn"),
        #imageLiteral(resourceName: "logo_csn"),
        #imageLiteral(resourceName: "logo_espn"),
        #imageLiteral(resourceName: "logo_fox")
    ]
    
    var channelTitles: Array = [
        "The Walking Dead",
        "The Talk",
        "State of the Union",
        "MIL vs SAC",
        "UCLA vs AZW",
        "Empire"
    ]
    
    var channelMetadatas: Array = [
        "S2 E7 | The Other Side",
        "S7 EP182 | Actress Salma Hayek",
        "S77 E2 | Gary Johnson",
        "2017",
        "2017",
        "S2 E3 | Bout that"
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        // self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
        
        self.collectionView?.isScrollEnabled = false

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return channels.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CollectionViewCell
    
        // Configure the cell
        /*
        let logo = UIImage(named: logos[indexPath.row])
        
        cell.imageView.image = logo
        */
        
        //let itemToShow = channels[indexPath.row % channels.count]
        // let cell = UICollectionViewCell() // setup cell with your item and return

        
        cell.keyartView.image = self.channelKeyarts[indexPath.row]
        cell.keyartView.contentMode = .scaleAspectFit
        
        cell.logoView.image = self.channelLogos[indexPath.row]
        cell.logoView.contentMode = .scaleAspectFit
        
        cell.titleView.text = self.channelTitles[indexPath.row]
        
        cell.metadataView.text = self.channelMetadatas[indexPath.row]
     
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView,
                                 didUpdateFocusIn context: UICollectionViewFocusUpdateContext,
                                 with coordinator: UIFocusAnimationCoordinator) {
        // As we are not using the default scrollable feature from the UIScrollView we can scroll ourself to the center of the focused cell
        
        if ((context.nextFocusedIndexPath != nil) && !collectionView.isScrollEnabled) {
            collectionView.scrollToItem(at: context.nextFocusedIndexPath!, at: UICollectionViewScrollPosition.centeredHorizontally, animated: true)
        }
    }
    
    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */
    
}










