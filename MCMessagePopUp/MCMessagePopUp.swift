

import Foundation
import UIKit

class MCMessagePopUp : NSObject {
    var messageQuote = Array<MCMessagePopUpView>()
    var isPresenting = false
    var tapOnPresentedView : UITapGestureRecognizer!
    var tapOnBluredBackground : UITapGestureRecognizer!
    var swipeOnView : UISwipeGestureRecognizer!
    var bluredBackgroundView : UIVisualEffectView!
    
    internal func showMessage(style : kMessagePopUpStyle, message : String, title : String) {
        let messageView = MCMessagePopUpView()
        messageView.setTitle(title)
        messageView.setSubtitle(message)
        messageView.setStyle(style)
        self.messageQuote.append(messageView)
        self.checkQuoteForPresentation()
    }

    
    override init() {
    }
    
    private func checkQuoteForPresentation() {
        if isPresenting == true {
            return
        }
        if self.messageQuote.count != 0 {
            self.presentMessageOnScreen()
        }
    }
    
    private func presentMessageOnScreen() {
        isPresenting = true
        let messageView = messageQuote[0]
        let mainScreen = UIApplication.sharedApplication().keyWindow
        
        
        //BackgroundView
        let blurEffectBackgrounds = UIBlurEffect(style: UIBlurEffectStyle.Dark)
        self.bluredBackgroundView = UIVisualEffectView(effect: blurEffectBackgrounds)
        self.bluredBackgroundView.frame = (mainScreen?.bounds)!
        self.bluredBackgroundView.alpha = 0
        mainScreen?.addSubview(bluredBackgroundView)

        
        //MessageView
        mainScreen?.addSubview(messageView)
        messageView.snp_makeConstraints { (make) -> Void in
            make.left.equalTo((mainScreen?.snp_left)!)
            make.right.equalTo((mainScreen?.snp_right)!)
            make.bottom.equalTo((mainScreen?.snp_top)!)
        }
        messageView.layoutIfNeeded()
        
        messageView.snp_remakeConstraints { (make) -> Void in
            make.left.equalTo((mainScreen?.snp_left)!)
            make.right.equalTo((mainScreen?.snp_right)!)
            make.top.equalTo((mainScreen?.snp_top)!).offset(24)
        }
        
        UIView.animateWithDuration(1, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            messageView.layoutIfNeeded()
            self.bluredBackgroundView.alpha = 1
            }) {(didEnd) -> Void in
        }
        
        
        self.tapOnPresentedView = UITapGestureRecognizer(target: self, action: "didTapOnPresentedView")
        messageView.addGestureRecognizer(self.tapOnPresentedView)
        messageView.userInteractionEnabled = true

        self.tapOnBluredBackground = UITapGestureRecognizer(target: self, action: "didTapOnPresentedView")
        self.bluredBackgroundView.addGestureRecognizer(self.tapOnBluredBackground)
        self.bluredBackgroundView.userInteractionEnabled = true

        self.swipeOnView = UISwipeGestureRecognizer(target: self, action: "didTapOnPresentedView")
        self.swipeOnView.direction = UISwipeGestureRecognizerDirection.Up
        messageView.addGestureRecognizer(self.swipeOnView)
        
    }
    
    private func removeViewFromScreen() {
        let messageView = messageQuote[0]
        let mainScreen = UIApplication.sharedApplication().keyWindow
        
        messageView.removeGestureRecognizer(self.tapOnPresentedView)
        
        messageView.snp_remakeConstraints { (make) -> Void in
            make.left.equalTo((mainScreen?.snp_left)!)
            make.right.equalTo((mainScreen?.snp_right)!)
            make.bottom.equalTo((mainScreen?.snp_top)!)
        }
        
        UIView.animateWithDuration(1, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            messageView.layoutIfNeeded()
            self.bluredBackgroundView.alpha = 0
            }) {[weak self] (didEnd) -> Void in
                if didEnd == true {
                    self!.messageQuote[0].removeFromSuperview()
                    self!.messageQuote.removeAtIndex(0)
                    self?.bluredBackgroundView.removeFromSuperview()
                    self?.isPresenting = false
                    self?.checkQuoteForPresentation()
                }
        }

    }
    
    func didTapOnPresentedView() {
        self.removeViewFromScreen()
    }
    
    
}
