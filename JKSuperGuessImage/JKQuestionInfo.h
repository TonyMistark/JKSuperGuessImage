//
//  JKQuestionInfo.h
//  JKSuperGuessImage
//
//  Created by 弥超 on 15/10/1.
//  Copyright © 2015年 弥超. All rights reserved.
//


#import <Foundation/Foundation.h>
#include <UIKit/UIKit.h>

@interface JKQuestionInfo : NSObject

@property(nonatomic, copy) NSString *answer;
@property(nonatomic, copy) NSString *icon;
@property(nonatomic, copy) NSString *title;
@property(nonatomic, strong) NSString *options;

-(instancetype)initWithDict:(NSDictionary *)dict;//对象方法
+(instancetype)questionWithDict:(NSDictionary *)dict;//类方法

@property(nonatomic, strong, readonly)UIImage *image;

+(NSArray *)questions;

@end
