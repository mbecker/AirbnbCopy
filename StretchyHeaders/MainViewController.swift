//
//  MainViewController.swift
//  StretchyHeaders
//
//  Created by Mats Becker on 8/26/16.
//  Copyright © 2016 Matthew Cheok. All rights reserved.
//

import UIKit

private let kTableHeaderHeight: CGFloat = 300.0
private let kTableHeaderCutAway: CGFloat = 60.0

class MainViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet var headerView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var parkHeading: UILabel!
    @IBOutlet weak var parkImage: UIImageView!
    
    var headerMaskLayer: CAShapeLayer!
    // create background images for the navigation bar
    var navBarImage = UIImage().imageWithColor(UIColor(red:0.11, green:0.64, blue:0.98, alpha:0.0))
    var gradientImage32 = UIImage().imageWithColor(UIColor(red:0.11, green:0.64, blue:0.98, alpha:0.0))
    
    let image = UIImage(named: "bg-addo")
    let overlay: UIView = UIView(frame: CGRectMake(0, 0, UIScreen.mainScreen().bounds.height, 400))
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.delegate = self
        
        // Adjust view
        self.automaticallyAdjustsScrollViewInsets = false
        
        // NavigationBar
        let attrs = [
            NSForegroundColorAttributeName : UIColor.blackColor(),
            NSFontAttributeName : UIFont(name: "HelveticaNeue-Bold", size: 17)!
        ]
        self.navigationController!.navigationBar.titleTextAttributes = attrs
        self.navigationController!.navigationBar.hidden = true
        self.navigationController!.navigationBar.setBackgroundImage(navBarImage, forBarMetrics: .Default)
        self.navigationController!.navigationBar.setBackgroundImage(navBarImage, forBarMetrics: .Compact)
//        self.navigationController!.navigationBar.shadowImage = UIImage()
        self.navigationController!.navigationBar.barStyle = .Default
        
        
        // Header
        overlay.backgroundColor = UIColor(red:0.04, green:0.28, blue:0.44, alpha:0.4)
        parkImage.addSubview(overlay)
        parkImage.image = image?.imageWithAlpha(1)
        
        headerMaskLayer = CAShapeLayer()
        headerMaskLayer.fillColor = UIColor.blackColor().CGColor
        
        headerView.layer.mask = headerMaskLayer
        updateHeaderView()
        
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        let heightShowNavBarStart   = kTableHeaderHeight - kTableHeaderCutAway - parkHeading.frame.height - 66
        let heightShowNavBarEnd     = kTableHeaderHeight - kTableHeaderCutAway - 66
        
        
        print("scrollView.contentOffset.y   -   \(scrollView.contentOffset.y)")
        print("heightShowNavBarStart        -   \(heightShowNavBarStart)")
        print("heightShowNavBarEnd          -   \(heightShowNavBarEnd)")
        
        
        
        let base        = parkHeading.frame.height
        let counter     = heightShowNavBarEnd - scrollView.contentOffset.y
        var alpha       = counter / base
        var navigationBarHidden = false;
        
        if(scrollView.contentOffset.y >= heightShowNavBarStart && scrollView.contentOffset.y <= heightShowNavBarEnd){
            
        } else if (scrollView.contentOffset.y < heightShowNavBarStart ){
            navigationBarHidden = true
            alpha = 1
        } else if(scrollView.contentOffset.y > heightShowNavBarEnd) {
            navigationBarHidden = false
            alpha = 0
        }
        print("alpha                - \(alpha)")
        print("navigationBarHidden  - \(navigationBarHidden)")
        
        
        self.navigationController!.navigationBar.hidden = navigationBarHidden
        
        if(!navigationBarHidden && alpha == 0){
            // Show navigationBar && hide headerView parkImage
            parkImage.hidden = true
            self.navigationController!.navigationBar.setBackgroundImage(nil, forBarMetrics: .Default)
            self.navigationController!.navigationBar.setBackgroundImage(nil, forBarMetrics: .Compact)
            self.navigationController!.navigationBar.barStyle = .Default
        } else {
            parkImage.hidden = false
            parkImage.image = image?.imageWithAlpha(alpha)
            navBarImage = UIImage().imageWithColor(UIColor(red:0.96, green:0.96, blue:0.98, alpha: 1 - alpha))
            self.navigationController!.navigationBar.setBackgroundImage(navBarImage, forBarMetrics: .Default)
            self.navigationController!.navigationBar.setBackgroundImage(navBarImage, forBarMetrics: .Compact)
            overlay.backgroundColor = UIColor(red:0.04, green:0.28, blue:0.44, alpha: alpha * 0.4)
        }
        
        
    }
    
    func updateHeaderView(){
        let effectiveHeight = kTableHeaderHeight-kTableHeaderCutAway/2
        var headerRect = CGRect(x: 0, y: -effectiveHeight, width: scrollView.bounds.width, height: kTableHeaderHeight)
        if scrollView.contentOffset.y < -effectiveHeight {
            headerRect.origin.y = scrollView.contentOffset.y
            headerRect.size.height = -scrollView.contentOffset.y + kTableHeaderCutAway/2
        }
        
        headerView.frame = headerRect
        
        let path = UIBezierPath()
        path.moveToPoint(CGPoint(x: 0, y: 0))
        path.addLineToPoint(CGPoint(x: headerRect.width, y: 0))
        path.addLineToPoint(CGPoint(x: headerRect.width, y: headerRect.height))
        path.addLineToPoint(CGPoint(x: 0, y: headerRect.height-kTableHeaderCutAway))
        headerMaskLayer?.path = path.CGPath
    }
    
}

extension UIImage {
    
    func imageWithColor(colour: UIColor) -> UIImage {
        let rect = CGRectMake(0, 0, 1, 1)
        
        // Create a 1x1 pixel content
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        colour.setFill()
        UIRectFill(rect)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    func imageWithAlpha(alpha: CGFloat) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        drawAtPoint(CGPointZero, blendMode: .Normal, alpha: alpha)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
    
}
