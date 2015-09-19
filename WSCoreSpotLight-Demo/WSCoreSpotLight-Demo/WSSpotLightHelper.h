//
//  WSSpotLightHelper.h
//  WSCoreSpotLight-Demo
//
//  Created by Wilson-Yuan on 15/9/19.
//  Copyright © 2015年 Wilson-Yuan. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface WSSpotLightHelper : NSObject

+ (instancetype)helper;

- (void)addNameToCoreSearchWithName: (NSString *)name;

- (void)deleteAllSearchAbleItems;

@end
