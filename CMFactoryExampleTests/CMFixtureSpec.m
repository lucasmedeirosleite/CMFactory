#import "CMFixture.h"
#import "CMMessage.h"
#import "CMImage.h"
#import "Kiwi.h"

SPEC_BEGIN(CMFixtureSpec)

describe(@"CMFactory", ^{
   
    describe(@".buildUsingMantleClass:fromFactory:", ^{
    
        context(@"when file not found", ^{
            
            it(@"should send a warn", ^{
                
                [[theBlock(^{
                    [CMFixture buildUsingMantleClass:[CMMessage class] fromFixture:@"WhateverFile"];
                }) should] raiseWithName:@"NoFileFound" reason:@"Neither .plist nor .json files were found with factory name"];
                
            });
            
        });
        
        context(@"when file is .json", ^{
            
            specify(^{
                
                [[theBlock(^{
                    [CMFixture buildUsingMantleClass:[CMMessage class] fromFixture:@"Message"];
                }) shouldNot] raiseWithName:@"NoFileFound" reason:@"Neither .plist nor .json files were found with factory name"];
                
            });
            
        });
        
        context(@"when file is .plist", ^{
            
            specify(^{
                
                [[theBlock(^{
                    [CMFixture buildUsingMantleClass:[CMMessage class] fromFixture:@"Image"];
                }) shouldNot] raiseWithName:@"NoFileFound" reason:@"Neither .plist nor .json files were found with factory name"];
                
            });
            
        });
        
        context(@"when it's not a MTLModel subclass", ^{
           
            it(@"should send warn", ^{
               
                [[theBlock(^{
                    [CMFixture buildUsingMantleClass:[NSString class] fromFixture:@"Message"];
                }) should] raiseWithName:@"NoMantleClassException" reason:@"This class is not a subclass of MTLModel"];
                
            });
            
        });
        
        context(@"when it's an MTLModel subclass", ^{
        
            it(@"should not send warn", ^{
                
                [[theBlock(^{
                    [CMFixture buildUsingMantleClass:[CMMessage class] fromFixture:@"Message"];
                }) shouldNot] raiseWithName:@"NoMantleClassException" reason:@"This class is not a subclass of MTLModel"];
                
            });
            
            context(@"when is dictionary", ^{
            
                context(@"when file is .json", ^{
                    
                    __block CMMessage *message;
                    __block CMMessage *expectedMessage;
                    
                    beforeEach(^{
                        message = [CMFixture buildUsingMantleClass:[CMMessage class] fromFixture:@"Message"];
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
                        image = [CMFixture buildUsingMantleClass:[CMImage class] fromFixture:@"Image"];
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
                        messages = [CMFixture buildUsingMantleClass:[CMMessage class] fromFixture:@"Messages"];
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
                        images = [CMFixture buildUsingMantleClass:[CMImage class] fromFixture:@"Images"];
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
                    [CMFixture buildUsingFixture:@"WhateverFile"];
                }) should] raiseWithName:@"NoFileFound" reason:@"Neither .plist nor .json files were found with factory name"];
                
            });
            
        });
        
        context(@"when file is .json", ^{
            
            specify(^{
                
                [[theBlock(^{
                    [CMFixture buildUsingFixture:@"Message"];
                }) shouldNot] raiseWithName:@"NoFileFound" reason:@"Neither .plist nor .json files were found with factory name"];
                
            });
            
        });
        
        context(@"when file is .plist", ^{
            
            specify(^{
                
                [[theBlock(^{
                    [CMFixture buildUsingFixture:@"Image"];
                }) shouldNot] raiseWithName:@"NoFileFound" reason:@"Neither .plist nor .json files were found with factory name"];
                
            });
            
        });
        
        context(@"when is dictionary", ^{
            
            context(@"when file is .json", ^{
                
                __block NSDictionary *message;
                __block NSDictionary *expectedMessage;
                
                beforeEach(^{
                    message = [CMFixture buildUsingFixture:@"Message"];
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
                    image = [CMFixture buildUsingFixture:@"Image"];
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
                        messages = [CMFixture buildUsingFixture:@"Messages"];
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
                        images = [CMFixture buildUsingFixture:@"Images"];
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