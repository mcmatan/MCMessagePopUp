//
//  ViewController.swift
//  MCMessagePopUp
//
//  Created by Matan Cohen on 10/15/15.
//  Copyright © 2015 Matan Cohen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let popUpMessage = MCMessagePopUp()

    override func viewDidLoad() {
        super.viewDidLoad()
        let imageBack = UIImageView()
        imageBack.image = UIImage(named: "sea-7.jpg")
        self.view.addSubview(imageBack)
        imageBack.snp_makeConstraints { (make) -> Void in
            make.edges.equalTo(self.view)
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.delayForShow(kMessagePopUpStyle.Error)
        self.delayForShow(kMessagePopUpStyle.Success)
        self.delayForShow(kMessagePopUpStyle.Info)
        self.delayForShow(kMessagePopUpStyle.Success)
        self.delayForShow(kMessagePopUpStyle.Info)
        
    }
    
    func delayForShow(style : kMessagePopUpStyle) {
        let delayTime = dispatch_time(DISPATCH_TIME_NOW,
            Int64(1 * Double(NSEC_PER_SEC)))
        dispatch_after(delayTime, dispatch_get_main_queue()) {
            self.show(style)
        }
    }
    
    func show(style : kMessagePopUpStyle) {
        self.popUpMessage.showMessage(style, message: "some message some message some message some messagesome message some message", title: "title", mainScreen: self.view)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

