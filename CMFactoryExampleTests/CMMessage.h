//
//  CMMessage.h
//  CMFactoryExample
//
//  Created by Lucas Medeiros on 18/01/13.
//  Copyright (c) 2013 Codeminer42. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Mantle.h"

@class CMImage;

@interface CMMessage : MTLModel <MTLJSONSerializing>

@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) CMImage *image;

+ (CMMessage *)mockMessage;
+ (NSDictionary *)mockMessageDictionary;
+ (NSArray *)mockMessages;
+ (NSArray *)mockMessagesArrayOfDictionary;

@end
