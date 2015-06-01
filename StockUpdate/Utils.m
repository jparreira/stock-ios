//
//  Utils.m
//  RTMChatSwift
//
//  Created by Joao Caixinha on 16/10/14.
//  Copyright (c) 2014 Internet Business Technologies. All rights reserved.
//

#import "Utils.h"


@implementation Utils



+ (NSDictionary*) jsonDictionaryFromString:(NSString*) text{
    
    NSError *error = nil;
    NSData *jsonData = [text dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&error];
    return dict;
}

+ (NSString*) jsonStringFromDictionary:(NSDictionary*) dict {
    
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

+ (CGSize)sizeForText:(NSString*)text label:(UILabel*)label
{
    UIFont *font = [UIFont systemFontOfSize:label.font.pointSize];
    return [text sizeWithFont:font
                       constrainedToSize:CGSizeMake(label.frame.size.width, 9999)
                           lineBreakMode:NSLineBreakByWordWrapping];
    
}


@end
