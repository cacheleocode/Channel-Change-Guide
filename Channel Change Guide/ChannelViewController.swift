import UIKit
import AVFoundation

@IBDesignable class ChannelViewController: UIViewController {
    @IBInspectable var channel: String!
    @IBOutlet var guideContainer: UIView!
    @IBOutlet weak var guide: UIImageView!
    
    let queue = DispatchQueue(label: "queue", attributes: .concurrent)

    private var pendingTask: DispatchWorkItem?
    private var pendingTask2: DispatchWorkItem?
    
    required init(coder aDecoder: NSCoder)  {
        super.init(coder: aDecoder)!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.guide?.alpha = 0.0
        
        /*
        // fade out after 2 seconds, then fade back in
        UIView.animate(withDuration: 1.5, delay: 2.0, animations: {
            self.guide?.alpha = 0.0
        }, completion: {
            (finished: Bool) -> Void in
                UIView.animate(withDuration: 1.5, animations: {
                    self.guide?.alpha = 1.0
                }, completion: nil)
        })
        */
        
        let taskFadeIn = DispatchWorkItem {
            /*
            UIView.animate(withDuration: 1.5, animations: {
                self.guide?.alpha = 1.0
            }, completion: nil)
            */
            
            debugPrint("scheduled show")
        }
        
        let taskFadeOut = DispatchWorkItem {
            /*
            UIView.animate(withDuration: 1.5, animations: {
                self.guide?.alpha = 0.0
            }, completion: nil)
            */
            
            debugPrint("scheduled hide")
        }
        
        pendingTask = taskFadeIn
        pendingTask2 = taskFadeOut

        
        // swipe detection
        
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
        
        
    }
    
    
    func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        debugPrint("recognize")
        
        UIView.animate(withDuration: 1.5, animations: {
            self.guide?.alpha = 1.0
        }, completion: {
            (finished: Bool) -> Void in
            UIView.animate(withDuration: 1.5, delay: 2.0, animations: {
                self.guide?.alpha = 0.0
            }, completion: nil)
        })
        
        // fade in
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()) {
            self.queue.async(execute: self.pendingTask!)
        }
        
        // fade out
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
            self.queue.async(execute: self.pendingTask2!)
        }
        
        
    }
    
    
    
    func toggleMute() {
        // something
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
    }
    
    
}
