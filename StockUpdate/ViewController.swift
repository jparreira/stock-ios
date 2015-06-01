//
//  ViewController.swift
//  StockUpdate
//
//  Created by Joao Caixinha on 30/10/14.
//  Copyright (c) 2014 Realtime. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var viewConnected: UIView!
    @IBOutlet weak var labelStock: UILabel!
    @IBOutlet weak var labelBefore: UILabel!
    @IBOutlet weak var labelPrice: UILabel!
    @IBOutlet weak var buttonBuy: UIButton!
    @IBOutlet weak var labelConnection: UILabel!
    
    var ortc:ORTC?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.ortc = ORTC()
        self.ortc!.connect()
        self.setLabels()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "connected", name: "ortcConnect", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "updatePrice:", name: "updatePrice", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "updateStock:", name: "updateStock", object: nil)
    }
    
    func setLabels(){
        self.labelBefore.hidden = true
    }
    
    func updatePrice(notification: NSNotification)
    {
        var priceA:NSArray = notification.object!.componentsSeparatedByString("<em> ") as NSArray
        var priceAA:NSArray = priceA.objectAtIndex(1).componentsSeparatedByString("</em>") as NSArray
        var priceBefore:String = priceAA.objectAtIndex(0) as String
        
        var priceB:NSArray = notification.object!.componentsSeparatedByString("<span>now ") as NSArray
        var priceBB:NSArray = priceB.objectAtIndex(1).componentsSeparatedByString("</span>") as NSArray
        var price:String = priceBB.objectAtIndex(0) as String
        
        self.animatePrice(priceBefore, now: price)
    }
    
    func animatePrice(before: String, now: String){
        UIView.animateWithDuration(0.6, delay: 0.3, options: .CurveEaseOut, animations: {
            self.labelBefore.textColor = UIColor.redColor()
            self.labelBefore.alpha = 0.0
            
            self.labelPrice.textColor = UIColor.redColor()
            self.labelPrice.alpha = 0.0
            }, completion: { finished in
                
                if self.labelBefore.hidden == true
                {
                    var sizeText:CGSize = Utils.sizeForText("before ", label: self.labelBefore)
                    var sizeBefore:CGSize = Utils.sizeForText(before, label: self.labelBefore)
                    var line:UIView = UIView(frame: CGRectMake(sizeText.width, self.labelBefore.frame.height / 2, sizeBefore.width, 1))
                    line.backgroundColor = UIColor.blackColor()
                    
                    self.labelBefore.addSubview(line)
                }
                
                self.labelBefore.textColor = UIColor.blackColor()
                self.labelBefore.alpha = 1.0
                self.labelBefore.text = "before " + before
                self.labelBefore.hidden = false               
                
                self.labelPrice.textColor = UIColor.blackColor()
                self.labelPrice.alpha = 1.0
                self.labelPrice.text = "now " + now
                self.labelPrice.frame = CGRectMake(16, 434, self.labelPrice.frame.size.width, self.labelPrice.frame.size.height)
        })
    }
    
    func updateStock(notification: NSNotification)
    {
        self.animateStock(notification.object! as String)
    }
    
    func animateStock(val: String){
        UIView.animateWithDuration(0.6, delay: 0.3, options: .CurveEaseOut, animations: {
                self.labelStock.textColor = UIColor.redColor()
                self.labelStock.alpha = 0.0
            }, completion: { finished in
                self.labelStock.textColor = UIColor.blackColor()
                self.labelStock.alpha = 1.0
                self.labelStock.text = "Available stock:" + val
        })
    }
    
    func connected(){
        labelConnection.text = "Connected"
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.setButton(buttonBuy)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func setButton(button: UIButton)
    {
        var image:UIImage = UIImage(named: "greyButton.png")
        var insets:UIEdgeInsets = UIEdgeInsetsMake(18, 18, 18, 18)
        var strechedImage = image.resizableImageWithCapInsets(insets)
        
        button.setBackgroundImage(strechedImage, forState: UIControlState.Normal)
    }

}

