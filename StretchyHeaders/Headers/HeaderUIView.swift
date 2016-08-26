//
//  HeaderUIView.swift
//  StretchyHeaders
//
//  Created by Mats Becker on 8/24/16.
//

import UIKit

class HeaderUIView: UIView {
    @IBOutlet weak var parkBottomConstraint: NSLayoutConstraint!
    
    let image = UIImage(named: "bg-addo")
    
    @IBOutlet weak var parkHeaderView: UIView! {
        didSet {
            parkHeaderView.backgroundColor = UIColor(red: 0.114, green: 0.639, blue: 0.984, alpha: 0)
        }
    }
    
    @IBOutlet weak var parkHeading: UILabel! {
        didSet {
            parkHeading.textColor = UIColor.clearColor()
        }
    }
    
    @IBOutlet weak var parkButton: UIButton! {
        didSet {
            parkButton.backgroundColor = UIColor.clearColor()
            parkButton.layer.opacity = 1
            
        }
    }
    
    @IBAction func parkButtonDidTouch(sender: AnyObject) {
        print("parkButton did touch ...")
    }
    
    @IBOutlet weak var parkImage: UIImageView! {
        didSet {
//            parkImage.image = image?.imageWithAlpha(1.00)
        }
    }
    
    func addBackgroundColorParkImage(width: CGFloat, height: CGFloat){
        let overlay: UIView = UIView(frame: CGRectMake(0, 0, width, height))
        overlay.backgroundColor = UIColor(red: 0.114, green: 0.639, blue: 0.984, alpha: 0.4)
        parkImage.addSubview(overlay)
    }
    
    func addBackgroundColorParkImage(height: CGFloat){
        let overlay: UIView = UIView(frame: CGRectMake(0, 0, UIScreen.mainScreen().bounds.height, height))
        overlay.backgroundColor = UIColor(red:0.04, green:0.28, blue:0.44, alpha:0.4)
        parkImage.addSubview(overlay)
    }
    
    func updateParkPosition(x: CGFloat){
        
        UIView.animateWithDuration(1, animations: {
            self.parkBottomConstraint.constant = x
        })
        
    }
    
    func updateParkButtonOpacity(opacity: Float){
        parkButton.layer.opacity = opacity
    }
    
    func updateAlpha(alpha: CGFloat){
//        parkImage.image = image?.imageWithAlpha(CGFloat(alpha))
        parkHeaderView.backgroundColor = UIColor(red: 0.114, green: 0.639, blue: 0.984, alpha: alpha)
    }
}