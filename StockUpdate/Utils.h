//
//  Utils.h
//  RTMChatSwift
//
//  Created by Joao Caixinha on 16/10/14.
//  Copyright (c) 2014 Internet Business Technologies. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Utils : NSObject

+ (NSDictionary*) jsonDictionaryFromString:(NSString*) text;
+ (NSString*) jsonStringFromDictionary:(NSDictionary*) dict;
+ (CGSize)sizeForText:(NSString*)text label:(UILabel*)label;

@end
