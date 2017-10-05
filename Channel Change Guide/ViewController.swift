import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var videoView: UIView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var overlayView: UIView!
    
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
    
    var swipeMode = false
    
    var resetIndex = 0

    private var pendingTask: DispatchWorkItem?
    private var pendingTask2: DispatchWorkItem?
    private var pendingTask3: DispatchWorkItem?
    
    var pageViewController: PageViewController? {
        didSet {
            pageViewController?.gotDelegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        
        /*
        // guide AMC
        guideLayer = CALayer()
        guideLayer?.contents = UIImage(named: "guide0")?.cgImage
        guideLayer?.contentsGravity = kCAGravityResizeAspectFill
        guideLayer!.frame = self.guideView.frame
        guideLayer?.isHidden = true
        
        self.guideView.layer.addSublayer(guideLayer!)
        */
 
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
        
        
        /*
        // guide CBS
        guideLayerCBS = CALayer()
        guideLayerCBS?.contents = UIImage(named: "guide1")?.cgImage
        guideLayerCBS?.contentsGravity = kCAGravityResizeAspectFill
        guideLayerCBS!.frame = self.guideView.frame
        guideLayerCBS?.isHidden = true
        
        self.guideView.layer.addSublayer(guideLayerCBS!)
        */
 
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
        
        /*
        // guide CNN
        guideLayerCNN = CALayer()
        guideLayerCNN?.contents = UIImage(named: "guide2")?.cgImage
        guideLayerCNN?.contentsGravity = kCAGravityResizeAspectFill
        guideLayerCNN!.frame = self.guideView.frame
        guideLayerCNN?.isHidden = true
        
        self.guideView.layer.addSublayer(guideLayerCNN!)
        */
 
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
        
        /*
        // guide CSN
        guideLayerCSN = CALayer()
        guideLayerCSN?.contents = UIImage(named: "guide3")?.cgImage
        guideLayerCSN?.contentsGravity = kCAGravityResizeAspectFill
        guideLayerCSN!.frame = self.guideView.frame
        guideLayerCSN?.isHidden = true
        
        self.guideView.layer.addSublayer(guideLayerCSN!)
        */
 
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
        
        /*
        // guide ESPN
        guideLayerESPN = CALayer()
        guideLayerESPN?.contents = UIImage(named: "guide4")?.cgImage
        guideLayerESPN?.contentsGravity = kCAGravityResizeAspectFill
        guideLayerESPN!.frame = self.guideView.frame
        guideLayerESPN?.isHidden = true
        
        self.guideView.layer.addSublayer(guideLayerESPN!)
        */
 
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
        
        /*
        // guide FOX
        guideLayerFOX = CALayer()
        guideLayerFOX?.contents = UIImage(named: "guide5")?.cgImage
        guideLayerFOX?.contentsGravity = kCAGravityResizeAspectFill
        guideLayerFOX!.frame = self.guideView.frame
        guideLayerFOX?.isHidden = true
 
        self.guideView.layer.addSublayer(guideLayerFOX!)
        */
        
        
        // add target
        
        pageControl.addTarget(self, action: #selector(ViewController.didChangePageControlValue), for: .valueChanged)
        
        //pageControl.addTarget(self, action: #selector(ViewController.doChannelChange), for: .allTouchEvents)
    
        //pageControl.addTarget(self, action: #selector(self.doChannelChange(_:)), for: .touchUpInside)

        // swipe detection
        
        //let tap = UITapGestureRecognizer(target: self, action: #selector(self.respondToTa))
        
        //let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.tapBlurButton(_:)))

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
        
        self.overlayView.alpha = 0.0
        
        self.containerView.alpha = 0.0
        
        /*
        let taskShowGuide = DispatchWorkItem {
            
            self.doShowGuide()
        }
        
        let taskHideGuide = DispatchWorkItem {
            self.doHideGuide()
        }
        
        pendingTask = taskShowGuide
        pendingTask2 = taskHideGuide
        */
    }
    
    func doShowGuide() {
        UIView.animate(withDuration: 0.3, animations: {
            self.containerView.alpha = 0.5
            debugPrint("fade in final")
        }, completion: { (finished: Bool) in
            // something
        })
    }
    
    func doBuffer() {
        debugPrint("waiting")
    }
    
    func doHideGuide() {
        UIView.animate(withDuration: 0.3, animations: {
            self.containerView.alpha = 0.0
            debugPrint("fade out final")
            
            self.pageViewController?.scrollToViewController(index: self.resetIndex)
            
        }, completion: nil)
    }
    
    func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            
            switch swipeGesture.direction {
            case UISwipeGestureRecognizerDirection.right:
                debugPrint("Swiped right")
                
                self.containerView.frame.origin.x = -200
                
                /*
                for subview in self.containerView.subviews {
                    subview.frame.origin.x = -200
                }
                */
                
                pendingTask = DispatchWorkItem {
                    UIView.animate(withDuration: 0.3, animations: {
                        self.overlayView.alpha = 0.5
                        self.containerView.alpha = 0.5
                        self.containerView.frame.origin.x = 0
                    }, completion: nil)
                }
                
                pendingTask2 = DispatchWorkItem {
                    UIView.animate(withDuration: 0.3, animations: {
                        self.overlayView.alpha = 0.0
                        self.containerView.alpha = 0.0
                        self.containerView.frame.origin.x = -200
                    }, completion: { (finished: Bool) in
                        self.pageViewController?.scrollToViewController(index: self.resetIndex)
                    })
                }
                
                
                // show guide
                DispatchQueue.main.async(execute: self.pendingTask!)
                
                // hide guide
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 4.0, execute: self.pendingTask2!)
                
            case UISwipeGestureRecognizerDirection.down:
                debugPrint("Swiped down")
            case UISwipeGestureRecognizerDirection.left:
                debugPrint("Swiped left")
                
                self.containerView.frame.origin.x = 200
                
                pendingTask = DispatchWorkItem {
                    UIView.animate(withDuration: 0.3, animations: {
                        self.overlayView.alpha = 0.5
                        self.containerView.alpha = 0.5
                        self.containerView.frame.origin.x = 0
                    }, completion: nil)
                }
                
                pendingTask2 = DispatchWorkItem {
                    UIView.animate(withDuration: 0.3, animations: {
                        self.overlayView.alpha = 0.0
                        self.containerView.alpha = 0.0
                        self.containerView.frame.origin.x = 200
                    }, completion: { (finished: Bool) in
                        self.pageViewController?.scrollToViewController(index: self.resetIndex)
                    })
                }
                
                // show guide
                DispatchQueue.main.async(execute: self.pendingTask!)
                
                // hide guide
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 4.0, execute: self.pendingTask2!)
                
            case UISwipeGestureRecognizerDirection.up:
                debugPrint("Swiped up")
            default:
                break
            }
        }
    }
    
    func doChannelChange(sender: UITapGestureRecognizer) {
        
        
        /*
        // show guide
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()) {
            self.queue.async(execute: self.pendingTask!)
        }
 
 
        // hide guide
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 4.0) {
            self.queue.async(execute: self.pendingTask2!)
        }
        */
 
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
            
            
        //debugPrint("0")
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
            
            
        //debugPrint("1")
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
            
            
        //debugPrint("2")
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
            
            
        //debugPrint("3")
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
            
            
        //debugPrint("4")
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
            
            
        //debugPrint("5")
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
    
    /**
     Fired when the user taps on the pageControl to change its current page.
     */
    func didChangePageControlValue() {
        pageViewController?.scrollToViewController(index: pageControl.currentPage)
    }
    
    
    @IBAction func didSwipe(_ sender: Any) {
        debugPrint("in deep")
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
