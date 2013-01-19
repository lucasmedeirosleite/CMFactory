//
//  CMFactory.h
//  CMFactoryExample
//
//  Created by Lucas Medeiros on 18/01/13.
//  Copyright (c) 2013 Codeminer42. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CMFactory : NSObject

+ (id) buildUsingMantleClass:(Class) objectClass fromFactory:(NSString *)fileName;
+ (id) buildUsingFactory:(NSString *)fileName;

@end
