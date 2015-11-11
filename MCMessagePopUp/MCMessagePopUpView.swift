

import Foundation
import UIKit
import SnapKit
import HexColors

@objc enum kMessagePopUpStyle : Int {
    case Error,
    Info,
    Success
}


class MCMessagePopUpView : UIView {
    var lblTitle = UILabel()
    var lblSubtitle = UILabel()
    var lblIcon = UILabel()
    var lblIconFontSize = 22
    var iconWidthHeightSize = 40
    var font = UIFont(name: "HelveticaNeue-Light", size: 14)!
    
    //MARK: Public
    
    internal func setTextColor(color : UIColor) {
        self.lblTitle.textColor = color
        self.lblSubtitle.textColor = color
        self.layoutIfNeeded()
    }
    internal func setTextFont(font : UIFont) {
        self.lblTitle.font = font
        self.lblSubtitle.font = font
        self.layoutIfNeeded()
    }
    
    internal func setStyle(style : kMessagePopUpStyle) {
        switch style {
        case .Error:
            let redColor = UIColor(hexString: "BB354E")
            self.lblIcon.attributedText = TextHelper.setAttrebutedStringWithIcon(kIconMarketClosed, andIconSize: Int32(lblIconFontSize), andTextString: "", andTextFont: "", andColor: redColor, onSide: "")
            self.setTextColor(redColor)
            break;
        case .Success:
            let greenColor = UIColor(hexString: "77AD15")
            self.lblIcon.attributedText = TextHelper.setAttrebutedStringWithIcon(kIconOk, andIconSize: Int32(lblIconFontSize), andTextString: "", andTextFont: "", andColor: greenColor, onSide: "")
            self.setTextColor(greenColor)
            break
        case .Info:
            let orangeColor = UIColor(hexString: "C87937")
            self.lblIcon.attributedText = TextHelper.setAttrebutedStringWithIcon(kIconWarning, andIconSize: Int32(lblIconFontSize), andTextString: "", andTextFont: "", andColor: orangeColor, onSide: "")
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
    
    init(title : String, subtitle : String) {
        self.lblTitle.text = title
        self.lblSubtitle.text = subtitle
        super.init(frame: CGRectMake(0, 0, 100, 100))
        self.commonInit()
    }
    
    //MARK: setup
    
    private func commonInit() {
        
        self.lblSubtitle.font = font
        self.lblTitle.font = font
        self.tintColor = UIColor.clearColor()
        self.lblSubtitle.numberOfLines = 0
        self.lblTitle.numberOfLines = 0
        
        self.lblSubtitle.setContentCompressionResistancePriority(UILayoutPriorityRequired, forAxis: UILayoutConstraintAxis.Vertical)
        self.lblSubtitle.setContentHuggingPriority(UILayoutPriorityRequired, forAxis: UILayoutConstraintAxis.Horizontal)
        
        self.lblTitle.setContentCompressionResistancePriority(UILayoutPriorityRequired, forAxis: UILayoutConstraintAxis.Vertical)
        self.lblTitle.setContentHuggingPriority(UILayoutPriorityRequired, forAxis: UILayoutConstraintAxis.Horizontal)
        
        
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.ExtraLight)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.bounds
        
        self.addSubview(blurEffectView)
        self.addSubview(self.lblTitle)
        self.addSubview(self.lblSubtitle)
        self.addSubview(self.lblIcon)
        
        blurEffectView.userInteractionEnabled = true
        lblTitle.userInteractionEnabled = true
        lblSubtitle.userInteractionEnabled = true
        
        blurEffectView.snp_makeConstraints { (make) -> Void in
            make.edges.equalTo(self)
        }
        
        self.lblIcon.snp_makeConstraints {[weak self] (make) -> Void in
            make.left.equalTo((self?.snp_left)!).offset(((self?.iconWidthHeightSize)!/2))
            make.centerY.equalTo((self?.snp_centerY)!)
            make.width.equalTo((self?.iconWidthHeightSize)!)
            make.height.equalTo((self?.iconWidthHeightSize)!)
        }
        
        if self.lblTitle.text?.isEmpty == false && self.lblSubtitle.text?.isEmpty == false {
            self.lblTitle.snp_makeConstraints {[weak self] (make) -> Void in
                make.top.equalTo((self?.snp_top)!).offset(15)
                make.left.equalTo((self?.lblIcon.snp_right)!)
                make.right.equalTo((self?.snp_right)!).offset(-30)
            }
            self.lblSubtitle.snp_makeConstraints {[weak self] (make) -> Void in
                make.top.equalTo((self?.lblTitle.snp_bottom)!).offset(10)
                make.left.equalTo((self?.lblTitle.snp_left)!)
                make.right.equalTo((self?.snp_right)!).offset(-30)
                make.bottom.equalTo((self?.snp_bottom)!).offset(-10)
            }
        } else {
            
            if self.lblTitle.text?.isEmpty == false {
                self.lblTitle.snp_makeConstraints {[weak self] (make) -> Void in
                    make.top.equalTo((self?.snp_top)!).offset(15)
                    make.left.equalTo((self?.lblIcon.snp_right)!).offset(6)
                    make.right.equalTo((self?.snp_right)!).offset(-20)
                    make.bottom.equalTo((self?.snp_bottom)!).offset(-10)
                }
            } else {
                self.lblSubtitle.snp_makeConstraints {[weak self] (make) -> Void in
                    make.top.equalTo((self?.snp_top)!).offset(15)
                    make.left.equalTo((self?.lblIcon.snp_right)!).offset(6)
                    make.right.equalTo((self?.snp_right)!).offset(-20)
                    make.bottom.equalTo((self?.snp_bottom)!).offset(-10)
                }
            }
            
        }
        
    }
    
    
}