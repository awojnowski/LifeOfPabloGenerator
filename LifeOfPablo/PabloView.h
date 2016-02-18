//
//  PabloView.h
//  LifeOfPablo
//
//  Created by Aaron Wojnowski on 2016-02-13.
//  Copyright © 2016 Aaron Wojnowski. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "PabloRenderController.h"

@protocol PabloViewDelegate;

@interface PabloView : UIView

@property (nonatomic, weak) id <PabloViewDelegate> delegate;

@property (nonatomic, assign) PabloRenderVersion version;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) UIImage *image2;
@property (nonatomic, copy) NSString *text;
@property (nonatomic, copy) NSString *text2;

@end

@protocol PabloViewDelegate <NSObject>

-(void)pabloViewDidTapImage:(PabloView *)pabloView;
-(void)pabloViewDidTapImage2:(PabloView *)pabloView;
-(void)pabloViewDidTapText1:(PabloView *)pabloView;
-(void)pabloViewDidTapText2:(PabloView *)pabloView;

@end
