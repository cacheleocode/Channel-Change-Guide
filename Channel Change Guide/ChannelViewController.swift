import UIKit
import AVFoundation

@IBDesignable class ChannelViewController: UIViewController {
    @IBInspectable var channel: String!
    
    required init(coder aDecoder: NSCoder)  {
        super.init(coder: aDecoder)!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // something
    }
    
    func toggleMute() {
        // something
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // something
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        // something
    }
}
