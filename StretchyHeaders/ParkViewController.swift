//
//  ParkViewController.swift
//  StretchyHeaders
//
//  Created by Mats Becker on 8/25/16.
//

import UIKit
import MXParallaxHeader

private let parallaxHeaderHeight: CGFloat = 270
private let parallaxHeaderMinimumHeight: CGFloat = 64
private let kTableHeaderHeight: CGFloat = 270
private let kTableHeaderCutAway: CGFloat = 60
private let contentOffset: CGFloat = 225

class ParkViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet var headerUIView: HeaderUIView!
    
    var headerMaskLayer: CAShapeLayer!
    var navBarHeight: CGFloat = 0.0
    // create background images for the navigation bar
    var navBarImage = UIImage().imageWithColor(UIColor(red:0.11, green:0.64, blue:0.98, alpha:0.0))
    var gradientImage32 = UIImage().imageWithColor(UIColor(red:0.11, green:0.64, blue:0.98, alpha:0.0))
    
    var yourLabel: UILabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.delegate = self
        
        // Navigation Bar
        
        navBarHeight = self.navigationController!.navigationBar.frame.height
        self.navigationController!.navigationBar.setBackgroundImage(navBarImage, forBarMetrics: .Default)
        self.navigationController!.navigationBar.setBackgroundImage(navBarImage, forBarMetrics: .Compact)
        self.navigationController!.navigationBar.shadowImage = UIImage()
        self.navigationController!.navigationBar.barStyle = .Default

        
        // Header
        
        headerUIView.addBackgroundColorParkImage(400 + 200)

        scrollView.parallaxHeader.view = headerUIView
        scrollView.parallaxHeader.height = parallaxHeaderHeight
        scrollView.parallaxHeader.minimumHeight = parallaxHeaderMinimumHeight
        scrollView.parallaxHeader.mode = MXParallaxHeaderMode.Fill
        
        scrollView.contentInset = UIEdgeInsets(top: contentOffset, left: 0, bottom: 0, right: 0)
        scrollView.contentOffset = CGPoint(x: 0, y: -contentOffset)
        
        headerMaskLayer = CAShapeLayer()
        headerMaskLayer.fillColor = UIColor.redColor().CGColor
        
        headerUIView.layer.mask = headerMaskLayer
        updateHeaderView()
        
        
        
        yourLabel.frame = CGRectMake(8, -20 - kTableHeaderCutAway / 4, scrollView.bounds.width - 28, 13)
        yourLabel.backgroundColor = UIColor.clearColor()
        yourLabel.textColor = UIColor.blackColor()
        yourLabel.textAlignment = NSTextAlignment.Left
        yourLabel.font = UIFont(name: "HelveticaNeue", size: 13.0)
        yourLabel.text = "View from park"
        scrollView.addSubview(yourLabel)
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        updateHeaderView()
    }
    
    func updateHeaderView() {
        
        let headerRect = CGRect(x: 0, y: -kTableHeaderHeight, width: scrollView.bounds.width, height: kTableHeaderHeight)
        
        
        // Update position / constraint of button in header
        if(scrollView.contentOffset.y < -(contentOffset - kTableHeaderCutAway)) {
            var posx = kTableHeaderCutAway - (scrollView.contentOffset.y + contentOffset)
            if posx < 8 {
                posx = 8
            }
            
            headerUIView.updateParkPosition(posx)
            
            let opacity: Float = (Float(posx)-8) / (60-8)
            headerUIView.updateParkButtonOpacity(opacity)
        }
        
        /* Percentage top arallaxHeaderMinimumHeight */
//        let base = parallaxHeaderHeight - parallaxHeaderMinimumHeight
//        let counter = -scrollView.contentOffset.y - parallaxHeaderMinimumHeight
        
        /* Percentage to kTableHeaderCutAway */
        let base = kTableHeaderCutAway
        var counter:CGFloat = 0.00
        if(-scrollView.contentOffset.y >= parallaxHeaderHeight-kTableHeaderHeight){
            counter = 289 - (-scrollView.contentOffset.y)
        }
        if(scrollView.contentOffset.y >= 0){
            counter = kTableHeaderHeight
        }
        
        
        
        var alpha = counter / base
        if(alpha <= 0){
            alpha = 0
        }
        if(alpha >= 1.00){
            alpha = 1
        }
        print("---")
        print("scrollView.contentOffset.y - \(scrollView.contentOffset.y)")
        print("counter - \(counter)")
        print("base - \(base)")
        print("alpha - \(alpha)")
        
        headerUIView.updateAlpha(alpha)
        
        navBarImage = UIImage().imageWithColor(UIColor(red: 0.114, green: 0.639, blue: 0.984, alpha: alpha))
        self.navigationController!.navigationBar.setBackgroundImage(navBarImage, forBarMetrics: .Default)
        self.navigationController!.navigationBar.setBackgroundImage(navBarImage, forBarMetrics: .Compact)
        
        // Update header image caption
        if(counter > 5){
            yourLabel.textColor = UIColor.clearColor()
        } else {
            yourLabel.textColor = UIColor.blackColor()
        }
        
        headerUIView.frame = headerRect
        
        let path = UIBezierPath()
        path.moveToPoint(CGPoint(x: 0, y: 0))
        path.addLineToPoint(CGPoint(x: headerRect.width, y: 0))
        path.addLineToPoint(CGPoint(x: headerRect.width, y: headerRect.height))
        path.addLineToPoint(CGPoint(x: 0, y: headerRect.height-kTableHeaderCutAway))
        headerMaskLayer?.path = path.CGPath
        
       
    }
    
    

}