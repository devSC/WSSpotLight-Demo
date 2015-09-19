//
//  WSSpotLightHelper.m
//  WSCoreSpotLight-Demo
//
//  Created by Wilson-Yuan on 15/9/19.
//  Copyright © 2015年 Wilson-Yuan. All rights reserved.
//

#import "WSSpotLightHelper.h"
//#import <CoreSpotlight/CoreSpotlight.h>
@import CoreSpotlight;
@import UIKit;

@interface WSSpotLightHelper ()

@property (nonatomic, strong) NSMutableArray *searchItems;

@end

@implementation WSSpotLightHelper

+ (instancetype)helper
{
    static dispatch_once_t onceToken;
    static WSSpotLightHelper *helper;
    dispatch_once(&onceToken, ^{
        helper = [[self alloc] init];
    });
    return helper;
}
- (void)deleteAllSearchAbleItems
{
    [[CSSearchableIndex defaultSearchableIndex] deleteAllSearchableItemsWithCompletionHandler:^(NSError * _Nullable error) {
        if (error) {
            NSLog(@"%@", error.localizedDescription);
        } else {
            NSLog(@"Delete all success");
        }
    }];
}

- (void)addNameToCoreSearchWithName: (NSString *)name
{
    if (name) {
        
        //1.创建一个set 将信息添加进对应的属性中
        CSSearchableItemAttributeSet *attributeSet = [[CSSearchableItemAttributeSet alloc] initWithItemContentType:@"string"/*这里要指定信息类型*/];
        
        //2.将name的值付给title
        attributeSet.title = name;
        //3.添加描述信息
        attributeSet.contentDescription = @"This is a description";
        //4.添加缩略图
        attributeSet.thumbnailData = UIImagePNGRepresentation([UIImage imageNamed:@"image"]);

        //当然还可以添加其他的一些信息:
        /*
        attributeSet.identifier = @"hahahha";
        //添加
        attributeSet.URL = [NSURL URLWithString:@"https://www.baidu.com"];
        attributeSet.path = [NSString stringWithFormat:@"searchpath:%ld", self.searchItems.count -1];
         
        attributeSet.contentModificationDate = [NSDate date];
         */
        
        /* ---
            5.创建搜索类对象 注意这里的UniqueIdentifier必须唯一,
            后面我们要根据这个来跳转页面或者进行下一步操作
            domainIdenfifier 域名标记 如果域名标记相同,则他们属于一种类,Apple推荐我们用
            <account-id>.<mailbox-id>这种方式来进行命名.
         */
        
        CSSearchableItem *itemType = [[CSSearchableItem alloc] initWithUniqueIdentifier:[NSString stringWithFormat:@"%ld", self.searchItems.count -1] domainIdentifier:[NSString stringWithFormat:@"com.wilson.coreSpotLight.demo%ld", self.searchItems.count -1] attributeSet:attributeSet];
        itemType.expirationDate = [NSDate dateWithTimeIntervalSinceNow:20];
        
        //6. 将SearchableItem对象添加进数组.
        [self.searchItems addObject:itemType];
        
        //7. 判断当前设备是否支持索引
        if ([CSSearchableIndex isIndexingAvailable]) {
            
            //8. 将数据同步进索引库
            [[CSSearchableIndex defaultSearchableIndex] indexSearchableItems:self.searchItems completionHandler:^(NSError * _Nullable error) {
                if (error) {
                    NSLog(@"there has a error when save to searchIndex : %@", error.description);
                } else {
                    NSLog(@"Update Success");
                }
            }];

        }
        
    }
}

- (NSMutableArray *)searchItems
{
    if (!_searchItems) {
        _searchItems = [NSMutableArray new];
    }
    return _searchItems;
}
@end
