import UIKit

@objc(MyApplication)

class MyApplication: UIApplication {
    
    weak var myVC: ViewController?
    
    override func sendEvent(_ event: UIEvent) {
        //debugPrint("global global");
        
        // Ignore .Motion and .RemoteControl event simply everything else then .Touches
        if event.type != .touches {
            super.sendEvent(event)
            return
        }
        
        // .Touches only
        var restartTimer = true
        if let touches = event.allTouches {
            // At least one touch in progress? Do not restart timer, just invalidate it
            for touch in touches.enumerated() {
                if touch.element.phase != .cancelled && touch.element.phase != .ended {
                    restartTimer = false
                    break
                }
            }
        }
        
        if restartTimer {
            // Touches ended || cancelled, restart timer
            // print("Touches ended. Restart timer")
            
            myVC?.doRestartTimer()
            
        } else {
            // Touches in progress - !ended, !cancelled, just invalidate it
            //print("Touches in progress. Invalidate timer")
        
            myVC?.doInvalidateTimer()
        }
        
        super.sendEvent(event)
    }
}
