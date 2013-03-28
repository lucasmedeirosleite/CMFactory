//
//  CMMessage.m
//  CMFactoryExample
//
//  Created by Lucas Medeiros on 18/01/13.
//  Copyright (c) 2013 Codeminer42. All rights reserved.
//

#import "CMMessage.h"
#import "CMImage.h"
#import "MTLValueTransformer.h"

@implementation CMMessage

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
        @"content" : @"message.content",
        @"image" : @"message.image"
    };
}

+ (NSValueTransformer *)imageJSONTransformer {
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:CMImage.class];
}

+ (CMMessage *)mockMessage
{
    CMMessage *message = [[CMMessage alloc] init];
    message.content = @"Test";
    message.image = [CMImage mockImage];
    return message;
}

+ (NSDictionary *)mockMessageDictionary
{
    return @{ @"message" :
                @{
                    @"content" : @"Test",
                    @"image"   : @{ @"url" : @"www.github.com" }
                }
            };
}

+ (NSArray *)mockMessages
{
    NSMutableArray *array = [NSMutableArray array];
    for (NSUInteger i = 0; i < 2; i++) {
        CMMessage *message = [self mockMessageWithContent:[NSString stringWithFormat:@"Test%d", i] andWithImageURLString:[NSString stringWithFormat:@"www.github.com%d", i]];
        [array addObject:message];
    }
    return array;
}

+ (NSArray *)mockMessagesArrayOfDictionary
{
    return @[@{ @"message" :
                    @{
                        @"content" : @"Test0",
                        @"image"   : @{ @"url" : @"www.github.com0" }
                    }
              },
            @{ @"message" :
                    @{
                        @"content" : @"Test1",
                        @"image"   : @{ @"url" : @"www.github.com1" }
                    }
            }];
}

+ (CMMessage *)mockMessageWithContent:(NSString *)content andWithImageURLString:(NSString *)imageURLString
{
    CMMessage *message = [[CMMessage alloc] init];
    message.content = content;
    CMImage *image = [[CMImage alloc] init];
    image.url = imageURLString;
    message.image = image;
    return message;
}

@end
