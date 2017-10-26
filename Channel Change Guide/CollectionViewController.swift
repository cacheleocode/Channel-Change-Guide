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
    
    
    let channelArrays = Array(repeating: [
        "amc",
        "cbs",
        "cnn",
        "csn",
        "espn",
        "fox"
        ], count: 50)
    
    var channels = [String]()
    
    let channelKeyartArrays = Array(repeating: [
        "keyart_amc",
        "keyart_cbs",
        "keyart_cnn",
        "keyart_csn",
        "keyart_espn",
        "keyart_fox"
        ], count: 50)
    
    var channelKeyarts = [String]()
    
    let channelLogoArrays = Array(repeating: [
        "logo_amc",
        "logo_cbs",
        "logo_cnn",
        "logo_csn",
        "logo_espn",
        "logo_fox"
        ], count: 50)
    
    var channelLogos = [String]()
    
    var channelTitleArrays = Array(repeating: [
        "The Walking Dead",
        "The Talk",
        "State of the Union",
        "MIL vs SAC",
        "UCLA vs AZW",
        "Empire"
    ], count: 50)
    
    var channelTitles = [String]()
    
    var channelMetadataArrays = Array(repeating: [
        "S2 E7 | The Other Side",
        "S7 EP182 | Actress Salma Hayek",
        "S77 E2 | Gary Johnson",
        "2017",
        "2017",
        "S2 E3 | Bout that"
    ], count: 50)
    
    var channelMetadatas = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        // self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
        
        self.collectionView?.isScrollEnabled = false
        
        for array in channelArrays {
            channels += array
        }
        
        for array in channelKeyartArrays {
            channelKeyarts += array
        }
        
        for array in channelLogoArrays {
            channelLogos += array
        }
        
        for array in channelTitleArrays {
            channelTitles += array
        }
        
        for array in channelMetadataArrays {
            channelMetadatas += array
        }
        
        // self.collectionView?.scrollToItem(at:IndexPath(item: (channels.count / 2) - 1, section: 0), at: .right, animated: false)
        
        // self.collectionView?.scrollToItem(at: IndexPath(item: 149, section: 0), at: .centeredHorizontally, animated: true)
        
        /*
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        let width = UIScreen.main.bounds.width
        layout.sectionInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        layout.itemSize = CGSize(width: width / 5, height: width / 5)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        collectionView!.collectionViewLayout = layout
        */
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
        debugPrint(channels.count)
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
        
        // cell.keyartView.image = self.channelKeyarts[indexPath.row]
        cell.keyartView.image = UIImage(named: String(describing: self.channelKeyarts[indexPath.row]))
        cell.keyartView.contentMode = .scaleAspectFit
        
        
        // cell.logoView.image = self.channelLogos[indexPath.row]
        cell.logoView.image = UIImage(named: String(describing: self.channelLogos[indexPath.row]))
        cell.logoView.contentMode = .scaleAspectFit
        
        // cell.titleView.text = self.channelTitles[indexPath.row]
        cell.titleView.text = String(describing: self.channelTitles[indexPath.row])
        
        // cell.metadataView.text = self.channelMetadatas[indexPath.row]
        cell.metadataView.text = String(describing: self.channelMetadatas[indexPath.row])
        
        cell.alpha = 0.4
     
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView,
                                 didUpdateFocusIn context: UICollectionViewFocusUpdateContext,
                                 with coordinator: UIFocusAnimationCoordinator) {
        // As we are not using the default scrollable feature from the UIScrollView we can scroll ourself to the center of the focused cell
        
        if ((context.nextFocusedIndexPath != nil) && !collectionView.isScrollEnabled) {  
            collectionView.scrollToItem(at: context.nextFocusedIndexPath!, at: UICollectionViewScrollPosition.centeredHorizontally, animated: true)
        
            // collectionView.cellForItem(at: context.nextFocusedIndexPath!)?.frame = CGRect(x: 0, y: 0, width: 990, height: 500)
        }
        
        if (context.previouslyFocusedIndexPath != nil) {
            
            
            UIView.animate(withDuration: 0.3, animations: {
                collectionView.cellForItem(at: context.previouslyFocusedIndexPath!)?.alpha = 0.4
                // collectionView.cellForItem(at: context.previouslyFocusedIndexPath!)?.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
                
            }, completion: nil)
        }
        
        if (context.nextFocusedIndexPath != nil) {
            UIView.animate(withDuration: 0.3, animations: {
                collectionView.cellForItem(at: context.nextFocusedIndexPath!)?.alpha = 1.0
                // collectionView.cellForItem(at: context.nextFocusedIndexPath!)?.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
                
            }, completion: nil)
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.collectionView?.scrollToItem(at: IndexPath(row: 149, section: 0), at: UICollectionViewScrollPosition.centeredHorizontally, animated: false)
        debugPrint("didappear")
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        debugPrint("did select")
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












