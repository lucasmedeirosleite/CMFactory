//
//  CMImage.h
//  CMFactoryExample
//
//  Created by Lucas Medeiros on 18/01/13.
//  Copyright (c) 2013 Codeminer42. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Mantle.h"

@interface CMImage : MTLModel <MTLJSONSerializing>

@property (nonatomic, copy) NSString *url;

+ (CMImage *)mockImage;
+ (NSDictionary *)mockImageDictionaryFromPlist;
+ (NSArray *)mockImages;
+ (NSArray *)mockImagesArrayOfDictionary;

@end
