import UIKit
import AVFoundation

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var videoView: UIView!
    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var keyartView: UIImageView!
    @IBOutlet weak var logoView: UIImageView!
    @IBOutlet weak var titleView: UILabel!
    @IBOutlet weak var metadataView: UILabel!
    @IBOutlet weak var overlayView: UIView!
    @IBOutlet weak var collectionView: CollectionView!
    
    // dispatch queue
    
    let queue = DispatchQueue(label: "queue", attributes: .concurrent)
    
    var pendingTask: DispatchWorkItem?
    var pendingTask2: DispatchWorkItem?
    var pendingTask3: DispatchWorkItem?
    
    // player layers
    
    var playerLayer: AVPlayerLayer?
    var playerLayerCBS: AVPlayerLayer?
    var playerLayerCNN: AVPlayerLayer?
    var playerLayerCSN: AVPlayerLayer?
    var playerLayerESPN: AVPlayerLayer?
    var playerLayerFOX: AVPlayerLayer?
    var playerLayerHBO: AVPlayerLayer?
    var playerLayerHSN: AVPlayerLayer?
    
    // cell content
    
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
    
    // mode
    
    var surfing = false
    
    // emulate lag
    
    var randomNum: UInt32?
    var someInt: Int?
    var someDouble: Double?
    var randomTime: TimeInterval?
    
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
        
        // tap detection
        // let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.respondToTapGesture))
        // self.view.addGestureRecognizer(tapGesture)
        
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
        
        // overlay view
        self.overlayView.alpha = 0.0
        
        // loading view
        self.loadingView.alpha = 0.0
        
        // fake populate infinite loop
        
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
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .milliseconds(5000), execute: self.pendingTask2!)
    }
    
    func doInvalidateTimer() {
        pendingTask2?.cancel()
        
        self.doShow()
    }
    
    func doShow() {
        pendingTask = DispatchWorkItem {
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
        }, completion: nil)
    }
    
    /*
    func respondToTapGesture(gesture: UITapGestureRecognizer) {
        
    }
    */
    
    func doChannelChange(channel: String) {
        switch channel {
        case "amc":
            playerLayer?.player?.isMuted = false
            playerLayer?.isHidden = false
            
            playerLayerCBS?.player?.isMuted = true
            playerLayerCBS?.isHidden = true
            playerLayerCNN?.player?.isMuted = true
            playerLayerCNN?.isHidden = true
            
            playerLayerCSN?.player?.isMuted = true
            playerLayerCSN?.isHidden = true
            
            playerLayerESPN?.player?.isMuted = true
            playerLayerESPN?.isHidden = true
            
            playerLayerFOX?.player?.isMuted = true
            playerLayerFOX?.isHidden = true
            
        case "cbs":
            playerLayer?.player?.isMuted = true
            playerLayer?.isHidden = true
            
            playerLayerCBS?.player?.isMuted = false
            playerLayerCBS?.isHidden = false
            
            playerLayerCNN?.player?.isMuted = true
            playerLayerCNN?.isHidden = true
            
            playerLayerCSN?.player?.isMuted = true
            playerLayerCSN?.isHidden = true
            
            playerLayerESPN?.player?.isMuted = true
            playerLayerESPN?.isHidden = true
            
            playerLayerFOX?.player?.isMuted = true
            playerLayerFOX?.isHidden = true
        
        case "cnn":
            playerLayer?.player?.isMuted = true
            playerLayer?.isHidden = true
            
            playerLayerCBS?.player?.isMuted = true
            playerLayerCBS?.isHidden = true
            
            playerLayerCNN?.player?.isMuted = false
            playerLayerCNN?.isHidden = false
            
            playerLayerCSN?.player?.isMuted = true
            playerLayerCSN?.isHidden = true
            
            playerLayerESPN?.player?.isMuted = true
            playerLayerESPN?.isHidden = true
            
            playerLayerFOX?.player?.isMuted = true
            playerLayerFOX?.isHidden = true
            
        case "csn":
            playerLayer?.player?.isMuted = true
            playerLayer?.isHidden = true
            
            playerLayerCBS?.player?.isMuted = true
            playerLayerCBS?.isHidden = true
            
            playerLayerCNN?.player?.isMuted = true
            playerLayerCNN?.isHidden = true
            
            playerLayerCSN?.player?.isMuted = false
            playerLayerCSN?.isHidden = false
            
            playerLayerESPN?.player?.isMuted = true
            playerLayerESPN?.isHidden = true
            
            playerLayerFOX?.player?.isMuted = true
            playerLayerFOX?.isHidden = true
            
        case "espn":
            playerLayer?.player?.isMuted = true
            playerLayer?.isHidden = true
            
            playerLayerCBS?.player?.isMuted = true
            playerLayerCBS?.isHidden = true
            
            playerLayerCNN?.player?.isMuted = true
            playerLayerCNN?.isHidden = true
            
            playerLayerCSN?.player?.isMuted = true
            playerLayerCSN?.isHidden = true
            
            playerLayerESPN?.player?.isMuted = false
            playerLayerESPN?.isHidden = false
            
            playerLayerFOX?.player?.isMuted = true
            playerLayerFOX?.isHidden = true
            
        case "fox":
            playerLayer?.player?.isMuted = true
            playerLayer?.isHidden = true
            
            playerLayerCBS?.player?.isMuted = true
            playerLayerCBS?.isHidden = true
            
            playerLayerCNN?.player?.isMuted = true
            playerLayerCNN?.isHidden = true
            
            playerLayerCSN?.player?.isMuted = true
            playerLayerCSN?.isHidden = true
            
            playerLayerESPN?.player?.isMuted = true
            playerLayerESPN?.isHidden = true
            
            playerLayerFOX?.player?.isMuted = false
            playerLayerFOX?.isHidden = false
            
        default:
            debugPrint("default")
        }
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
        
        // hide UI
        self.doHide()
        
        // emulate loading
        self.randomNum = arc4random_uniform(15) // range
        self.someInt = Int(self.randomNum!)
        self.someDouble = Double(self.someInt!) / 10
        
        if (self.someDouble! < 0.5) {
            self.someDouble! = 0.5
        }
        
        // populate loading view
        self.keyartView.image = UIImage(named: String(describing: channelKeyarts[indexPath.row]))
        self.logoView.image = UIImage(named: String(describing: channelLogos[indexPath.row]))
        self.titleView.text = String(describing: channelTitles[indexPath.row])
        self.metadataView.text = String(describing: channelMetadatas[indexPath.row])

        UIView.animate(withDuration: 0.3, animations: {
            self.loadingView.alpha = 1.0
        }, completion: { (finished: Bool) in
            
            UIView.animate(withDuration: 0.3, delay: self.someDouble!, animations: {
                self.doChannelChange(channel: self.channels[indexPath.row])
                
                self.loadingView.alpha = 0.0
            }, completion: nil)
            
        })
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





































