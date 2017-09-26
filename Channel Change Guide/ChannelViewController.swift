import UIKit
import AVFoundation

@IBDesignable class ChannelViewController: UIViewController {
    @IBInspectable var channel: String!
    @IBOutlet weak var guide: UIImageView!
    
    let queue = DispatchQueue(label: "queue", attributes: .concurrent)

    private var pendingTask: DispatchWorkItem?
    private var pendingTask2: DispatchWorkItem?
    
    required init(coder aDecoder: NSCoder)  {
        super.init(coder: aDecoder)!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let taskFadeIn = DispatchWorkItem {
            UIImageView.animate(withDuration: 1.5, animations: {
                debugPrint("scheduled show")
                self.guide?.alpha = 1.0
            })
        }
        
        let taskFadeOut = DispatchWorkItem {
            UIImageView.animate(withDuration: 1.5, animations: {
                self.guide?.alpha = 0.0
                debugPrint("scheduled hide")
            })
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
