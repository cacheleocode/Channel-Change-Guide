import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var videoView: UIView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var overlayView: UIView!
    @IBOutlet weak var channelName: UILabel!
    @IBOutlet weak var collectionView: UIView!
    
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
    
    var surfing = false
    
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
    
    fileprivate let cellItems = [
        "amc",
        "cbs",
        "cnn",
        "csn",
        "espn",
        "fox"
    ]
    
    @IBOutlet weak var infiniteCollectionView: InfiniteCollectionView!
    {
        didSet {
            infiniteCollectionView.backgroundColor = UIColor.white
            infiniteCollectionView.register(UINib(nibName: "ExampleCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "cellCollectionView")
            infiniteCollectionView.infiniteDataSource = self
            infiniteCollectionView.infiniteDelegate = self
            infiniteCollectionView.reloadData()
        }
    }
    
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

        // add target
        
        pageControl.addTarget(self, action: #selector(ViewController.didChangePageControlValue), for: .valueChanged)
        
        // swipe detection
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.doChannelChange(sender:)))
        self.view.addGestureRecognizer(tapGesture)
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeRight.direction = UISwipeGestureRecognizerDirection.right
        self.view.addGestureRecognizer(swipeRight)
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeDown.direction = UISwipeGestureRecognizerDirection.down
        self.view.addGestureRecognizer(swipeDown)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeLeft.direction = UISwipeGestureRecognizerDirection.left
        self.view.addGestureRecognizer(swipeLeft)
        
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeUp.direction = UISwipeGestureRecognizerDirection.up
        self.view.addGestureRecognizer(swipeUp)
        
        let gradient = CAGradientLayer()

        gradient.frame.size = CGSize(width: 1920, height: 600)
        gradient.colors = [UIColor.black.withAlphaComponent(0.5), UIColor.black.cgColor]
        gradient.locations = [0.0, 0.3]
        
        self.collectionView.layer.insertSublayer(gradient, at: 0)
        
        // initial appearance
        
        // Overlay View
        self.overlayView.alpha = 0.0
        
        // Collection View
        self.collectionView.isHidden = false
        self.collectionView.alpha = 0.0
        
        // Container View
        self.containerView.isHidden = true
        self.containerView.alpha = 0.0
    }
    
    func doRestartTimer() {
        /*
        if (direction == "left") {
            resetOrigin = 200
        } else {
            resetOrigin = -200
        }
        
        pendingTask2 = DispatchWorkItem {
            UIView.animate(withDuration: 0.3, animations: {
                // self.overlayView.alpha = 0.0
                self.collectionView.alpha = 0.0
                self.collectionView.frame.origin.x = self.resetOrigin!
            }, completion: { (finished: Bool) in
                self.pageViewController?.scrollToViewController(index: self.resetIndex)
            })
        }
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 4.0, execute: self.pendingTask2!)
        */
        
        pendingTask2 = DispatchWorkItem {
            self.doHide()
        }
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .milliseconds(6000), execute: self.pendingTask2!)
    }
    
    func doInvalidateTimer() {
        pendingTask2?.cancel()
    }
    
    func doShow(index: Int) {
        if (self.containerView.isHidden) { // show preview
            pendingTask = DispatchWorkItem {
                self.surfing = true
                
                // animate preview in
                UIView.animate(withDuration: 0.3, animations: {
                    self.collectionView?.alpha = 1.0
                }, completion: nil)
            }
            
            DispatchQueue.main.async(execute: self.pendingTask!)
        } else { // show channel
            // animate tuning to channel
            UIView.animate(withDuration: 0.3, animations: {
                
                self.collectionView?.alpha = 0.0
                
                self.collectionView.isHidden = false
                
                self.containerView.isHidden = false
                self.containerView.alpha = 1.0
                
            }, completion: nil)
        }
    }
    
    func doShowGuide() {
        UIView.animate(withDuration: 0.3, animations: {
            self.containerView.alpha = 0.5
            debugPrint("fade in final")
        }, completion: { (finished: Bool) in
            // something
        })
    }
    
    func doHide() {
        // reset channel
        self.pageViewController?.scrollToViewController(index: self.resetIndex)
        
        UIView.animate(withDuration: 0.3, animations: {
            self.collectionView.alpha = 0.0
            
            self.containerView.alpha = 0.0
        }, completion: { (finished: Bool) in
            self.surfing = false
            
            self.containerView.isHidden = true
            
        })
    }
    
    func doHideGuide() {
        UIView.animate(withDuration: 0.3, animations: {
            self.containerView.alpha = 0.0
            debugPrint("fade out final")
            
            self.pageViewController?.scrollToViewController(index: self.resetIndex)
            
        }, completion: nil)
    }
    
    func respondToTapGesture(gesture: UITapGestureRecognizer) {
        if (self.containerView.alpha == 0.0) { // neutral
            // nothing
        } else {
            // self.doShow(index: self.nextIndex!)
        }
    }
    
    func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {

            switch swipeGesture.direction {
            case UISwipeGestureRecognizerDirection.right:
                /*
                debugPrint("Swiped right")
                
                // self.containerView.frame.origin.x = -200
                
                //self.collectionView.frame.origin.x = -200
                
                pendingTask = DispatchWorkItem {
                    UIView.animate(withDuration: 0.3, animations: {
                        // self.overlayView.alpha = 0.5
                        self.collectionView.alpha = 0.5
                        self.collectionView.frame.origin.x = 0
                    }, completion: nil)
                }

                pendingTask2 = DispatchWorkItem {
                    UIView.animate(withDuration: 0.3, animations: {
                        // self.overlayView.alpha = 0.0
                        self.collectionView.alpha = 0.0
                        //self.collectionView.frame.origin.x = -200
                    }, completion: { (finished: Bool) in
                        self.pageViewController?.scrollToViewController(index: self.resetIndex)
                    })
                }
                
                direction = "right"
                
                
                // show guide
                DispatchQueue.main.async(execute: self.pendingTask!)
                
                // hide guide
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 4.0, execute: self.pendingTask2!)
                */
                
                direction = "right"
                
                self.doShow(index: self.resetIndex)
                
            case UISwipeGestureRecognizerDirection.down:
                debugPrint("Swiped down")
            case UISwipeGestureRecognizerDirection.left:
                /*
                debugPrint("Swiped left")
                
                //self.collectionView.frame.origin.x = 200
                
                pendingTask = DispatchWorkItem {
                    UIView.animate(withDuration: 0.3, animations: {
                        // self.overlayView.alpha = 0.5
                        self.collectionView.alpha = 0.5
                        self.collectionView.frame.origin.x = 0
                    }, completion: nil)
                }
                
                pendingTask2 = DispatchWorkItem {
                    UIView.animate(withDuration: 0.3, animations: {
                        // self.overlayView.alpha = 0.0
                        self.collectionView.alpha = 0.0
                        //self.collectionView.frame.origin.x = 200
                    }, completion: { (finished: Bool) in
                        self.pageViewController?.scrollToViewController(index: self.resetIndex)
                    })
                }
                // show guide
                DispatchQueue.main.async(execute: self.pendingTask!)
                
                // hide guide
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 4.0, execute: self.pendingTask2!)
                
                direction = "left"
                */
                
                direction = "left"
                
                self.doShow(index: self.resetIndex)
                
            case UISwipeGestureRecognizerDirection.up:
                debugPrint("Swiped up")
            default:
                break
            }
        }
    }
    
    func doChannelChange(sender: UITapGestureRecognizer? = nil) {
        resetIndex = pageControl.currentPage
        
        switch pageControl.currentPage {
        case 0: // AMC
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
            
        case 1: // CBS
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
        
        case 2: // CNN
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
            
        case 3: // CSN
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
            
        case 4: // ESPN
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
            
        case 5: // FOX
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
    
    override func pressesBegan(_ presses: Set<UIPress>, with event: UIPressesEvent?) {
        if(presses.first?.type == UIPressType.menu) {
            self.doHide()
        }
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

extension ViewController: InfiniteCollectionViewDataSource
{
    func numberOfItems(_ collectionView: UICollectionView) -> Int
    {
        return cellItems.count
    }
    
    func cellForItemAtIndexPath(_ collectionView: UICollectionView, dequeueIndexPath: IndexPath, usableIndexPath: IndexPath)  -> UICollectionViewCell
    {
        let cell = infiniteCollectionView.dequeueReusableCell(withReuseIdentifier: "cellCollectionView", for: dequeueIndexPath) as! ExampleCollectionViewCell
        cell.lbTitle.text = cellItems[usableIndexPath.row]
        cell.backgroundImage.image = UIImage(named: "cell-1")
        return cell
    }
}

extension ViewController: InfiniteCollectionViewDelegate
{
    func didSelectCellAtIndexPath(_ collectionView: UICollectionView, usableIndexPath: IndexPath)
    {
        print("Selected cell with name \(cellItems[usableIndexPath.row])")
    }
}
























