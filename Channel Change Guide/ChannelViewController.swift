import UIKit
import AVFoundation

@IBDesignable class ChannelViewController: UIViewController {
    @IBInspectable var channel: String!
    @IBOutlet var guideContainer: UIView!
    @IBOutlet weak var guide: UIImageView!
    

    let queue = DispatchQueue(label: "queue", attributes: .concurrent)
    
    var lastInteracted = 0.0
    var inputTriggered = false
    var channelChanging = false
    var indecisive = false
    var loadTime = 0

    private var pendingTask: DispatchWorkItem?
    private var pendingTask2: DispatchWorkItem?
    
    required init(coder aDecoder: NSCoder)  {
        super.init(coder: aDecoder)!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.guide?.alpha = 0.0
        //debugPrint("p1")
        
        /*
        // fade out after 2 seconds, then fade back in
        UIView.animate(withDuration: 1.5, delay: 2.0, animations: {
            self.guide?.alpha = 0.0
            debugPrint("p2")
        }, completion: {
            (finished: Bool) -> Void in
                UIView.animate(withDuration: 0.3, animations: {
                    self.guide?.alpha = 1.0
                    debugPrint("p3")
                }, completion: nil)
        })
        */
        
        let taskFadeIn = DispatchWorkItem {
      
            UIView.animate(withDuration: 1.5, animations: {
                self.guide?.alpha = 1.0
                debugPrint("p4")
            }, completion: nil)
            
            debugPrint("scheduled show")
        }
        
        let taskFadeOut = DispatchWorkItem {
            UIView.animate(withDuration: 0.3, animations: {
                self.guide?.alpha = 0.0
                debugPrint("p5")
            }, completion: nil)
            
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
        //debugPrint("recognize")
        
        triggerInput()
        
        /*
        UIView.animate(withDuration: 0.3, animations: {
            self.guide?.alpha = 1.0
            debugPrint("p6")
        }, completion: {
            (finished: Bool) -> Void in
            UIView.animate(withDuration: 0.3, delay: 2.0, animations: {
                self.guide?.alpha = 0.0
                debugPrint("p7")
            }, completion: nil)
        })
        */
        
        /*
        
        // fade in
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()) {
            self.queue.async(execute: self.pendingTask!)
        }
        
        // fade out
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
            self.queue.async(execute: self.pendingTask2!)
        }
 
         */
    }
    
    func triggerInput () {
        // debugPrint("inputTriggered", inputTriggered)
        // debugPrint("getElapsedTime()", getElapsedTime())
        // debugPrint("lastInteracted", lastInteracted)
        // debugPrint("getElapsedTime()-lastInteracted", getElapsedTime()-lastInteracted)
        
        if(!inputTriggered && getElapsedTime()-lastInteracted > 5.0){ // inputTriggered flag lets us trigger something once, without triggering every single frame. also debounce so we can only trigger an input every half second
            
            debugPrint("in the if statement")
            
            changeChannel()
            
            inputTriggered = true //set out trigger flag
            
            
        }
    }
    
    func getElapsedTime() -> Double {
        let startTime = NSDate.timeIntervalSinceReferenceDate
        var currentTime: TimeInterval = 0
        
        for i in 0 ..< 10000 {
            if i == 99 {
                currentTime = NSDate.timeIntervalSinceReferenceDate
            }
            
        }
        let elapsedTime = currentTime - startTime
    
        
        return elapsedTime
    }
    
    func changeChannel () {
        if(channelChanging){ //if we are already changing channels, set extra flag so we continue seeing the old poster below new one sliding in
            indecisive = true
        }
        channelChanging = true //set flag that we are changing channels, this will trigger drawing posters on top of video in draw()
        
        lastInteracted = getElapsedTime() // set animation start time
        
        loadTime = 4000 //randomize our fake loading time so it feels a bit more realistic
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
