
import Foundation
import UIKit

class MCMessagePopUp : NSObject {
    var messageQuote = Array<MCMessagePopUpView>()
    var isPresenting = false
    var tapOnPresentedView : UITapGestureRecognizer!
    var tapOnBluredBackground : UITapGestureRecognizer!
    var swipeOnView : UISwipeGestureRecognizer!
    var swipeOnBackground : UISwipeGestureRecognizer!
    var bluredBackgroundView : UIVisualEffectView!
    var mainScreen : UIView!
    var lblArrowTop = UILabel()
    var lblArrowBottom = UILabel()
    
    internal func showMessage(style : kMessagePopUpStyle, message : String?, title : String?, mainScreen : UIView) {
        self.mainScreen = UIApplication.sharedApplication().keyWindow
        guard let isMessage = message else {
            print("Message tryde to display with no message")
            return
        }
        guard let isTitle = title else {
            print("Message tryde to display with no title")
            return
        }
        let messageView = MCMessagePopUpView(title: isTitle, subtitle: isMessage)
        messageView.setStyle(style)
        self.messageQuote.append(messageView)
        self.checkQuoteForPresentation()
    }
    
    private func checkQuoteForPresentation() {
        if isPresenting == true {
            return
        }
        if self.messageQuote.count != 0 {
            isPresenting = true
            self.presentMessageOnScreen()
        }
    }
    
    private func presentMessageOnScreen() {
        let messageView = messageQuote[0]
        
        //BackgroundView
        let blurEffectBackgrounds = UIBlurEffect(style: UIBlurEffectStyle.Light)
        self.bluredBackgroundView = UIVisualEffectView(effect: blurEffectBackgrounds)
        self.bluredBackgroundView.frame = (mainScreen.bounds)
        self.bluredBackgroundView.alpha = 0
        mainScreen.addSubview(bluredBackgroundView)
        
        
        //MessageView
        self.bluredBackgroundView.addSubview(messageView)
        messageView.snp_makeConstraints {[weak self] (make) -> Void in
            make.left.equalTo((self?.bluredBackgroundView.snp_left)!)
            make.right.equalTo((self?.bluredBackgroundView.snp_right)!)
            make.bottom.equalTo((self?.bluredBackgroundView.snp_top)!)
        }
        messageView.layoutIfNeeded()
        
        //Arrowa
        self.lblArrowTop.attributedText = TextHelper.setAttrebutedStringWithIcon(kIconArrowWideTop, andIconSize: 23, andTextString: "", andTextFont: "", andColor: Colors.defaultBlue(), onSide: "")
        self.lblArrowBottom.attributedText = TextHelper.setAttrebutedStringWithIcon(kIconArrowWideTop, andIconSize: 23, andTextString: "", andTextFont: "", andColor: Colors.defaultBlue(), onSide: "")
        
        self.bluredBackgroundView.addSubview(self.lblArrowTop)
        self.bluredBackgroundView.addSubview(self.lblArrowBottom)
        self.lblArrowTop.alpha = 0
        self.lblArrowBottom.alpha = 0
        self.lblArrowTop.snp_makeConstraints { (make) -> Void in
            make.centerX.equalTo(messageView.snp_centerX)
            make.top.equalTo(messageView.snp_bottom).offset(15)
        }
        self.lblArrowBottom.snp_makeConstraints {[weak self] (make) -> Void in
            make.centerX.equalTo(messageView.snp_centerX)
            make.top.equalTo((self?.lblArrowTop.snp_bottom)!)
        }
        self.lblArrowBottom.layoutIfNeeded()
        self.lblArrowTop.layoutIfNeeded()
        
        
        messageView.snp_remakeConstraints {[weak self] (make) -> Void in
            make.left.equalTo((self?.bluredBackgroundView.snp_left)!)
            make.right.equalTo((self?.bluredBackgroundView.snp_right)!)
            make.top.equalTo((self?.bluredBackgroundView.snp_top)!).offset(24)
        }
        
        UIView.animateWithDuration(0.8, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: [UIViewAnimationOptions.CurveEaseInOut , UIViewAnimationOptions.AllowUserInteraction], animations: {[weak self] () -> Void in
            messageView.layoutIfNeeded()
            self?.lblArrowBottom.layoutIfNeeded()
            self?.lblArrowTop.layoutIfNeeded()
            self?.bluredBackgroundView.alpha = 1
            self?.lblArrowTop.alpha = 1
            
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
        
        self.swipeOnBackground = UISwipeGestureRecognizer(target: self, action: "didTapOnPresentedView")
        self.swipeOnBackground.direction = UISwipeGestureRecognizerDirection.Up
        self.bluredBackgroundView.addGestureRecognizer(self.swipeOnBackground)
        
    }
    
    private func removeViewFromScreen() {
        
        self.lblArrowTop.alpha = 0
        self.lblArrowBottom.alpha = 0
        
        let messageView = messageQuote[0]
        
        messageView.removeGestureRecognizer(self.tapOnPresentedView)
        
        messageView.snp_remakeConstraints {[weak self] (make) -> Void in
            make.left.equalTo((self?.bluredBackgroundView?.snp_left)!)
            make.right.equalTo((self?.bluredBackgroundView?.snp_right)!)
            make.bottom.equalTo((self?.bluredBackgroundView?.snp_top)!)
        }
        
        self.lblArrowTop.snp_remakeConstraints {[weak self] (make) -> Void in
            make.centerX.equalTo(messageView.snp_centerX)
            make.top.equalTo((self?.bluredBackgroundView?.snp_top)!).offset(15)
        }
        self.lblArrowBottom.snp_remakeConstraints { [weak self](make) -> Void in
            make.centerX.equalTo(messageView.snp_centerX)
            make.top.equalTo((self?.lblArrowTop.snp_bottom)!)
        }
        
        UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: [UIViewAnimationOptions.CurveEaseInOut, UIViewAnimationOptions.AllowUserInteraction], animations: { () -> Void in
            messageView.layoutIfNeeded()
            self.bluredBackgroundView.alpha = 0
            
            }) {[weak self] (didEnd) -> Void in
                if didEnd == true {
                    self!.messageQuote[0].removeGestureRecognizer((self?.tapOnPresentedView)!)
                    self!.messageQuote[0].removeGestureRecognizer((self?.swipeOnView)!)
                    self?.bluredBackgroundView.removeGestureRecognizer((self?.tapOnBluredBackground)!)
                    self?.bluredBackgroundView.removeGestureRecognizer((self?.swipeOnBackground)!)
                    self!.messageQuote[0].removeFromSuperview()
                    self!.messageQuote.removeAtIndex(0)
                    self?.bluredBackgroundView.removeFromSuperview()
                    self!.lblArrowTop.removeFromSuperview()
                    self!.lblArrowBottom.removeFromSuperview()
                    self?.isPresenting = false
                    self?.checkQuoteForPresentation()
                    
                }
        }
        
        
        
    }
    
    func didTapOnPresentedView() {
        self.removeViewFromScreen()
    }
    
    
}
