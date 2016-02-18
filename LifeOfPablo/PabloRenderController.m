//
//  PabloRenderController.m
//  LifeOfPablo
//
//  Created by Aaron Wojnowski on 2016-02-13.
//  Copyright © 2016 Aaron Wojnowski. All rights reserved.
//

#import "PabloRenderController.h"

@interface PabloRenderController ()

@property (nonatomic, strong) NSMutableDictionary <NSString *, UIFont *> *fontCache;

@end

@implementation PabloRenderController

-(instancetype)init {
    
    self = [super init];
    if (self) {
        
        _fontCache = [NSMutableDictionary dictionary];
        
    }
    return self;
    
}

-(UIImage *)renderImageWithSize:(CGFloat)size {
    
    if ([self renderVersion] == PabloRenderVersionNew) {
        
        return [self renderNewImageWithSize:size];
        
    } else if ([self renderVersion] == PabloRenderVersionOld) {
        
        return [self renderOldImageWithSize:size];
        
    }
    return nil;
    
}

-(UIImage *)renderNewImageWithSize:(CGFloat)size {
    
    // setup drawing
    
    CGRect const bounds = CGRectMake(0, 0, size, size);
    CGFloat const multiplier = size / 600.0;
    UIGraphicsBeginImageContextWithOptions(bounds.size, YES, [[UIScreen mainScreen] scale]);
    
    // setup constants
    
    NSString * const text = [self text];
    
    BOOL lastCharacterSpace = NO;
    NSInteger lastWordStartingIndex = 0;
    for (NSInteger i = 0; i < [text length]; i++) {
        
        unichar const c = [text characterAtIndex:i];
        if (c == ' ') {
            
            lastCharacterSpace = YES;
            
        } else {
            
            if (lastCharacterSpace) {
                
                lastWordStartingIndex = i;
                
            }
            lastCharacterSpace = NO;
            
        }
        
    }
    
    NSMutableString * const text1 = [[NSMutableString alloc] init];
    [text1 appendString:[text substringToIndex:lastWordStartingIndex]];
    for (NSInteger i = 0; i < 5; i++) {
        
        [text1 appendString:@" "];
        
    }
    [text1 appendString:[text substringFromIndex:lastWordStartingIndex]];
    
    NSMutableString * const text2 = [[NSMutableString alloc] init];
    [text2 appendString:[text substringToIndex:lastWordStartingIndex]];
    for (NSInteger i = 0; i < 2; i++) {
        
        [text2 appendString:@" "];
        
    }
    [text2 appendString:[text substringFromIndex:lastWordStartingIndex]];
    
    NSMutableString * const text3 = [[NSMutableString alloc] init];
    [text3 appendString:[text substringToIndex:lastWordStartingIndex]];
    for (NSInteger i = 0; i < 4; i++) {
        
        [text3 appendString:@" "];
        
    }
    [text3 appendString:[text substringFromIndex:lastWordStartingIndex]];
    
    CGPoint const group1Point = CGPointMake(89 * multiplier, 30 * multiplier);
    CGPoint const group2Point = CGPointMake(89 * multiplier, 76 * multiplier);
    CGPoint const group3Point = CGPointMake(89 * multiplier, 353 * multiplier);
    CGPoint const group4Point = CGPointMake(74 * multiplier, 387 * multiplier);
    CGPoint const group5Point = CGPointMake(401 * multiplier, 389 * multiplier);
    CGSize const group1Size = CGSizeMake(454 * multiplier, 45 * multiplier);
    CGSize const group2Size = CGSizeMake(413 * multiplier, 215 * multiplier);
    CGSize const group3Size = CGSizeMake(434 * multiplier, 45 * multiplier);
    CGSize const group45Size = CGSizeMake(102 * multiplier, 184 * multiplier);
    
    CGPoint const imagePoint = CGPointMake(123 * multiplier, 182 * multiplier);
    CGSize const imageSize = CGSizeMake(239 * multiplier, 166 * multiplier);
    CGPoint const image2Point = CGPointMake(265 * multiplier, 419 * multiplier);
    CGSize const image2Size = CGSizeMake(165 * multiplier, 141 * multiplier);
    
    // prepare to draw
    
    CGContextRef const context = UIGraphicsGetCurrentContext();
    [[self fontCache] removeAllObjects];
    
    // draw
    
    [[self backgroundColor] setFill];
    CGContextFillRect(context, bounds);
    
    [self drawTextBlockWithText:text1 atPoint:group1Point withSize:group1Size inBounds:bounds count:1];
    [self drawTextBlockWithText:text2 atPoint:group2Point withSize:group2Size inBounds:bounds count:5];
    [self drawTextBlockWithText:text3 atPoint:group3Point withSize:group3Size inBounds:bounds count:1];
    [self drawTextBlockWithText:[self text2] atPoint:group4Point withSize:group45Size inBounds:bounds count:10];
    [self drawTextBlockWithText:[self text2] atPoint:group5Point withSize:group45Size inBounds:bounds count:10];
    
    [[self image] drawInRect:CGRectMake(imagePoint.x, imagePoint.y, imageSize.width, imageSize.height)];
    [[self image2] drawInRect:CGRectMake(image2Point.x, image2Point.y, image2Size.width, image2Size.height)];
    
    // end drawing
    
    UIImage * const image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
    
}

-(UIImage *)renderOldImageWithSize:(CGFloat)size {
    
    // setup drawing
    
    CGRect const bounds = CGRectMake(0, 0, size, size);
    CGFloat const multiplier = size / 600.0;
    UIGraphicsBeginImageContextWithOptions(bounds.size, YES, [[UIScreen mainScreen] scale]);
    
    // setup constants
    
    NSString * const text = [self text];
    NSMutableString * const finalizedText = [[NSMutableString alloc] init];
    for (NSInteger i = 0; i < [text length]; i++) {
        
        NSString * const cs = [text substringWithRange:NSMakeRange(i, 1)];
        [finalizedText appendFormat:@"%@",cs];
        
        unichar const c = [text characterAtIndex:i];
        if (c == ' ') {
            [finalizedText appendFormat:@"%@",cs];
        }
        
    }
    
    CGPoint const group1Point = CGPointMake(53 * multiplier, 41 * multiplier);
    CGPoint const group2Point = CGPointMake(55 * multiplier, 158 * multiplier);
    CGPoint const group3Point = CGPointMake(42 * multiplier, 301 * multiplier);
    CGPoint const group4Point = CGPointMake(220 * multiplier, 99 * multiplier);
    CGPoint const group5Point = CGPointMake(221 * multiplier, 231 * multiplier);
    CGPoint const group6Point = CGPointMake(227 * multiplier, 382 * multiplier);
    CGPoint const group7Point = CGPointMake(380 * multiplier, 89 * multiplier);
    CGPoint const group8Point = CGPointMake(381 * multiplier, 239 * multiplier);
    CGPoint const group9Point = CGPointMake(365 * multiplier, 372 * multiplier);
    CGSize const groupSize = CGSizeMake(170 * multiplier, 147 * multiplier);
    
    CGPoint const imagePoint = CGPointMake(79 * multiplier, 451 * multiplier);
    CGSize const imageSize = CGSizeMake(139 * multiplier, 98 * multiplier);
    
    // prepare to draw
    
    CGContextRef const context = UIGraphicsGetCurrentContext();
    [[self fontCache] removeAllObjects];
    
    // draw
    
    [[self backgroundColor] setFill];
    CGContextFillRect(context, bounds);
    
    [self drawTextBlockWithText:finalizedText atPoint:group1Point withSize:groupSize inBounds:bounds count:8];
    [self drawTextBlockWithText:finalizedText atPoint:group2Point withSize:groupSize inBounds:bounds count:8];
    [self drawTextBlockWithText:finalizedText atPoint:group3Point withSize:groupSize inBounds:bounds count:8];
    [self drawTextBlockWithText:finalizedText atPoint:group4Point withSize:groupSize inBounds:bounds count:8];
    [self drawTextBlockWithText:finalizedText atPoint:group5Point withSize:groupSize inBounds:bounds count:8];
    [self drawTextBlockWithText:finalizedText atPoint:group6Point withSize:groupSize inBounds:bounds count:8];
    [self drawTextBlockWithText:finalizedText atPoint:group7Point withSize:groupSize inBounds:bounds count:8];
    [self drawTextBlockWithText:finalizedText atPoint:group8Point withSize:groupSize inBounds:bounds count:8];
    [self drawTextBlockWithText:finalizedText atPoint:group9Point withSize:groupSize inBounds:bounds count:8];
    
    [[self image] drawInRect:CGRectMake(imagePoint.x, imagePoint.y, imageSize.width, imageSize.height)];
    
    // end drawing
    
    UIImage * const image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
    
}

-(void)drawTextBlockWithText:(NSString *)text atPoint:(CGPoint)point withSize:(CGSize)size inBounds:(CGRect)bounds count:(NSInteger)count {
    
    CGFloat const lineHeight = size.height / count;
    for (NSInteger i = 0; i < count; i++) {
        
        NSString * const key = [NSString stringWithFormat:@"%f%f%@",lineHeight,size.width,text];
        if (![self fontCache][key]) {
            
            UIFont * const textBlockFont = [self getFontForText:text seedFont:[UIFont fontWithName:@"Arial-BoldMT" size:100.0] fittingSize:CGSizeMake(size.width, lineHeight)];
            [self fontCache][key] = textBlockFont;
            
        }
        
        NSDictionary * const textAttributes = @{
                                                NSFontAttributeName : [self fontCache][key],
                                                NSForegroundColorAttributeName : [UIColor blackColor]
                                                };
        [text drawInRect:CGRectMake(point.x, point.y + i * lineHeight, size.width, lineHeight) withAttributes:textAttributes];
        
    }
    
}

#pragma mark - Font Helper

-(UIFont *)getFontForText:(NSString *)text seedFont:(UIFont *)seedFont fittingSize:(CGSize)desiredSize {
    
    if ([text length] == 0) {
        
        return seedFont;
        
    }
    
    CGFloat sizeBottom = 0.0;
    CGFloat sizeTop = 100.0;
    
    while (true) {
        
        CGFloat const testSize = sizeBottom + (sizeTop - sizeBottom) / 2.0;
        
        UIFont * const font = [seedFont fontWithSize:testSize];
        CGSize const size = [text sizeWithAttributes:@{ NSFontAttributeName : font }];
                
        CGFloat const widthDifference = desiredSize.width - size.width;
        CGFloat const heightDifference = desiredSize.height - size.height;
        if ((widthDifference > 0 && widthDifference < 2 && heightDifference > 0) ||
            (heightDifference > 0 && heightDifference < 2 && widthDifference > 0) ||
            ABS(sizeBottom - sizeTop) < 0.01) {
            
            return font;
            
        }
        
        if (widthDifference < 0 || heightDifference < 0) {
            
            // too big
            sizeTop = testSize;
            
        } else if (widthDifference > 0 || heightDifference > 0) {
            
            // too small
            sizeBottom = testSize;
                        
        }
        
    }
    
}

@end
