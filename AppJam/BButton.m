//
//  BButton.m
//  BButton Demo
//
//  Created by Mathieu Bolard on 31/07/12.
//  Copyright (c) 2012 Mathieu Bolard. All rights reserved.
//
//  Modified by Nealon Young for flat appearance
//

#import "BButton.h"

@interface BButton ()

- (UIColor *)lightenColor:(UIColor *)oldColor value:(float)value;
- (UIColor *)darkenColor:(UIColor *)oldColor value:(float)value;
- (BOOL)isLightColor:(UIColor *)color;

@end

@implementation BButton

- (id) init {
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)dealloc {
    if (_gradient != NULL) {
        CGGradientRelease(_gradient);
    }
}

- (id) initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        [self setup];
    }
    
    return self;
}

- (id) initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        [self setup];
    }
    
    return self;
}

- (void) setup {
    // Initialization code
    self.backgroundColor = [UIColor clearColor];
    self.color = [UIColor colorWithRed:0.00f green:0.33f blue:0.80f alpha:1.00f];
}

- (void) setHighlighted:(BOOL)highlighted {
    [super setHighlighted:highlighted];
    [self setNeedsDisplay];
}

- (void) setColor:(UIColor *)color {
    _color = color;
    
    if ([self isLightColor:color]) {
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self setTitleShadowColor:[[UIColor whiteColor] colorWithAlphaComponent:0.6] forState:UIControlStateNormal];
    } else {
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self setTitleShadowColor:[[UIColor blackColor] colorWithAlphaComponent:0.6] forState:UIControlStateNormal];
    }
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    UIColor* topColor = [self lightenColor:_color value:0.12];
    
    NSArray* newGradientColors = [NSArray arrayWithObjects:
                                  (id)topColor.CGColor,
                                  (id)_color.CGColor, nil];
    CGFloat newGradientLocations[] = {0.0, 1.0};
    
    CGGradientRelease(_gradient);
    _gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef)newGradientColors, newGradientLocations);
    CGColorSpaceRelease(colorSpace);
    
    [self setNeedsDisplay];
}

- (UIColor *) color {
    return _color;
}

- (void)setType:(BButtonType)type {
    UIColor *color;
    switch (type) {
        case BButtonTypeDefault:
            color = [UIColor colorWithRed:0.85f green:0.85f blue:0.85f alpha:1.00f];
            break;
        case BButtonTypePrimary:
            color = [UIColor colorWithRed:0.00f green:0.33f blue:0.80f alpha:1.00f];
            break;
        case BButtonTypeInfo:
            color = [UIColor colorWithRed:0.18f green:0.59f blue:0.71f alpha:1.00f];
            break;
        case BButtonTypeSuccess:
            color = [UIColor colorWithRed:0.32f green:0.64f blue:0.32f alpha:1.00f];
            break;
        case BButtonTypeWarning:
            color = [UIColor colorWithRed:0.97f green:0.58f blue:0.02f alpha:1.00f];
            break;
        case BButtonTypeDanger:
            color = [UIColor colorWithRed:0.74f green:0.21f blue:0.18f alpha:1.00f];
            break;
        case BButtonTypeInverse:
            color = [UIColor colorWithRed:0.13f green:0.13f blue:0.13f alpha:1.00f];
            break;
        default:
            color = [UIColor colorWithRed:0.00f green:0.33f blue:0.80f alpha:1.00f];
    }
    [self setColor:color];
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //UIColor* border = [self darkenColor:_color value:0.06];
    
    //// Shadow Declarations
    //UIColor* shadow = [self lightenColor:border value:0.50];
    //CGSize shadowOffset = CGSizeMake(0, 1);
    //CGFloat shadowBlurRadius = 2;
    
    //// Rounded Rectangle Drawing
    UIBezierPath* roundedRectanglePath = [UIBezierPath bezierPathWithRoundedRect: CGRectMake(0.5, 0.5, rect.size.width-1.0, rect.size.height-1.0) cornerRadius: 6];
    CGContextSaveGState(context);
    [roundedRectanglePath addClip];
    
    CGFloat red, green, blue, alpha;
    [_color getRed:&red green:&green blue:&blue alpha:&alpha];
    
    float fillColor[] = {red, green, blue, alpha};
    CGContextSetFillColor(context, fillColor);
    CGContextFillRect(context, rect);
    //CGContextDrawLinearGradient(context, _gradient, CGPointMake(0.0, self.highlighted ? rect.size.height-0.5 : 0.5), CGPointMake(0.0, self.highlighted ? 0.5 : rect.size.height-0.5), 0);
    CGContextRestoreGState(context);
}

- (UIColor *)lightenColor:(UIColor *)oldColor value:(float)value {
    int   totalComponents = CGColorGetNumberOfComponents(oldColor.CGColor);
    bool  isGreyscale     = totalComponents == 2 ? YES : NO;
    
    CGFloat* oldComponents = (CGFloat *)CGColorGetComponents(oldColor.CGColor);
    CGFloat newComponents[4];
    
    if (isGreyscale) {
        newComponents[0] = oldComponents[0]+value > 1.0 ? 1.0 : oldComponents[0]+value;
        newComponents[1] = oldComponents[0]+value > 1.0 ? 1.0 : oldComponents[0]+value;
        newComponents[2] = oldComponents[0]+value > 1.0 ? 1.0 : oldComponents[0]+value;
        newComponents[3] = oldComponents[1];
    } else {
        newComponents[0] = oldComponents[0]+value > 1.0 ? 1.0 : oldComponents[0]+value;
        newComponents[1] = oldComponents[1]+value > 1.0 ? 1.0 : oldComponents[1]+value;
        newComponents[2] = oldComponents[2]+value > 1.0 ? 1.0 : oldComponents[2]+value;
        newComponents[3] = oldComponents[3];
    }
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
	CGColorRef newColor = CGColorCreate(colorSpace, newComponents);
	CGColorSpaceRelease(colorSpace);
    
	UIColor *retColor = [UIColor colorWithCGColor:newColor];
	CGColorRelease(newColor);
    
    return retColor;
}

- (UIColor *)darkenColor:(UIColor *)oldColor value:(float)value {
    int totalComponents = CGColorGetNumberOfComponents(oldColor.CGColor);
    bool isGreyscale = totalComponents == 2 ? YES : NO;
    
    CGFloat* oldComponents = (CGFloat *)CGColorGetComponents(oldColor.CGColor);
    CGFloat newComponents[4];
    
    if (isGreyscale) {
        newComponents[0] = oldComponents[0] - value < 0.0 ? 0.0 : oldComponents[0]-value;
        newComponents[1] = oldComponents[0] - value < 0.0 ? 0.0 : oldComponents[0]-value;
        newComponents[2] = oldComponents[0] - value < 0.0 ? 0.0 : oldComponents[0]-value;
        newComponents[3] = oldComponents[1];
    } else {
        newComponents[0] = oldComponents[0]-value < 0.0 ? 0.0 : oldComponents[0]-value;
        newComponents[1] = oldComponents[1]-value < 0.0 ? 0.0 : oldComponents[1]-value;
        newComponents[2] = oldComponents[2]-value < 0.0 ? 0.0 : oldComponents[2]-value;
        newComponents[3] = oldComponents[3];
    }
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
	CGColorRef newColor = CGColorCreate(colorSpace, newComponents);
	CGColorSpaceRelease(colorSpace);
    
	UIColor *retColor = [UIColor colorWithCGColor:newColor];
	CGColorRelease(newColor);
    
    return retColor;
}

- (BOOL) isLightColor:(UIColor *)color {
    int   totalComponents = CGColorGetNumberOfComponents(color.CGColor);
    bool  isGreyscale     = totalComponents == 2 ? YES : NO;
    
    CGFloat* components = (CGFloat *)CGColorGetComponents(color.CGColor);
    CGFloat sum;
    
    if (isGreyscale) {
        sum = components[0];
    } else {
        sum = (components[0]+components[1]+components[2])/3.0;
    }
    
    return (sum > 0.8);
}

@end
