//
//  WATextField.h
//  WATokenFieldView
//
//  Created by Wendy Abrantes on 12/09/2015.
//  Copyright (c) 2015 ABRANTES DIGITAL LTD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WATextField : UITextField

@property (nonatomic) CGFloat editingRectOffset;

@property (nonatomic, strong) UIColor *placeholderColor;
@property (nonatomic, strong) UIFont *placeholderFont;

@property (nonatomic) CGFloat leftInset;

@end
