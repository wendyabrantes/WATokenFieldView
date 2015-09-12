#import "WATokenView.h"
#import "WATokenFieldViewStyleKit.h"

static UIImage *tokenBackgroundImage()
{
    static UIImage *image = nil;
    if (image == nil)
    {
        UIImage *rawImage = [UIImage imageNamed:@"TokenBackground.png"];
        image = [rawImage stretchableImageWithLeftCapWidth:(int)(rawImage.size.width / 2) topCapHeight:0];
    }
    return image;
}

@implementation WATokenView
{
  UIFont *labelFont;
  UIColor *titleColor;
  UIColor *highlightedColor;
}

-(instancetype)initWithFrame:(CGRect)frame
                   labelFont:(UIFont*)paramLabelFont
                   textColor:(UIColor*)paramTextColor
            highlightedColor:(UIColor*)paramHighlightedColor
{
  self = [super initWithFrame:frame];
  if (self != nil)
  {
    labelFont = paramLabelFont;
    titleColor = paramTextColor;
    highlightedColor = paramHighlightedColor;

    [self commonInit];
  }
  return self;
}

- (void)commonInit
{

    [self setBackgroundImage:tokenBackgroundImage() forState:UIControlStateNormal];
    [self setBackgroundImage:[WATokenFieldViewStyleKit imageOfTokenBackgroundHighlighted]
                    forState:UIControlStateHighlighted];
    [self setBackgroundImage:[WATokenFieldViewStyleKit imageOfTokenBackgroundHighlighted]
                    forState:UIControlStateSelected];
    [self setBackgroundImage:[WATokenFieldViewStyleKit imageOfTokenBackgroundHighlighted]
                    forState:UIControlStateHighlighted | UIControlStateSelected];
  
    self.tintColor = highlightedColor;
  
    self.titleLabel.font = labelFont;
    [self setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 5)];
    
    [self setTitleColor:titleColor forState:UIControlStateNormal];
    [self setTitleShadowColor:nil forState:UIControlStateNormal];
  
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted | UIControlStateSelected];
  
    [self addTarget:self action:@selector(buttonPressed) forControlEvents:UIControlEventTouchDown];
}

- (void)buttonPressed
{
    [self becomeFirstResponder];
}

- (void)setLabel:(NSString *)label
{
    _label = label;
    
    [self setTitle:label forState:UIControlStateNormal];
    
    _preferredWidth = [label sizeWithFont:self.titleLabel.font].width + 10;
}

- (float)preferredWidth
{
    return MAX(_preferredWidth, 10);
}

#pragma mark -

- (BOOL)becomeFirstResponder
{
    if ([super becomeFirstResponder])
    {
        if ([self.superview.superview respondsToSelector:@selector(highlightToken:)])
            [self.superview.superview performSelector:@selector(highlightToken:) withObject:self];
        return true;
    }
    
    return false;
}

- (BOOL)resignFirstResponder
{
    if ([super resignFirstResponder])
    {
        if ([self.superview.superview respondsToSelector:@selector(unhighlightToken:)])
            [self.superview.superview performSelector:@selector(unhighlightToken:) withObject:self];
        return true;
    }
    
    return false;
}

- (void)deleteBackward
{
    if ([self.superview.superview respondsToSelector:@selector(deleteToken:)])
        [self.superview.superview performSelector:@selector(deleteToken:) withObject:self];
}

- (BOOL)hasText
{
    return false;
}

- (void)insertText:(NSString *)__unused text
{
}

- (BOOL)canBecomeFirstResponder
{
    return true;
}

@end
