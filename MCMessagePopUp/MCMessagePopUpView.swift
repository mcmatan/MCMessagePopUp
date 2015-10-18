

import Foundation
import UIKit
import SnapKit
import DynamicColor

enum kMessagePopUpStyle {
    case Error
    case Info
    case Success
}


class MCMessagePopUpView : UIView {
    var lblTitle = UILabel()
    var lblSubtitle = UILabel()
    var font = UIFont(name: "HelveticaNeue-Light", size: 14)!
    
    //MARK: Public
    internal func setTitle(text : String) {
        self.lblTitle.text = text;
    }
    internal func setSubtitle(text : String) {
        self.lblSubtitle.text = text;
    }
    internal func setTextColor(color : UIColor) {
        self.lblTitle.textColor = color
        self.lblSubtitle.textColor = color
    }
    internal func setTextFont(font : UIFont) {
        self.lblTitle.font = font
        self.lblSubtitle.font = font
    }
    
    internal func setStyle(style : kMessagePopUpStyle) {
        switch style {
        case .Error:
            let redColor = UIColor(hexString: "BB354E")
            self.setTextColor(redColor)
                break;
        case .Success:
            let greenColor = UIColor(hexString: "77AD15")
            self.setTextColor(greenColor)
                break
        case .Info:
            let orangeColor = UIColor(hexString: "C87937")
            self.setTextColor(orangeColor)
                break
            
        }
    }
    
    
    //MARK: init
    override init(frame: CGRect) { // for using CustomView in code
        super.init(frame: frame)
        self.commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) { // for using CustomView in IB
        super.init(coder: aDecoder)
        self.commonInit()
    }
    
    init() {
        super.init(frame: CGRectZero)
        self.commonInit()        
    }
    
    //MARK: setup
    
    private func commonInit() {
        
        self.lblSubtitle.font = font
        self.lblTitle.font = font
        self.tintColor = UIColor.clearColor()
        self.lblSubtitle.numberOfLines = 0
        
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.ExtraLight)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.bounds
        
        self.addSubview(blurEffectView)
        self.addSubview(self.lblTitle)
        self.addSubview(self.lblSubtitle)
        
        blurEffectView.userInteractionEnabled = true
        lblTitle.userInteractionEnabled = true
        lblSubtitle.userInteractionEnabled = true
        
        blurEffectView.snp_makeConstraints { (make) -> Void in
            make.edges.equalTo(self)
        }
        
        self.lblTitle.snp_makeConstraints {[weak self] (make) -> Void in
            make.top.equalTo((self?.snp_top)!).offset(15)
            make.left.equalTo((self?.snp_left)!).offset(UIScreen.mainScreen().bounds.width * 0.25)
            make.right.equalTo((self?.snp_right)!).offset(-20)
        }
        self.lblSubtitle.snp_makeConstraints {[weak self] (make) -> Void in
            make.top.equalTo((self?.lblTitle.snp_bottom)!).offset(10)
            make.left.equalTo((self?.lblTitle.snp_left)!)
            make.right.equalTo((self?.snp_right)!).offset(-20)
            make.bottom.equalTo((self?.snp_bottom)!).offset(-15)
        }
    }


}