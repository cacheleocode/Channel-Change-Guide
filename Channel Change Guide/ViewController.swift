import UIKit
import AVFoundation

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var videoView: UIView!
    @IBOutlet weak var overlayView: UIView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var channelName: UILabel!
    @IBOutlet weak var collectionView: CollectionView!
    
    let queue = DispatchQueue(label: "queue", attributes: .concurrent)
    
    var playerLayer: AVPlayerLayer?
    var playerLayerCBS: AVPlayerLayer?
    var playerLayerCNN: AVPlayerLayer?
    var playerLayerCSN: AVPlayerLayer?
    var playerLayerESPN: AVPlayerLayer?
    var playerLayerFOX: AVPlayerLayer?
    var playerLayerHBO: AVPlayerLayer?
    var playerLayerHSN: AVPlayerLayer?
    
    var guideLayer: CALayer?
    var guideLayerCBS: CALayer?
    var guideLayerCNN: CALayer?
    var guideLayerCSN: CALayer?
    var guideLayerESPN: CALayer?
    var guideLayerFOX: CALayer?
    var guideLayerHBO: CALayer?
    var guideLayerHSN: CALayer?
    
    var direction = ""
    
    var resetOrigin: CGFloat?
    
    var resetIndex = 0

    var pendingTask: DispatchWorkItem?
    var pendingTask2: DispatchWorkItem?
    
    var pageViewController: PageViewController? {
        didSet {
            pageViewController?.gotDelegate = self
        }
    }
    
    var currentCellIndex: Int?
    
    /*******************************************************/
    
    let channelArrays = Array(repeating: [
        "amc",
        "cbs",
        "cnn",
        "csn",
        "espn",
        "fox"
        ], count: 50)
    
    let channelKeyartArrays = Array(repeating: [
        "keyart_amc",
        "keyart_cbs",
        "keyart_cnn",
        "keyart_csn",
        "keyart_espn",
        "keyart_fox"
        ], count: 50)
    
    let channelLogoArrays = Array(repeating: [
        "logo_amc",
        "logo_cbs",
        "logo_cnn",
        "logo_csn",
        "logo_espn",
        "logo_fox"
        ], count: 50)
    
    var channelTitleArrays = Array(repeating: [
        "The Walking Dead",
        "The Talk",
        "State of the Union",
        "MIL vs SAC",
        "UCLA vs AZW",
        "Empire"
        ], count: 50)
    
    var channelMetadataArrays = Array(repeating: [
        "S2 E7 | The Other Side",
        "S7 EP182 | Actress Salma Hayek",
        "S77 E2 | Gary Johnson",
        "2017",
        "2017",
        "S2 E3 | Bout that"
        ], count: 50)
    
    var channels = [String]()
    var channelKeyarts = [String]()
    var channelLogos = [String]()
    var channelTitles = [String]()
    var channelMetadatas = [String]()
    
    /*******************************************************/
    
    
    fileprivate let cellItems = [
        "amc",
        "cbs",
        "cnn",
        "csn",
        "espn",
        "fox"
    ]
    
    var logoImages: [UIImage] = [#imageLiteral(resourceName: "logo_amc"),#imageLiteral(resourceName: "logo_cbs"),#imageLiteral(resourceName: "logo_cnn"),#imageLiteral(resourceName: "logo_csn"),#imageLiteral(resourceName: "logo_espn"),#imageLiteral(resourceName: "logo_fox")]
    
    var channelTitle: Array = [
        "The Walking Dead",
        "The Talk",
        "State of the Union",
        "MIL vs SAC",
        "UCLA vs AZW",
        "Empire"
    ]
    
    var channelDescription: Array = [
        "S2 E7 | The Other Side",
        "S7 EP182 | Actress Salma Hayek",
        "S77 E2 | Gary Johnson",
        "2017",
        "2017",
        "S2 E3 | Bout that"
    ]
    
    var randomNum: UInt32?
    var someInt: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        (UIApplication.shared as! MyApplication).myVC = self
        
        // video player AMC
        guard let path = Bundle.main.path(forResource: "amc", ofType:"mp4") else {
            debugPrint("video not found")
            return
        }
        
        let player = AVPlayer(url: URL(fileURLWithPath: path))
        
        playerLayer = AVPlayerLayer(player: player)
        playerLayer?.videoGravity = AVLayerVideoGravityResizeAspectFill
        playerLayer!.frame = self.videoView.frame
        playerLayer?.isHidden = false
        
        NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: player.currentItem, queue: nil, using: { (_) in
            DispatchQueue.main.async {
                player.seek(to: kCMTimeZero)
                player.play()
            }
        })
        
        player.isMuted = false;
        player.play()
        
        self.videoView.layer.addSublayer(playerLayer!)
        
        // video player CBS
        guard let pathCBS = Bundle.main.path(forResource: "cbs", ofType:"mp4") else {
            debugPrint("video not found")
            return
        }
        
        let playerCBS = AVPlayer(url: URL(fileURLWithPath: pathCBS))
        
        playerLayerCBS = AVPlayerLayer(player: playerCBS)
        playerLayerCBS?.videoGravity = AVLayerVideoGravityResizeAspectFill
        playerLayerCBS!.frame = self.videoView.frame
        playerLayerCBS?.isHidden = true
        
        self.videoView.layer.addSublayer(playerLayerCBS!)
        
        NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: playerCBS.currentItem, queue: nil, using: { (_) in
            DispatchQueue.main.async {
                playerCBS.seek(to: kCMTimeZero)
                playerCBS.play()
            }
        })
        
        playerCBS.isMuted = true;
        playerCBS.play()
 
        // video player CNN
        guard let pathCNN = Bundle.main.path(forResource: "cnn", ofType:"mp4") else {
            debugPrint("video not found")
            return
        }
        
        let playerCNN = AVPlayer(url: URL(fileURLWithPath: pathCNN))
        
        playerLayerCNN = AVPlayerLayer(player: playerCNN)
        playerLayerCNN?.videoGravity = AVLayerVideoGravityResizeAspectFill
        playerLayerCNN!.frame = self.videoView.frame
        playerLayerCNN?.isHidden = true
        
        self.videoView.layer.addSublayer(playerLayerCNN!)
        
        NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: playerCNN.currentItem, queue: nil, using: { (_) in
            DispatchQueue.main.async {
                playerCNN.seek(to: kCMTimeZero)
                playerCNN.play()
            }
        })
        
        playerCNN.isMuted = true;
        playerCNN.play()
        
        // video player CSN
        guard let pathCSN = Bundle.main.path(forResource: "csn", ofType:"mp4") else {
            debugPrint("video not found")
            return
        }
        
        let playerCSN = AVPlayer(url: URL(fileURLWithPath: pathCSN))
        
        playerLayerCSN = AVPlayerLayer(player: playerCSN)
        playerLayerCSN?.videoGravity = AVLayerVideoGravityResizeAspectFill
        playerLayerCSN!.frame = self.videoView.frame
        playerLayerCSN?.isHidden = true
        
        self.videoView.layer.addSublayer(playerLayerCSN!)
        
        NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: playerCSN.currentItem, queue: nil, using: { (_) in
            DispatchQueue.main.async {
                playerCSN.seek(to: kCMTimeZero)
                playerCSN.play()
            }
        })
        
        playerCSN.isMuted = true;
        playerCSN.play()
        
        // video player ESPN
        guard let pathESPN = Bundle.main.path(forResource: "espn", ofType:"mp4") else {
            debugPrint("video not found")
            return
        }
        
        let playerESPN = AVPlayer(url: URL(fileURLWithPath: pathESPN))
        
        playerLayerESPN = AVPlayerLayer(player: playerESPN)
        playerLayerESPN?.videoGravity = AVLayerVideoGravityResizeAspectFill
        playerLayerESPN!.frame = self.videoView.frame
        playerLayerESPN?.isHidden = true
        
        self.videoView.layer.addSublayer(playerLayerESPN!)
        
        NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: playerESPN.currentItem, queue: nil, using: { (_) in
            DispatchQueue.main.async {
                playerESPN.seek(to: kCMTimeZero)
                playerESPN.play()
            }
        })
        
        playerESPN.isMuted = true;
        playerESPN.play()
        
        // video player FOX
        guard let pathFOX = Bundle.main.path(forResource: "fox", ofType:"mp4") else {
            debugPrint("video not found")
            return
        }
        
        let playerFOX = AVPlayer(url: URL(fileURLWithPath: pathFOX))
        
        playerLayerFOX = AVPlayerLayer(player: playerFOX)
        playerLayerFOX?.videoGravity = AVLayerVideoGravityResizeAspectFill
        playerLayerFOX!.frame = self.videoView.frame
        playerLayerFOX?.isHidden = true
        
        self.videoView.layer.addSublayer(playerLayerFOX!)
        
        NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: playerFOX.currentItem, queue: nil, using: { (_) in
            DispatchQueue.main.async {
                playerFOX.seek(to: kCMTimeZero)
                playerFOX.play()
            }
        })
        
        playerFOX.isMuted = true;
        playerFOX.play()

        // resume playback upon app focus
        NotificationCenter.default.addObserver(self, selector: #selector(appWillEnterForegroundNotification), name: .UIApplicationWillEnterForeground, object: nil)
        
        // add target
        
        pageControl.addTarget(self, action: #selector(ViewController.didChangePageControlValue), for: .valueChanged)
        
        // tap detection
        // let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.respondToTapGesture))
        // self.view.addGestureRecognizer(tapGesture)
        
        // overlay view
        
        self.overlayView.alpha = 0.0
        
        // gradient layer
        
        let gradientLayer = CAGradientLayer()

        gradientLayer.frame = CGRect(x: 0, y: 780, width: 1920, height: 300)
        gradientLayer.colors = [UIColor.black.withAlphaComponent(0.5), UIColor.black.cgColor]
        gradientLayer.locations = [0.0, 1.0]
        
        self.overlayView.layer.insertSublayer(gradientLayer, at: 4)
        
        // initial appearance
                
        // Collection View
        self.collectionView.isScrollEnabled = false
        self.collectionView.alpha = 0.0
        
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
        
        // Page View Controller
        self.pageViewController?.view.frame = CGRect(x: 0, y: 0, width: 1920, height: 1080)
        self.pageViewController?.view.bounds = CGRect(x: 0, y: 600, width: 1000, height: 500)
        self.pageViewController?.view.clipsToBounds = false
        
        
        // [self.collectionView scrollToItemAtIndexPath:self.indexPathFromVC atScrollPosition:UICollectionViewScrollPositionNone animated:NO]
    }
    
    func appWillEnterForegroundNotification() {
        playerLayer?.player?.play()
        playerLayerCBS?.player?.play()
        playerLayerCNN?.player?.play()
        playerLayerCSN?.player?.play()
        playerLayerESPN?.player?.play()
        playerLayerFOX?.player?.play()
    }
    
    func doRestartTimer() {
        pendingTask2 = DispatchWorkItem {
            self.doHide()
        }
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .milliseconds(6000), execute: self.pendingTask2!)
    }
    
    func doInvalidateTimer() {
        pendingTask2?.cancel()
        
        self.doShow(index: self.resetIndex)
    }
    
    func doShow(index: Int) {
        pendingTask = DispatchWorkItem {
            // animate preview in
            UIView.animate(withDuration: 0.3, animations: {
                self.overlayView.alpha = 1.0
                self.collectionView?.alpha = 1.0
            }, completion: nil)
        }
        
        DispatchQueue.main.async(execute: self.pendingTask!)
    }
    
    func doHide() {
        UIView.animate(withDuration: 0.3, animations: {
            self.overlayView.alpha = 0.0
            self.collectionView.alpha = 0.0
        }, completion: { (finished: Bool) in
            // something
        })
    }
    
    /*
    func respondToTapGesture(gesture: UITapGestureRecognizer) {
        
    }
    */
    
    func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {

            switch swipeGesture.direction {
            case UISwipeGestureRecognizerDirection.right:
                direction = "right"
                
                self.doShow(index: self.resetIndex)
                
            case UISwipeGestureRecognizerDirection.down:
                debugPrint("Swiped down")
            case UISwipeGestureRecognizerDirection.left:
                direction = "left"
                
                self.doShow(index: self.resetIndex)
                
            case UISwipeGestureRecognizerDirection.up:
                debugPrint("Swiped up")
            default:
                break
            }
        }
    }
    
    func doChannelChange(channel: String) {
        switch channel {
        case "amc":
            playerLayer?.player?.isMuted = false
            playerLayer?.isHidden = false
            guideLayer?.isHidden = false
            
            playerLayerCBS?.player?.isMuted = true
            playerLayerCBS?.isHidden = true
            guideLayerCBS?.isHidden = true
            
            playerLayerCNN?.player?.isMuted = true
            playerLayerCNN?.isHidden = true
            guideLayerCNN?.isHidden = true
            
            playerLayerCSN?.player?.isMuted = true
            playerLayerCSN?.isHidden = true
            guideLayerCSN?.isHidden = true
            
            playerLayerESPN?.player?.isMuted = true
            playerLayerESPN?.isHidden = true
            guideLayerESPN?.isHidden = true
            
            playerLayerFOX?.player?.isMuted = true
            playerLayerFOX?.isHidden = true
            guideLayerFOX?.isHidden = true
            
        case "cbs":
            playerLayer?.player?.isMuted = true
            playerLayer?.isHidden = true
            guideLayer?.isHidden = true
            
            playerLayerCBS?.player?.isMuted = false
            playerLayerCBS?.isHidden = false
            guideLayerCBS?.isHidden = false
            
            playerLayerCNN?.player?.isMuted = true
            playerLayerCNN?.isHidden = true
            guideLayerCNN?.isHidden = true
            
            playerLayerCSN?.player?.isMuted = true
            playerLayerCSN?.isHidden = true
            guideLayerCSN?.isHidden = true
            
            playerLayerESPN?.player?.isMuted = true
            playerLayerESPN?.isHidden = true
            guideLayerESPN?.isHidden = true
            
            playerLayerFOX?.player?.isMuted = true
            playerLayerFOX?.isHidden = true
            guideLayerFOX?.isHidden = true
        
        case "cnn":
            playerLayer?.player?.isMuted = true
            playerLayer?.isHidden = true
            guideLayer?.isHidden = true
            
            playerLayerCBS?.player?.isMuted = true
            playerLayerCBS?.isHidden = true
            guideLayerCBS?.isHidden = true
            
            playerLayerCNN?.player?.isMuted = false
            playerLayerCNN?.isHidden = false
            guideLayerCNN?.isHidden = false
            
            playerLayerCSN?.player?.isMuted = true
            playerLayerCSN?.isHidden = true
            guideLayerCSN?.isHidden = true
            
            playerLayerESPN?.player?.isMuted = true
            playerLayerESPN?.isHidden = true
            guideLayerESPN?.isHidden = true
            
            playerLayerFOX?.player?.isMuted = true
            playerLayerFOX?.isHidden = true
            guideLayerFOX?.isHidden = true
            
        case "csn":
            playerLayer?.player?.isMuted = true
            playerLayer?.isHidden = true
            guideLayer?.isHidden = true
            
            playerLayerCBS?.player?.isMuted = true
            playerLayerCBS?.isHidden = true
            guideLayerCBS?.isHidden = true
            
            playerLayerCNN?.player?.isMuted = true
            playerLayerCNN?.isHidden = true
            guideLayerCNN?.isHidden = true
            
            playerLayerCSN?.player?.isMuted = false
            playerLayerCSN?.isHidden = false
            guideLayerCSN?.isHidden = false
            
            playerLayerESPN?.player?.isMuted = true
            playerLayerESPN?.isHidden = true
            guideLayerESPN?.isHidden = true
            
            playerLayerFOX?.player?.isMuted = true
            playerLayerFOX?.isHidden = true
            guideLayerFOX?.isHidden = true
            
        case "espn":
            playerLayer?.player?.isMuted = true
            playerLayer?.isHidden = true
            guideLayer?.isHidden = true
            
            playerLayerCBS?.player?.isMuted = true
            playerLayerCBS?.isHidden = true
            guideLayerCBS?.isHidden = true
            
            playerLayerCNN?.player?.isMuted = true
            playerLayerCNN?.isHidden = true
            guideLayerCNN?.isHidden = true
            
            playerLayerCSN?.player?.isMuted = true
            playerLayerCSN?.isHidden = true
            guideLayerCSN?.isHidden = true
            
            playerLayerESPN?.player?.isMuted = false
            playerLayerESPN?.isHidden = false
            guideLayerESPN?.isHidden = false
            
            playerLayerFOX?.player?.isMuted = true
            playerLayerFOX?.isHidden = true
            guideLayerFOX?.isHidden = true
            
        case "fox":
            playerLayer?.player?.isMuted = true
            playerLayer?.isHidden = true
            guideLayer?.isHidden = true
            
            playerLayerCBS?.player?.isMuted = true
            playerLayerCBS?.isHidden = true
            guideLayerCBS?.isHidden = true
            
            playerLayerCNN?.player?.isMuted = true
            playerLayerCNN?.isHidden = true
            guideLayerCNN?.isHidden = true
            
            playerLayerCSN?.player?.isMuted = true
            playerLayerCSN?.isHidden = true
            guideLayerCSN?.isHidden = true
            
            playerLayerESPN?.player?.isMuted = true
            playerLayerESPN?.isHidden = true
            guideLayerESPN?.isHidden = true
            
            playerLayerFOX?.player?.isMuted = false
            playerLayerFOX?.isHidden = false
            guideLayerFOX?.isHidden = false
            
        default:
            debugPrint("default")
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let pageViewController = segue.destination as? PageViewController {
            self.pageViewController = pageViewController
        }
    }
    
    @IBAction func didTapNextButton(_ sender: UIButton) {
        pageViewController?.scrollToNextViewController()
    }
    
    // Fired when the user taps on the pageControl to change its current page
    
    func didChangePageControlValue() {
        pageViewController?.scrollToViewController(index: pageControl.currentPage)
    }
    
    /********************************************************/
    // collection view
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return channels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionViewCell
        
        cell.keyartView.image = UIImage(named: String(describing: channelKeyarts[indexPath.row]))
        cell.keyartView.contentMode = .scaleAspectFit
        
        
        cell.logoView.image = UIImage(named: String(describing: channelLogos[indexPath.row]))
        cell.logoView.contentMode = .scaleAspectFit
        
        cell.titleView.text = String(describing: channelTitles[indexPath.row])
        
        cell.metadataView.text = String(describing: channelMetadatas[indexPath.row])
        
        cell.alpha = 0.4
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("You selected cell #\(indexPath.item)!")
    }
    
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        
        // cell?.backgroundColor = UIColor.red
        
        doChannelChange(channel: self.channels[indexPath.row])
    }
    
    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        
        // cell?.backgroundColor = UIColor.cyan
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.frame.size
    }
    
    func collectionView(_ collectionView: UICollectionView, didUpdateFocusIn context: UICollectionViewFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
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
    
    /********************************************************/
    
    override func pressesBegan(_ presses: Set<UIPress>, with event: UIPressesEvent?) {
        
        for press in presses {
            switch press.type {
            case .menu:
                self.doHide()
            default:
                super.pressesEnded(presses, with: event)
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
}





extension ViewController: PageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: PageViewController,
                            didUpdatePageCount count: Int) {
        pageControl.numberOfPages = count
    }
    
    func pageViewController(_ pageViewController: PageViewController,
                            didUpdatePageIndex index: Int) {
        pageControl.currentPage = index
        
    }
}





































