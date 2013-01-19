//
//  CMImage.m
//  CMFactoryExample
//
//  Created by Lucas Medeiros on 18/01/13.
//  Copyright (c) 2013 Codeminer42. All rights reserved.
//

#import "CMImage.h"

@implementation CMImage

+ (NSDictionary *)externalRepresentationKeyPathsByPropertyKey
{
    return @{
        @"url" : @"url"
    };
}

+ (CMImage *)mockImage
{
    CMImage *image = [[CMImage alloc] init];
    image.url = @"www.github.com";
    return image;
}

+ (NSDictionary *)mockImageDictionaryFromPlist
{
    return @{ @"url" : @"www.github.com" };
}

+ (NSArray *)mockImages
{
    NSMutableArray *array = [NSMutableArray array];
    for (NSUInteger i = 0; i < 2; i ++) {
        CMImage *image = [self mockWithURLString:[NSString stringWithFormat:@"www.github.com%d", i]];
        [array addObject:image];
    }
    return array;
}

+ (CMImage *)mockWithURLString:(NSString *)urlString
{
    CMImage *image = [[CMImage alloc] init];
    image.url = urlString;
    return image;
}

+ (NSArray *)mockImagesArrayOfDictionary
{
    return @[
                @{ @"url" : @"www.github.com0" },
                @{ @"url" : @"www.github.com1" }
    ];
}

@end
