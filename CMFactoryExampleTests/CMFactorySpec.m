#import "CMFactory.h"
#import "CMMessage.h"
#import "CMImage.h"
#import "Kiwi.h"

SPEC_BEGIN(CMFactorySpec)

describe(@"CMFactory", ^{
   
    describe(@".buildUsingMantleClass:fromFactory:", ^{
    
        context(@"when file not found", ^{
            
            it(@"should send a warn", ^{
                
                [[theBlock(^{
                    [CMFactory buildUsingMantleClass:[CMMessage class] fromFactory:@"WhateverFile"];
                }) should] raiseWithName:@"NoFileFound" reason:@"Neither .plist nor .json files were found with factory name"];
                
            });
            
        });
        
        context(@"when file is .json", ^{
            
            specify(^{
                
                [[theBlock(^{
                    [CMFactory buildUsingMantleClass:[CMMessage class] fromFactory:@"Message"];
                }) shouldNot] raiseWithName:@"NoFileFound" reason:@"Neither .plist nor .json files were found with factory name"];
                
            });
            
        });
        
        context(@"when file is .plist", ^{
            
            specify(^{
                
                [[theBlock(^{
                    [CMFactory buildUsingMantleClass:[CMMessage class] fromFactory:@"Image"];
                }) shouldNot] raiseWithName:@"NoFileFound" reason:@"Neither .plist nor .json files were found with factory name"];
                
            });
            
        });
        
        context(@"when it's not a MTLModel subclass", ^{
           
            it(@"should send warn", ^{
               
                [[theBlock(^{
                    [CMFactory buildUsingMantleClass:[NSString class] fromFactory:@"Message"];
                }) should] raiseWithName:@"NoMantleClassException" reason:@"This class is not a subclass of MTLModel"];
                
            });
            
        });
        
        context(@"when it's an MTLModel subclass", ^{
        
            it(@"should not send warn", ^{
                
                [[theBlock(^{
                    [CMFactory buildUsingMantleClass:[CMMessage class] fromFactory:@"Message"];
                }) shouldNot] raiseWithName:@"NoMantleClassException" reason:@"This class is not a subclass of MTLModel"];
                
            });
            
            context(@"when is dictionary", ^{
            
                context(@"when file is .json", ^{
                    
                    __block CMMessage *message;
                    __block CMMessage *expectedMessage;
                    
                    beforeEach(^{
                        message = [CMFactory buildUsingMantleClass:[CMMessage class] fromFactory:@"Message"];
                        expectedMessage = [CMMessage mockMessage];
                    });
                    
                    specify(^{
                        [[message should] beNonNil];
                    });
                    
                    specify(^{
                        [[message.content should] equal:expectedMessage.content];
                    });
                    
                    specify(^{
                        [[message.image.url should] equal:expectedMessage.image.url];
                    });
                    
                });
                
                context(@"when file is .plist", ^{
                    
                    __block CMImage *image;
                    __block CMImage *expectedImage;
                    
                    beforeEach(^{
                        image = [CMFactory buildUsingMantleClass:[CMImage class] fromFactory:@"Image"];
                        expectedImage = [CMImage mockImage];
                    });
                    
                    specify(^{
                        [[image should] beNonNil];
                    });
                    
                    specify(^{
                        [[image.url should] equal:expectedImage.url];
                    });
                    
                });
                
            });
            
            context(@"when is array", ^{
               
                context(@"when file is .json", ^{
                   
                    __block NSArray *messages;
                    __block NSArray *expectedMessages;
                    
                    beforeEach(^{
                        messages = [CMFactory buildUsingMantleClass:[CMMessage class] fromFactory:@"Messages"];
                        expectedMessages = [CMMessage mockMessages];
                    });
                    
                    specify(^{
                        [[messages should] beNonNil];
                        
                    });
                    
                    specify(^{
                        [[theValue(messages.count) should] beGreaterThan:theValue(0)];
                    });
                    
                    specify(^{
                       [[theValue(messages.count) should] equal:theValue(expectedMessages.count)];
                    });
                    
                });
                
                context(@"when file is .plist", ^{
                   
                    __block NSArray *images;
                    __block NSArray *expectedImages;
                    
                    beforeEach(^{
                        images = [CMFactory buildUsingMantleClass:[CMImage class] fromFactory:@"Images"];
                        expectedImages = [CMImage mockImages];
                    });
                    
                    specify(^{
                        [[images should] beNonNil];
                    });
                    
                    specify(^{
                        [[theValue(images.count) should] beGreaterThan:theValue(0)];
                    });
                    
                    specify(^{
                        [[theValue(images.count) should] equal:theValue(images.count)];
                    });

                });
                
            });
        
        });
        
    });
    
    describe(@".buildFromFactory:", ^{
        
        context(@"when file not found", ^{
            
            it(@"should send a warn", ^{
                
                [[theBlock(^{
                    [CMFactory buildUsingFactory:@"WhateverFile"];
                }) should] raiseWithName:@"NoFileFound" reason:@"Neither .plist nor .json files were found with factory name"];
                
            });
            
        });
        
        context(@"when file is .json", ^{
            
            specify(^{
                
                [[theBlock(^{
                    [CMFactory buildUsingFactory:@"Message"];
                }) shouldNot] raiseWithName:@"NoFileFound" reason:@"Neither .plist nor .json files were found with factory name"];
                
            });
            
        });
        
        context(@"when file is .plist", ^{
            
            specify(^{
                
                [[theBlock(^{
                    [CMFactory buildUsingFactory:@"Image"];
                }) shouldNot] raiseWithName:@"NoFileFound" reason:@"Neither .plist nor .json files were found with factory name"];
                
            });
            
        });
        
        context(@"when is dictionary", ^{
            
            context(@"when file is .json", ^{
                
                __block NSDictionary *message;
                __block NSDictionary *expectedMessage;
                
                beforeEach(^{
                    message = [CMFactory buildUsingFactory:@"Message"];
                    expectedMessage = [CMMessage mockMessageDictionary];
                });
                
                specify(^{
                    [[message should] beNonNil];
                    [[[message objectForKey:@"message"] should] beNonNil];
                });
                
                specify(^{
                    [[[[message objectForKey:@"message"] objectForKey:@"content"] should] equal:[[expectedMessage objectForKey:@"message"] objectForKey:@"content"]];
                });
                
            });
            
            context(@"when file is .plist", ^{
                
                __block NSDictionary *image;
                __block NSDictionary *expectedImage;
                
                beforeEach(^{
                    image = [CMFactory buildUsingFactory:@"Image"];
                    expectedImage = [CMImage mockImageDictionaryFromPlist];
                });
                
                specify(^{
                    [[image should] beNonNil];
                });
                
                specify(^{
                    [[[image objectForKey:@"url"] should] equal:[expectedImage objectForKey:@"url"]];
                });
                
            });
            
            context(@"when is array", ^{
                
                context(@"when file is .json", ^{
                    
                    __block NSArray *messages;
                    __block NSArray *expectedMessages;
                    
                    beforeEach(^{
                        messages = [CMFactory buildUsingFactory:@"Messages"];
                        expectedMessages = [CMMessage mockMessagesArrayOfDictionary];
                    });
                    
                    specify(^{
                        [[messages should] beNonNil];
                        
                    });
                    
                    specify(^{
                        [[theValue(messages.count) should] beGreaterThan:theValue(0)];
                    });
                    
                    specify(^{
                        [[theValue(messages.count) should] equal:theValue(expectedMessages.count)];
                    });
                    
                });
                
                context(@"when file is .plist", ^{
                    
                    __block NSArray *images;
                    __block NSArray *expectedImages;
                    
                    beforeEach(^{
                        images = [CMFactory buildUsingFactory:@"Images"];
                        expectedImages = [CMImage mockImagesArrayOfDictionary];
                    });
                    
                    specify(^{
                        [[images should] beNonNil];
                    });
                    
                    specify(^{
                        [[theValue(images.count) should] beGreaterThan:theValue(0)];
                    });
                    
                    specify(^{
                        [[theValue(images.count) should] equal:theValue(images.count)];
                    });
                    
                });
                
            });
            
        });
        
    });
    
});

SPEC_END