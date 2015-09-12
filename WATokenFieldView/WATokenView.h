//
//  WATokenView.h
//  WATokenFieldView
//
//  Created by Wendy Abrantes on 12/09/2015.
//  Copyright (c) 2015 ABRANTES DIGITAL LTD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WATokenView : UIButton <UIKeyInput>

@property (nonatomic, strong) NSString *label;
@property (nonatomic) float preferredWidth;

@property (nonatomic, strong) id tokenId;

-(instancetype)initWithFrame:(CGRect)frame
                   labelFont:(UIFont*)paramLabelFont
                   textColor:(UIColor*)paramTextColor
            highlightedColor:(UIColor*)paramHighlightedColor;


@end
