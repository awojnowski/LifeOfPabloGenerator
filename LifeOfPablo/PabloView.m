//
//  PabloView.m
//  LifeOfPablo
//
//  Created by Aaron Wojnowski on 2016-02-13.
//  Copyright © 2016 Aaron Wojnowski. All rights reserved.
//

#import "PabloView.h"

#import "PabloRenderController.h"

@interface PabloView ()

@property (nonatomic, readonly, strong) UIImageView *imageView;
@property (nonatomic, assign, getter=isImageInvalidated) BOOL imageInvalidated;

@end

@implementation PabloView

@synthesize imageView=_imageView;
-(UIImageView *)imageView {
    
    if (!_imageView) {
        
        _imageView = [[UIImageView alloc] init];
        [_imageView setContentMode:UIViewContentModeScaleAspectFill];
        [self addSubview:_imageView];
        
    }
    return _imageView;
    
}

-(instancetype)init {
    
    return [self initWithFrame:CGRectZero];
    
}

-(instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        _imageInvalidated = YES;
        
        UITapGestureRecognizer * const imageTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageTapGestureRecognizerTapped:)];
        [self addGestureRecognizer:imageTapGestureRecognizer];
        
    }
    return self;
    
}

-(void)layoutSubviews {
    
    [super layoutSubviews];
    
    if ([self isImageInvalidated]) {
        
        PabloRenderController * const renderController = [[PabloRenderController alloc] init];
        [renderController setRenderVersion:[self version]];
        [renderController setBackgroundColor:[self backgroundColor]];
        [renderController setImage:[self image]];
        [renderController setImage2:[self image2]];
        [renderController setText:[self text]];
        [renderController setText2:[self text2]];
        UIImage * const image = [renderController renderImageWithSize:600];
        [[self imageView] setImage:image];
        
        [self setImageInvalidated:NO];
        
    }
    [[self imageView] setFrame:[self bounds]];
    
}

#pragma mark - Actions

-(void)imageTapGestureRecognizerTapped:(UITapGestureRecognizer *)sender {
    
    CGPoint const location = [sender locationInView:self];
    CGFloat const width = CGRectGetWidth([self bounds]);
    CGFloat const height = CGRectGetHeight([self bounds]);
    if ([self version] == PabloRenderVersionNew) {
        
        if (location.x < width * 0.55 && location.x > width * 0.25 && location.y > height * 0.33 && location.y < height * 0.5) {
            
            if ([[self delegate] respondsToSelector:@selector(pabloViewDidTapImage:)]) {
                
                [[self delegate] pabloViewDidTapImage:self];
                
            }
            
        } else if (location.x < width * 0.75 && location.x > width * 0.45 && location.y > height * 0.6 && location.y < height * 0.9) {
            
            if ([[self delegate] respondsToSelector:@selector(pabloViewDidTapImage2:)]) {
                
                [[self delegate] pabloViewDidTapImage2:self];
                
            }
            
        } else if (location.y < height * 0.6) {
            
            if ([[self delegate] respondsToSelector:@selector(pabloViewDidTapText1:)]) {
                
                [[self delegate] pabloViewDidTapText1:self];
                
            }
            
        } else {
            
            if ([[self delegate] respondsToSelector:@selector(pabloViewDidTapText2:)]) {
                
                [[self delegate] pabloViewDidTapText2:self];
                
            }
            
        }
        
    } else if ([self version] == PabloRenderVersionOld) {
        
        if (location.x < width / 3.0 && location.y > height / 3.0 * 2.0) {
            
            if ([[self delegate] respondsToSelector:@selector(pabloViewDidTapImage:)]) {
                
                [[self delegate] pabloViewDidTapImage:self];
                
            }
            
        } else {
            
            if ([[self delegate] respondsToSelector:@selector(pabloViewDidTapText1:)]) {
                
                [[self delegate] pabloViewDidTapText1:self];
                
            }
            
        }
        
    }
    
}

#pragma mark - Getters & Setters

-(void)setVersion:(PabloRenderVersion)version {
    
    _version = version;
    [self setImageInvalidated:YES];
    [self setNeedsLayout];
    
}

-(void)setBackgroundColor:(UIColor *)backgroundColor {
    
    [super setBackgroundColor:backgroundColor];
    [self setImageInvalidated:YES];
    [self setNeedsLayout];
         
}

-(void)setImage:(UIImage *)image {
    
    _image = image;
    [self setImageInvalidated:YES];
    [self setNeedsLayout];
    
}

-(void)setImage2:(UIImage *)image2 {
    
    _image2 = image2;
    [self setImageInvalidated:YES];
    [self setNeedsLayout];
    
}

-(void)setText:(NSString *)text {
    
    _text = text;
    [self setImageInvalidated:YES];
    [self setNeedsLayout];
    
}

-(void)setText2:(NSString *)text2 {
    
    _text2 = text2;
    [self setImageInvalidated:YES];
    [self setNeedsLayout];
    
}

@end
