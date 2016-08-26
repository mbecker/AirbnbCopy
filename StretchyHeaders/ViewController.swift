//
//  ViewController.swift
//  StretchyHeaders
//
//  Created by Matthew Cheok on 21/9/14.
//  Copyright (c) 2014 Matthew Cheok. All rights reserved.
//

import UIKit
import MXParallaxHeader

private let parallaxHeaderHeight: CGFloat = 150
private let parallaxHeaderMinimumHeight: CGFloat = 64
private let kTableHeaderHeight: CGFloat = 400.0
private let kTableHeaderCutAway: CGFloat = 60.0
private let contentOffset: CGFloat = 250.0

class ViewController: UITableViewController {
    var headerView: UIView!
    var headerMaskLayer: CAShapeLayer!
    
    @IBOutlet weak var headerUIView: HeaderUIView!
    
    let items = [
        NewsItem(category: .World, summary: "The Addo Elephant Park is a park located in Sout Africa south coast. It's fully of elephants, giraffes, and some zebras. The area is ..."),
        NewsItem(category: .Europe, summary: "Scotland's 'Yes' leader says independence vote is 'once in a lifetime'"),
        NewsItem(category: .MiddleEast, summary: "Airstrikes boost Islamic State, FBI director warns more hostages possible"),
        NewsItem(category: .Africa, summary: "Nigeria says 70 dead in building collapse; questions S. Africa victim claim"),
        NewsItem(category: .AsiaPacific, summary: "Despite UN ruling, Japan seeks backing for whale hunting"),
        NewsItem(category: .Americas, summary: "Officials: FBI is tracking 100 Americans who fought alongside IS in Syria"),
        NewsItem(category: .World, summary: "South Africa in $40 billion deal for Russian nuclear reactors"),
        NewsItem(category: .Europe, summary: "'One million babies' created by EU student exchanges"),
        NewsItem(category: .World, summary: "Climate change protests, divestments meet fossil fuels realities"),
        NewsItem(category: .Europe, summary: "Scotland's 'Yes' leader says independence vote is 'once in a lifetime'"),
        NewsItem(category: .MiddleEast, summary: "Airstrikes boost Islamic State, FBI director warns more hostages possible"),
        NewsItem(category: .Africa, summary: "Nigeria says 70 dead in building collapse; questions S. Africa victim claim"),
        NewsItem(category: .AsiaPacific, summary: "Despite UN ruling, Japan seeks backing for whale hunting"),
        NewsItem(category: .Americas, summary: "Officials: FBI is tracking 100 Americans who fought alongside IS in Syria"),
        NewsItem(category: .World, summary: "South Africa in $40 billion deal for Russian nuclear reactors"),
    ]
    
    func updateHeaderView() {
        let effectiveHeight = kTableHeaderHeight-kTableHeaderCutAway/2 // 370
        var headerRect = CGRect(x: 0, y: -effectiveHeight, width: tableView.bounds.width, height: kTableHeaderHeight)
        if tableView.contentOffset.y < -effectiveHeight {
            headerRect.origin.y = tableView.contentOffset.y
            headerRect.size.height = -tableView.contentOffset.y + kTableHeaderCutAway/2 // 400
        }
        
//      Update position / constraint of button in header
        if(tableView.contentOffset.y < -(contentOffset - kTableHeaderCutAway)) {
            var posx = kTableHeaderCutAway - (tableView.contentOffset.y + contentOffset)
            if posx < 8 {
                posx = 8
            }
            
            headerUIView.updateParkPosition(posx)
            
            let opacity: Float = (Float(posx)-8) / (60-8)
            headerUIView.updateParkButtonOpacity(opacity)
        }
        let base = contentOffset + (150 - 64)
        let counter = (150 - 64) + (-tableView.contentOffset.y)
        var alpha = counter / base
        if(alpha <= 0){
            alpha = 0
        }
        print("Alpha - \(counter / base)")
        headerUIView.updateAlpha(alpha)
        
        headerUIView.frame = headerRect
        
        let path = UIBezierPath()
        path.moveToPoint(CGPoint(x: 0, y: 0))
        path.addLineToPoint(CGPoint(x: headerRect.width, y: 0))
        path.addLineToPoint(CGPoint(x: headerRect.width, y: headerRect.height))
        path.addLineToPoint(CGPoint(x: 0, y: headerRect.height-kTableHeaderCutAway))
        headerMaskLayer?.path = path.CGPath
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return false
    }

    override func viewDidLoad() {
        super.viewDidLoad()

//        headerView = tableView.tableHeaderView
        tableView.tableHeaderView = nil
//        tableView.addSubview(headerView)


/*        Original size for header view         */
//        let effectiveHeight = kTableHeaderHeight-kTableHeaderCutAway/2
//        tableView.contentInset = UIEdgeInsets(top: effectiveHeight, left: 0, bottom: 0, right: 0)
//        tableView.contentOffset = CGPoint(x: 0, y: -effectiveHeight)
        
        headerUIView.addBackgroundColorParkImage(400 + 200)
        
        tableView.parallaxHeader.view = headerUIView
        tableView.parallaxHeader.height = parallaxHeaderHeight
        tableView.parallaxHeader.minimumHeight = parallaxHeaderMinimumHeight
        tableView.parallaxHeader.mode = MXParallaxHeaderMode.Fill
        
        tableView.contentInset = UIEdgeInsets(top: contentOffset, left: 0, bottom: 0, right: 0)
        tableView.contentOffset = CGPoint(x: 0, y: -contentOffset)
        
        headerMaskLayer = CAShapeLayer()
        headerMaskLayer.fillColor = UIColor.redColor().CGColor
        
        headerUIView.layer.mask = headerMaskLayer
        updateHeaderView()
        
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        updateHeaderView()
    }

    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        coordinator.animateAlongsideTransition({ (context) -> Void in
            [self]
            self.updateHeaderView()
            self.tableView.reloadData()
        }, completion: { (context) -> Void in
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - UITableViewDataSource
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let item = items[indexPath.row]
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! NewsItemCell
        cell.newsItem = item
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    // MARK: - UITableViewDelegate
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    override func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }

    // MARK: - UIScrollViewDelegate
    
    override func scrollViewDidScroll(scrollView: UIScrollView) {
        updateHeaderView()
    }
}

