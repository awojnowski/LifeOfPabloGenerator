//
//  PabloRenderController.h
//  LifeOfPablo
//
//  Created by Aaron Wojnowski on 2016-02-13.
//  Copyright © 2016 Aaron Wojnowski. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, PabloRenderVersion) {
    PabloRenderVersionNew,
    PabloRenderVersionOld
};

@interface PabloRenderController : NSObject

@property (nonatomic, assign) PabloRenderVersion renderVersion;
@property (nonatomic, strong) UIColor *backgroundColor;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) UIImage *image2;
@property (nonatomic, copy) NSString *text;
@property (nonatomic, copy) NSString *text2;

-(UIImage *)renderImageWithSize:(CGFloat)size;

@end
