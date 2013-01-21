#import "CMFactory.h"
#import "CMImage.h"
#import "CMMessage.h"
#import "Kiwi.h"

SPEC_BEGIN(CMFactorySpec)

describe(@"CMFactory", ^{

    specify(^{
        [[CMFactory should] respondToSelector:@selector(forClass:)];
    });
    
    describe(@".forClass:", ^{
       
        __block CMFactory *factory;
        
        beforeEach(^{
            factory = [CMFactory forClass:[CMImage class]];
        });
        
        specify(^{
            [[factory should] beNonNil];
        });
        
    });
    
    describe(@"#addToField:value:", ^{
       
        __block CMFactory *factory;
        
        beforeEach(^{
            factory = [CMFactory forClass:[CMImage class]];
        });
        
        context(@"when field was not found", ^{
            
            specify(^{
                
                [[theBlock(^{
                    
                    [factory addToField:@"age" value:^(CMFactory *factory) {
                        return @"www.github.com";
                    }];
                    
                }) should] raiseWithName:@"CMFieldNotFoundException" reason:@"The field passed was not found"];
                
            });
            
        });
        
        context(@"when field is not the same type of value type", ^{
           
            specify(^{
                
                [[theBlock(^{
                    
                    [factory addToField:@"age" value:^(CMFactory *factory) {
                        return [NSURL URLWithString:@"www.github.com" ];
                    }];
                    
                }) should] raise];
                
            });
            
        });
        
        specify(^{
            
            [factory addToField:@"url" value:^(CMFactory *factory) {
                return @"www.github.com";
            }];
            
            [[theValue(factory.fields.count) should] beGreaterThan:theValue(0)];
            [[[factory.fields objectForKey:@"url"] should] equal:@"www.github.com"];
            
        });
        
    });
    
    describe(@"#build", ^{
        
        __block CMFactory *factory;
        
        beforeEach(^{
            factory = [CMFactory forClass:[CMImage class]];
        });
        
        context(@"when it's an empty factory", ^{
        
            specify(^{
                [[[factory build] should] beNonNil];
            });
            
            specify(^{
                [[[factory build] should] beKindOfClass:[CMImage class]];
            });
            
        });
        
        context(@"when it's a factory with properties", ^{
           
            __block CMMessage *message;

            beforeEach(^{
                factory = [CMFactory forClass:[CMMessage class]];
                [factory addToField:@"content" value:^(CMFactory *factory) {
                    return @"Test";
                }];
                [factory addToField:@"image" value:^(CMFactory *factory) {
                    return [CMImage mockImage];
                }];
                message = [factory build];
            });
            
            specify(^{
                [[message should] beNonNil];
            });
            
            specify(^{
                [[message.content should] equal:[[CMMessage mockMessage] content]];
            });
            
            specify(^{
                [[message.image.url should] equal:[[CMImage mockImage] url]];
            });
            
        });
        
    });
    
});

SPEC_END