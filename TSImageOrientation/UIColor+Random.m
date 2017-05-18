#import "UIColor+Random.h"


@implementation UIColor (Random)

+ (UIColor *)randomColor
{
    return [UIColor colorWithRed:(arc4random() % 256 / 255.0) green:(arc4random() % 256 / 255.0) blue:(arc4random() % 256 / 255.0) alpha:1.0];
}

+ (UIColor *)randomToneByColor:(UIColor *)color
{
    CGFloat hue = 0;
    CGFloat saturation = 0;
    CGFloat brightness = 0;
    CGFloat alpha = 0;
    [color getHue:&hue saturation:&saturation brightness:&brightness alpha:&alpha];
    return [UIColor colorWithHue:hue saturation:(arc4random() % 256 / 255.0) brightness:(arc4random() % 256 / 255.0) alpha:alpha];
}

+ (UIColor *)randomColorByColor:(UIColor *)color
{
    CGFloat hue = 0;
    CGFloat saturation = 0;
    CGFloat brightness = 0;
    CGFloat alpha = 0;
    [color getHue:&hue saturation:&saturation brightness:&brightness alpha:&alpha];
    return [UIColor colorWithHue:(arc4random() % 361) saturation:saturation brightness:brightness alpha:alpha];
}

@end
