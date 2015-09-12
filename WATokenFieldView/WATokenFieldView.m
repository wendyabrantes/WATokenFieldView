#import "WATokenFieldView.h"

#import "WATokenView.h"
#import "WASearchTextField.h"

#import <QuartzCore/QuartzCore.h>


@interface WATokenFieldScrollView : UIScrollView

@end

@implementation WATokenFieldScrollView

- (BOOL)touchesShouldCancelInContentView:(UIView *)__unused view
{
    return true;
}

- (void)scrollRectToVisible:(CGRect)__unused rect animated:(BOOL)__unused animated
{
}

@end

@interface WATokenFieldView () <UITextFieldDelegate, UIKeyInput>

@property (nonatomic, strong) NSMutableDictionary *tokenAnimations;

@property (nonatomic, strong) NSMutableArray *tokenList;
@property (nonatomic, strong) WASearchTextField *textField;

@property (nonatomic) int currentNumberOfLines;

@property (nonatomic, strong) UIView *shadowView;

@property (nonatomic, strong) UIColor *separatorColor;
@property (nonatomic, strong) UIColor *placeholderColor;
@property (nonatomic, strong) UIColor *textColor;
@property (nonatomic, strong) UIFont *textFieldFont;
@property (nonatomic, strong) UIColor *tagHighlightColor;

@property (nonatomic) float lineHeight;
@property (nonatomic) float linePadding;
@property (nonatomic) float lineSpacing;
@property (nonatomic) int maxNumberOfLines;

@end

@implementation WATokenFieldView


-(instancetype)initWithTextColor:(UIColor*)paramTextColor
                placeholderColor:(UIColor*)paramPlaceholderColor
                  separatorColor:(UIColor*)paramSeparatorColor
               tagHighlightColor:(UIColor*)paramTagHighlightColor
                   textFieldFont:(UIFont*)paramTextFieldFont
                      lineHeight:(float)paramLineHeight
                     linePadding:(float)paramLinePadding
                     lineSpacing:(float)paramLineSpacing
                maxNumberOfLines:(int)paramMaxNumberOfLines
{
  self = [super init];
  if(self){
    
    _textColor = paramTextColor;
    _separatorColor = paramSeparatorColor;
    _placeholderColor = paramPlaceholderColor;
    _textFieldFont = paramTextFieldFont;
    _tagHighlightColor = paramTagHighlightColor;
    _maxNumberOfLines = paramMaxNumberOfLines;
    _lineHeight = paramLineHeight;
    _linePadding = paramLinePadding;
    _lineSpacing = paramLineSpacing;
    
    [self commonInit];
    
  }
  return self;
}

-(instancetype)initWithTextColor:(UIColor*)paramTextColor
                placeholderColor:(UIColor*)paramPlaceholderColor
                  separatorColor:(UIColor*)paramSeparatorColor
               tagHighlightColor:(UIColor*)paramTagHighlightColor
                   textFieldFont:(UIFont*)paramTextFieldFont
                maxNumberOfLines:(int)paramMaxNumberOfLines
{
  self = [super init];
  if(self){
    
    _textColor = paramTextColor;
    _separatorColor = paramSeparatorColor;
    _placeholderColor = paramPlaceholderColor;
    _textFieldFont = paramTextFieldFont;
    _tagHighlightColor = paramTagHighlightColor;
    _maxNumberOfLines = paramMaxNumberOfLines;
    
    [self commonInit];
    
  }
  return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self != nil)
    {
        _lineHeight = 16;
        _linePadding = 12;
        _lineSpacing = 10;
        _maxNumberOfLines = 2;
        
        _currentNumberOfLines = 1;
        [self commonInit];
    }
    return self;
}

- (void)commonInit
{
 
    //default color
    if(!_separatorColor)
    {
      _separatorColor = [UIColor grayColor];
    }
    if(!_textColor)
    {
      _textColor = [UIColor blackColor];
    }
    if(!_textFieldFont)
    {
      _textFieldFont = [UIFont systemFontOfSize:16];
    }
    if(!_tagHighlightColor)
    {
      _tagHighlightColor = [UIColor blueColor];
    }
    if(!_placeholderColor)
    {
      _placeholderColor = [UIColor lightGrayColor];
    }
  
    _shadowView = [[UIView alloc] init];
    CGFloat separatorHeight = 0.5f;
  
    _shadowView.frame = CGRectMake(0, self.frame.size.height, self.frame.size.width, separatorHeight);
    _shadowView.backgroundColor = _separatorColor;
    _shadowView.layer.zPosition = 1;
    [self addSubview:_shadowView];
    
    self.clipsToBounds = false;
    self.backgroundColor = [UIColor whiteColor];
  
    _scrollView = [[WATokenFieldScrollView alloc] initWithFrame:self.bounds];
    _scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _scrollView.delaysContentTouches = true;
    _scrollView.canCancelContentTouches = true;
    _scrollView.scrollsToTop = false;
    _scrollView.backgroundColor = [UIColor whiteColor];
    _scrollView.opaque = true;
    [self addSubview:_scrollView];
    
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapRecognized:)];
    tapRecognizer.cancelsTouchesInView = false;
    [_scrollView addGestureRecognizer:tapRecognizer];
    
    _textField = [[WASearchTextField alloc] initWithFrame:CGRectMake(0, 0, 10, 42)];
    _textField.text = @"";
    _textField.delegate = self;
    _textField.autocorrectionType = UITextAutocorrectionTypeNo;
    _textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    _textField.backgroundColor = [UIColor whiteColor];
    _textField.font = _textFieldFont;
    _textField.textColor = _textColor;
    _textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [_scrollView addSubview:_textField];
    
    _textField.customPlaceholderLabel.text = _placeholder;
    _textField.customPlaceholderLabel.font = _textFieldFont;
    _textField.customPlaceholderLabel.textColor = _placeholderColor;
    [_textField.customPlaceholderLabel sizeToFit];
    _textField.customPlaceholderLabel.frame = CGRectOffset(_textField.customPlaceholderLabel.frame, 9+6, _linePadding+4);
  
    [_scrollView addSubview:_textField.customPlaceholderLabel];
    
    _tokenList = [[NSMutableArray alloc] init];
}

- (void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = placeholder;
    _textField.customPlaceholderLabel.text = _placeholder;
    [_textField.customPlaceholderLabel sizeToFit];
}

- (void)addToken:(NSString *)title tokenId:(id)tokenId animated:(bool)animated
{
    WATokenView *tokenView = [[WATokenView alloc] initWithFrame:CGRectMake(0, 0, 20, 28)
                                                      labelFont:_textFieldFont
                                                      textColor:_textColor
                                               highlightedColor:_tagHighlightColor];

    tokenView.label = title;
    tokenView.tokenId = tokenId;
    [_tokenList addObject:tokenView];
    [_scrollView addSubview:tokenView];
    
    if (animated)
    {
        if (_tokenAnimations == nil)
            _tokenAnimations = [[NSMutableDictionary alloc] init];
        
        if (tokenId != nil)
            [_tokenAnimations setObject:[[NSNumber alloc] initWithInt:1] forKey:tokenId];
    }
    
    [_textField setShowPlaceholder:false animated:_textField.text.length == 0];
    [self updateCounter];
    
    [self setNeedsLayout];
}

- (void)updateCounter
{
}

- (NSArray *)tokenIds
{
    NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:_tokenList.count];
    
    for (WATokenView *tokenView in _tokenList)
    {
        if (tokenView.tokenId != nil)
            [array addObject:tokenView.tokenId];
    }
    
    return array;
}

- (void)removeTokensAtIndexes:(NSIndexSet *)indexSet
{
    NSUInteger lastCount = _tokenList.count;
    
    [indexSet enumerateIndexesUsingBlock:^(NSUInteger index, __unused BOOL *stop)
    {
        WATokenView *tokenView = [_tokenList objectAtIndex:index];
        if ([tokenView isFirstResponder])
            [tokenView resignFirstResponder];
        
        [UIView animateWithDuration:0.2 animations:^
        {
            tokenView.transform = CGAffineTransformMakeScale(0.1f, 0.1f);
            tokenView.alpha = 0.0f;
        } completion:^(__unused BOOL finished)
        {
            [tokenView removeFromSuperview];
        }];
    }];
    
    [_tokenList removeObjectsAtIndexes:indexSet];
    
    if (_tokenAnimations == nil)
        _tokenAnimations = [[NSMutableDictionary alloc] init];
    
    [self setNeedsLayout];
    
    if (_tokenList.count == 0)
        [_textField setShowPlaceholder:true animated:lastCount != _tokenList.count];
    [self updateCounter];
}

- (float)preferredHeight
{
    int visibleNumberOfLines = MIN(MAX(1, _currentNumberOfLines), _maxNumberOfLines);
    return _lineHeight * visibleNumberOfLines + MAX(0, visibleNumberOfLines - 1) * _lineSpacing + _linePadding * 2;
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    
    CGFloat separatorHeight = 0.5f;
    _shadowView.frame = CGRectMake(0.0f, frame.size.height, frame.size.width, separatorHeight);
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self doLayout:_tokenAnimations != nil];
    
    if (_tokenAnimations != nil)
    {
        for (WATokenView *tokenView in _tokenList)
        {
            if (tokenView.tokenId == nil)
                continue;
            
            NSNumber *nAnimation = [_tokenAnimations objectForKey:tokenView.tokenId];
            if (nAnimation != nil)
            {
                tokenView.transform = CGAffineTransformMakeScale(0.1f, 0.1f);
                tokenView.alpha = 0.0f;
            }
        }
        
        [UIView animateWithDuration:0.2 animations:^
        {
            for (WATokenView *tokenView in _tokenList)
            {
                if (tokenView.tokenId == nil)
                    continue;
                
                NSNumber *nAnimation = [_tokenAnimations objectForKey:tokenView.tokenId];
                if (nAnimation != nil)
                {
                    tokenView.transform = CGAffineTransformIdentity;
                    tokenView.alpha = 1.0f;
                }
            }
        }];
        
        _tokenAnimations = nil;
    }
}

- (void)doLayout:(bool)animated
{
    float width = (float)self.frame.size.width;
    
    const float textFieldMinWidth = 60;
    const float padding = 9;
    const float textFieldPadding = 5;
    const float spacing = 1;
    
    int currentLine = 0;
    float currentX = padding;
    float currentY = _linePadding;
    
    float additionalPadding = 0;
    
    CGRect targetFrames[_tokenList.count];
    memset(targetFrames, 0, sizeof(CGRect) * _tokenList.count);
    
    int index = -1;
    for (WATokenView *tokenView in _tokenList)
    {
        index++;
        
        float tokenWidth = [tokenView preferredWidth];
        
        if (width - padding - currentX - additionalPadding < MAX(tokenWidth, textFieldMinWidth) && currentX > padding + FLT_EPSILON)
        {
            currentLine++;
            currentY += _lineHeight + _lineSpacing;
            currentX = padding;
        }
        
        CGRect tokenFrame = CGRectMake(currentX, currentY - 1, MIN(tokenWidth, width - padding - currentX - additionalPadding), tokenView.frame.size.height);
        
        if (animated && tokenView.frame.origin.x > FLT_EPSILON)
            targetFrames[index] = tokenFrame;
        else
            tokenView.frame = tokenFrame;
        currentX += tokenFrame.size.width + spacing;
    }
    
    bool lastLineContainsTextFieldOnly = false;
    
    if (width - padding - currentX - additionalPadding < textFieldMinWidth)
    {
        currentLine++;
        currentY += _lineHeight + _lineSpacing;
        currentX = padding;
        
        lastLineContainsTextFieldOnly = true;
    }
    
    if (currentLine + 1 != _currentNumberOfLines)
        animated = true;
    
    CGRect textFieldFrame = CGRectMake(currentX + textFieldPadding, currentY + 4 - 12, width - padding - currentX - textFieldPadding * 2 - additionalPadding + 4, _textField.frame.size.height);
    _textField.frame = textFieldFrame;
    if (animated)
    {
        _textField.alpha = 0.0f;
        
        [UIView animateWithDuration:0.2 animations:^
        {
            _textField.alpha = 1.0f;
        }];
    }
    
    if (lastLineContainsTextFieldOnly && ![self hasFirstResponder])
    {
        currentLine--;
        currentY -= _lineHeight + _lineSpacing;
    }
    
    if (animated)
    {
        [UIView beginAnimations:@"tokenField" context:nil];
        [UIView setAnimationDuration:0.15];
        
        int index = -1;
        for (WATokenView *tokenView in _tokenList)
        {
            index++;
            
            if (targetFrames[index].origin.x > FLT_EPSILON)
                tokenView.frame = targetFrames[index];
        }
    }
    
    currentY += _lineHeight + _linePadding;
    
    _scrollView.contentSize = CGSizeMake(_scrollView.frame.size.width, currentY);
    
    if (animated)
    {
        [UIView commitAnimations];
    }
    
    if (MIN(currentLine + 1, _maxNumberOfLines) != MIN(_currentNumberOfLines, _maxNumberOfLines))
    {
        id <WATokenFieldViewDelegate> delegate = _delegate;
        
        [delegate tokenFieldView:self didChangeHeight:_lineHeight * MIN(currentLine + 1, _maxNumberOfLines) + MAX(0, currentLine) * _lineSpacing + _linePadding * 2];
    }
    else if (currentLine + 1 > _currentNumberOfLines)
    {
        [self scrollToTextField:true];
    }
    
    _currentNumberOfLines = currentLine + 1;
}

- (bool)hasFirstResponder
{
    return _textField.isFirstResponder;
}

- (UIView *)findFirstResponder:(UIView *)view
{
    if ([view isFirstResponder])
        return view;
    
    for (UIView *subview in view.subviews)
    {
        UIView *result = [self findFirstResponder:subview];
        if (result != nil)
            return result;
    }
    
    return nil;
}

#pragma mark -

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == _textField)
    {

        bool wasEmpty = textField.text.length == 0;
        textField.text = @"";
        
        if (_delegate != nil)
        {
            id <WATokenFieldViewDelegate> delegate = _delegate;
            
            [delegate tokenFieldView:self didChangeText:textField.text];
            if (wasEmpty != textField.text.length == 0)
                [delegate tokenFieldView:self didChangeSearchStatus:[self searchIsActive] byClearingTextField:true];
        }
        
        [self scrollToTextField:false];
        
        _textField.hidden = true;
        dispatch_async(dispatch_get_main_queue(), ^
        {
            _textField.hidden = false;
        });
    }
    
    return false;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField == _textField)
    {
        bool wasEmpty = textField.text.length == 0;
        textField.text = [textField.text stringByReplacingCharactersInRange:range withString:string];
        
        [self scrollToTextField:true];
        
        id <WATokenFieldViewDelegate> delegate = _delegate;
        
        if (delegate != nil)
        {
            [delegate tokenFieldView:self didChangeText:textField.text];
            if (wasEmpty != textField.text.length == 0)
                [delegate tokenFieldView:self didChangeSearchStatus:[self searchIsActive] byClearingTextField:true];
        }
    }
    
    return false;
}

- (void)textFieldDidHitLastBackspace
{
    if (_tokenList.count != 0)
    {
        [[_tokenList lastObject] becomeFirstResponder];
    }
}

- (void)textFieldDidBecomeFirstResponder
{
    [self setNeedsLayout];
}

- (void)textFieldDidResignFirstResponder
{
    if (_tokenAnimations == nil)
        _tokenAnimations = [[NSMutableDictionary alloc] init];
    
    [self setNeedsLayout];
}

- (void)scrollToTextField:(bool)animated
{
    CGPoint contentOffset = _scrollView.contentOffset;
    CGSize contentSize = _scrollView.contentSize;
    CGSize frameSize = _scrollView.frame.size;
    if (contentOffset.y < contentSize.height - frameSize.height)
        contentOffset = CGPointMake(0, contentSize.height - frameSize.height);
    if (contentOffset.y < 0)
        contentOffset.y = 0;
    
    if (!animated)
        [_scrollView setContentOffset:contentOffset animated:animated];
    else
    {
        [UIView animateWithDuration:0.2 animations:^
        {
            [_scrollView setContentOffset:contentOffset animated:false];
        }];
    }
}

- (bool)searchIsActive
{
    return /*_textField.isFirstResponder && */_textField.text.length != 0;
}

- (void)clearText
{
    _textField.text = @"";
    
    id <WATokenFieldViewDelegate> delegate = _delegate;
    
    if (delegate != nil)
        [delegate tokenFieldView:self didChangeSearchStatus:[self searchIsActive] byClearingTextField:false];
}

- (void)highlightToken:(WATokenView *)tokenView
{
    for (WATokenView *view in _tokenList)
    {
        if (view != tokenView)
        {
            if (view.selected)
                view.selected = false;
        }
    }
    
    tokenView.selected = true;
    
    [self setNeedsLayout];
}

- (void)unhighlightToken:(WATokenView *)tokenView
{
    tokenView.selected = false;
    
    if (_tokenAnimations == nil)
        _tokenAnimations = [[NSMutableDictionary alloc] init];
    
    [self setNeedsLayout];
}

- (void)deleteToken:(WATokenView *)tokenView
{
    int index = -1;
    for (WATokenView *view in _tokenList)
    {
        index++;
        
        if (view == tokenView)
        {
            [_tokenList removeObjectAtIndex:index];
            break;
        }
    }
    
    [tokenView removeFromSuperview];
    [_textField becomeFirstResponder];
    
    [self setNeedsLayout];
    
    id <WATokenFieldViewDelegate> delegate = _delegate;
    
    if (delegate != nil)
        [delegate tokenFieldView:self didDeleteTokenWithId:tokenView.tokenId];
    
    if (_tokenList.count == 0)
        [_textField setShowPlaceholder:true animated:false];
    [self updateCounter];
}

- (void)beginTransition:(NSTimeInterval)duration
{
    UIImage *inputFieldImage = nil;
    UIImageView *temporaryImageView = nil;
    
    UIGraphicsBeginImageContextWithOptions(_scrollView.bounds.size, true, 0.0f);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    inputFieldImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    temporaryImageView = [[UIImageView alloc] initWithImage:inputFieldImage];
    temporaryImageView.frame = _scrollView.bounds;
    
    UIView *temporaryImageViewContainer = [[UIView alloc] initWithFrame:_scrollView.frame];
    temporaryImageViewContainer.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    temporaryImageViewContainer.clipsToBounds = true;
    [temporaryImageViewContainer addSubview:temporaryImageView];
    
    [self insertSubview:temporaryImageViewContainer aboveSubview:_scrollView];
    _scrollView.alpha = 0.0f;
    
    [UIView animateWithDuration:duration animations:^
    {
        temporaryImageView.alpha = 0.0f;
        _scrollView.alpha = 1.0f;
    } completion:^(__unused BOOL finished)
    {
        [temporaryImageView removeFromSuperview];
        [temporaryImageViewContainer removeFromSuperview];
    }];
}

- (void)tapRecognized:(UITapGestureRecognizer *)recognizer
{
    if (recognizer.state == UIGestureRecognizerStateRecognized)
    {
        [_textField becomeFirstResponder];
    }
}

- (BOOL)hasText
{
    return false;
}

- (void)insertText:(NSString *)__unused text
{
}

- (void)deleteBackward
{
}

@end
