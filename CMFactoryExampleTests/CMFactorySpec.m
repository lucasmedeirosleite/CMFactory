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
                    
                    [factory addToField:@"age" value:^{
                        return @"www.github.com";
                    }];
                    
                }) should] raiseWithName:@"CMFieldNotFoundException" reason:@"The field passed was not found"];
                
            });
            
        });
        
        context(@"when field is not the same type of value type", ^{
           
            specify(^{
                
                [[theBlock(^{
                    
                    [factory addToField:@"age" value:^{
                        return [NSURL URLWithString:@"www.github.com" ];
                    }];
                    
                }) should] raise];
                
            });
            
        });
        
        specify(^{
            
            [factory addToField:@"url" value:^{
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
                [factory addToField:@"content" value:^{
                    return @"Test";
                }];
                [factory addToField:@"image" value:^{
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
    
    describe(@"#buildArrayWithCapacity:", ^{
        
        __block CMFactory *factory;
        __block NSArray *images;
        
        beforeEach(^{
            factory = [CMFactory forClass:[CMImage class]];
            [factory addToField:@"url" value:^{
                return @"www.github.com";
            }];
            images = [factory buildWithCapacity:3];
        });
        
        specify(^{
            [[images should] beNonNil];
        });
        
        specify(^{
            [[images should] haveCountOf:3];
        });
        
        context(@"when using sequence method", ^{
           
            beforeEach(^{
                factory = [CMFactory forClass:[CMImage class]];
                [factory addToField:@"url" sequenceValue:^(NSUInteger sequence) {
                    return [NSString stringWithFormat:@"www.github.com%d", sequence];
                }];
                images = [factory buildWithCapacity:3];
            });
        
            specify(^{
                [[images should] beNonNil];
            });
            
            specify(^{
                [[images should] haveCountOf:3];
            });
            
            specify(^{
               
                for(NSUInteger i = 0; i < 3; i++) {
                    CMImage *image = [images objectAtIndex:i];
                    [[image.url should] equal:[NSString stringWithFormat:@"www.github.com%d", i]];
                }
                
            });
            
        });
        
    });
    
});

SPEC_END