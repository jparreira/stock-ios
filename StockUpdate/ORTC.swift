//
//  ORTC.swift
//  StockUpdate
//
//  Created by Joao Caixinha on 30/10/14.
//  Copyright (c) 2014 Realtime. All rights reserved.
//

import UIKit

class ORTC: NSObject, OrtcClientDelegate {
    
    var ortc:OrtcClient?
    
    let appkey = "2Ze1dz"
    let token = "user"
    let metadata = "METADATA"
    let url = "https://ortc-developers.realtime.co/server/ssl/2.1"
    let productID = 1234;
    
    func connect() {
        self.ortc = OrtcClient.ortcClientWithConfig(self) as? OrtcClient
        self.ortc!.clusterUrl = url;
        self.ortc!.connect(appkey, authenticationToken: token)
    }
    
    
    func onConnected(ortc: OrtcClient!) {
        NSNotificationCenter.defaultCenter().postNotificationName("ortcConnect", object: nil)
        
        self.ortc!.subscribe("price-update:" + productID.description, subscribeOnReconnected: true, onMessage: { (ortcClient:OrtcClient!, channel:String!, message:String!) -> Void in
            NSNotificationCenter.defaultCenter().postNotificationName("updatePrice", object: message)
            
        })
        
        self.ortc!.subscribe("stock-update:" + productID.description, subscribeOnReconnected: true, onMessage: { (ortcClient:OrtcClient!, channel:String!, message:String!) -> Void in
            var stockDictionary:NSDictionary = Utils.jsonDictionaryFromString(message) as NSDictionary!
            var stock:NSNumber = stockDictionary.objectForKey("stock") as NSNumber!
            NSNotificationCenter.defaultCenter().postNotificationName("updateStock", object: "\(stock)")
            
        })

    }
    
    func onDisconnected(ortc: OrtcClient!) {
        
    }
    
    func onException(ortc: OrtcClient!, error: NSError!) {
        
    }
    
    func onReconnected(ortc: OrtcClient!) {
        
    }
    
    func onReconnecting(ortc: OrtcClient!) {
        
    }
    
    func onSubscribed(ortc: OrtcClient!, channel: String!) {
        
    }
    
    func onUnsubscribed(ortc: OrtcClient!, channel: String!) {
        
    }
    
   
}
