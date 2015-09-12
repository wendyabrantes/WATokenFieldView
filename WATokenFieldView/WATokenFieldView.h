//
//  WATokenFieldView.h
//  WATokenFieldView
//
//  Created by Wendy Abrantes on 12/09/2015.
//  Copyright (c) 2015 ABRANTES DIGITAL LTD. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WATokenFieldView;

@protocol WATokenFieldViewDelegate <NSObject>

- (void)tokenFieldView:(WATokenFieldView *)tokenFieldView didChangeHeight:(float)height;
- (void)tokenFieldView:(WATokenFieldView *)tokenFieldView didChangeText:(NSString *)text;
- (void)tokenFieldView:(WATokenFieldView *)tokenFieldView didChangeSearchStatus:(bool)searchIsActive byClearingTextField:(bool)byClearingTextField;
- (void)tokenFieldView:(WATokenFieldView *)tokenFieldView didDeleteTokenWithId:(id)tokenId;

@end

@interface WATokenFieldView : UIView

@property (nonatomic, weak) id<WATokenFieldViewDelegate> delegate;

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NSString *placeholder;

- (float)preferredHeight;
- (void)scrollToTextField:(bool)animated;

- (bool)searchIsActive;
- (void)clearText;
- (bool)hasFirstResponder;

- (void)beginTransition:(NSTimeInterval)duration;

- (void)addToken:(NSString *)title tokenId:(id)tokenId animated:(bool)animated;
- (NSArray *)tokenIds;
- (void)removeTokensAtIndexes:(NSIndexSet *)indexSet;

-(instancetype)initWithTextColor:(UIColor*)paramTextColor
                placeholderColor:(UIColor*)paramPlaceholderColor
                  separatorColor:(UIColor*)paramSeparatorColor
               tagHighlightColor:(UIColor*)paramTagHighlightColor
                   textFieldFont:(UIFont*)paramTextFieldFont
                maxNumberOfLines:(int)paramMaxNumberOfLines;

-(instancetype)initWithTextColor:(UIColor*)paramTextColor
                placeholderColor:(UIColor*)paramPlaceholderColor
                  separatorColor:(UIColor*)paramSeparatorColor
               tagHighlightColor:(UIColor*)paramTagHighlightColor
                   textFieldFont:(UIFont*)paramTextFieldFont
                      lineHeight:(float)paramLineHeight
                     linePadding:(float)paramLinePadding
                     lineSpacing:(float)paramLineSpacing
                maxNumberOfLines:(int)paramMaxNumberOfLines;

@end
