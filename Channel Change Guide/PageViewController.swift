import UIKit
import AVFoundation

class PageViewController: UIPageViewController {
    weak var gotDelegate: PageViewControllerDelegate?
        
    var swipeMode = false
    var swipeCount = 0
    
    fileprivate(set) lazy var orderedViewControllers: [UIViewController] = {
        // The view controllers will be shown in this order
        return [
            self.newChannelViewController("AMC"),
            self.newChannelViewController("CBS"),
            self.newChannelViewController("CNN"),
            self.newChannelViewController("CSN"),
            self.newChannelViewController("ESPN"),
            self.newChannelViewController("FOX")]
        
        
        /*
         return [
         self.newChannelViewController("xAMC"),
         self.newChannelViewController("AMC"),
         self.newChannelViewController("AMCx"),
         self.newChannelViewController("xCBS"),
         self.newChannelViewController("CBS"),
         self.newChannelViewController("CBSx"),
         self.newChannelViewController("xCNN"),
         self.newChannelViewController("CNN"),
         self.newChannelViewController("CNNx"),
         self.newChannelViewController("xCSN"),
         self.newChannelViewController("CSN"),
         self.newChannelViewController("CSNx"),
         self.newChannelViewController("xESPN"),
         self.newChannelViewController("ESPN"),
         self.newChannelViewController("ESPNx"),
         self.newChannelViewController("xFOX"),
         self.newChannelViewController("FOX"),
         self.newChannelViewController("FOXx")]
         */
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = self
        delegate = self
                
        if let initialViewController = orderedViewControllers.first {
            scrollToViewController(initialViewController)
        }
        
        gotDelegate?.pageViewController(self, didUpdatePageCount: orderedViewControllers.count)

    }
    
    func doSelect(index newIndex: Int) {
        
    }

    
    /**
     Scrolls to the next view controller.
     */
    func scrollToNextViewController() {
        if let visibleViewController = viewControllers?.first,
            let nextViewController = pageViewController(self,
                                                        viewControllerAfter: visibleViewController) {
            scrollToViewController(nextViewController)
        }
    }
    
    func scrollToPreviousViewController() {
        if let visibleViewController = viewControllers?.last,
            let previousViewController = pageViewController(self,
                                                            viewControllerBefore: visibleViewController) {
            scrollToViewController(previousViewController)
        }
    }
    
    /**
     Scrolls to the view controller at the given index. Automatically calculates
     the direction.
     
     - parameter newIndex: the new index to scroll to
     */
    func scrollToViewController(index newIndex: Int) {
        if let firstViewController = viewControllers?.first,
            let currentIndex = orderedViewControllers.index(of: firstViewController) {
            let direction: UIPageViewControllerNavigationDirection = newIndex >= currentIndex ? .forward : .reverse
            let nextViewController = orderedViewControllers[newIndex]
            scrollToViewController(nextViewController, direction: direction)
        }
    }
    
    fileprivate func newChannelViewController(_ channel: String) -> UIViewController {
        return UIStoryboard(name: "Main", bundle: nil) .
            instantiateViewController(withIdentifier: "\(channel)ViewController")
    }
    
    /**
     Scrolls to the given 'viewController' page.
     
     - parameter viewController: the view controller to show.
     */
    fileprivate func scrollToViewController(_ viewController: UIViewController,
                                            direction: UIPageViewControllerNavigationDirection = .forward) {
        setViewControllers([viewController],
                           direction: direction,
                           animated: true,
                           completion: { (finished) -> Void in
                            // Setting the view controller programmatically does not fire
                            // any delegate methods, so we have to manually notify the
                            // 'gotDelegate' of the new index.
                            self.notifyDelegateOfNewIndex()
                            
                            
                            
        })
    }
    
    /**
     Notifies '_delegate' that the current page index was updated.
     */
    fileprivate func notifyDelegateOfNewIndex() {
        if let firstViewController = viewControllers?.first,
            let index = orderedViewControllers.index(of: firstViewController) {
            gotDelegate?.pageViewController(self, didUpdatePageIndex: index)

        }
        
    }
    
    
 

    /*
    override func pressesEnded(_ presses: Set<UIPress>, with event: UIPressesEvent?) {
        for press in presses {
            if (press.type == .select) {
                
                if let firstViewController = viewControllers?.first,
                    let index = orderedViewControllers.index(of: firstViewController) {
                    
                }

            }  else {
                super.pressesEnded(presses, with: event)
            }
        }
        
    }
     */
    
    
}

// MARK: UIPageViewControllerDataSource


extension PageViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else {
            debugPrint("initial thing")
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        
        // User is on the first view controller and swiped left to loop to
        // the last view controller.
        guard previousIndex >= 0 else {
            debugPrint("loop")
            return orderedViewControllers.last
        }
        
        guard orderedViewControllers.count > previousIndex else {
            debugPrint("normal?")
            return nil
        }
        
        return orderedViewControllers[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        let orderedViewControllersCount = orderedViewControllers.count
        
        // User is on the last view controller and swiped right to loop to
        // the first view controller.
        guard orderedViewControllersCount != nextIndex else {
            return orderedViewControllers.first
        }
        
        guard orderedViewControllersCount > nextIndex else {
            return nil
        }
        
        return orderedViewControllers[nextIndex]
    }
    
}

extension PageViewController: UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            didFinishAnimating finished: Bool,
                            previousViewControllers: [UIViewController],
                            transitionCompleted completed: Bool) {
        notifyDelegateOfNewIndex()
    }
}

protocol PageViewControllerDelegate: class {
    
    /**
     Called when the number of pages is updated.
     
     - parameter pageViewController: the PageViewController instance
     - parameter count: the total number of pages.
     */
    func pageViewController(_ pageViewController: PageViewController,
                            didUpdatePageCount count: Int)
    
    /**
     Called when the current index is updated.
     
     - parameter pageViewController: the PageViewController instance
     - parameter index: the index of the currently visible page.
     */
    func pageViewController(_ pageViewController: PageViewController,
                            didUpdatePageIndex index: Int)
    
}
