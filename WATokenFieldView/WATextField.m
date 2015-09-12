#import "WATextField.h"

@implementation WATextField

- (void)drawPlaceholderInRect:(CGRect)rect
{
  if (_placeholderColor == nil || _placeholderFont == nil)
    [super drawPlaceholderInRect:rect];
  else
  {
    CGContextSetFillColorWithColor(UIGraphicsGetCurrentContext(), _placeholderColor.CGColor);
    
    CGSize placeholderSize = [self.placeholder sizeWithAttributes:@{
                                                                    NSFontAttributeName :_placeholderFont
                                                                    }];
    
    CGPoint placeholderOrigin = CGPointMake(0.0f, floorf((rect.size.height - placeholderSize.height) / 2.0f) - 0.5f);
    if (self.textAlignment == NSTextAlignmentCenter)
      placeholderOrigin.x = floorf((rect.size.width - placeholderSize.width) / 2.0f);
    else if (self.textAlignment == NSTextAlignmentRight)
      placeholderOrigin.x = rect.size.width - placeholderSize.width;
    
    [self.placeholder drawAtPoint:placeholderOrigin
                   withAttributes:@{
                                    NSFontAttributeName :_placeholderFont
                                    }];
  }
}


- (CGRect)textRectForBounds:(CGRect)bounds
{
  CGRect rect = [super textRectForBounds:bounds];
  rect.origin.x += _leftInset;
  rect.size.width -= _leftInset;
  rect.origin.y = floorf((self.bounds.size.height - rect.size.height) / 2.0f);
  return rect;
}

- (CGRect)editingRectForBounds:(CGRect)bounds
{
  return CGRectOffset([self textRectForBounds:bounds], 0.0f, 0.5f + _editingRectOffset);
}

- (CGRect)placeholderRectForBounds:(CGRect)bounds
{
  return [self textRectForBounds:bounds];
}


@end
