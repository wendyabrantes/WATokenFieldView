//
//  WASearchTextField.h
//  WATokenFieldView
//
//  Created by Wendy Abrantes on 12/09/2015.
//  Copyright (c) 2015 ABRANTES DIGITAL LTD. All rights reserved.
//

#import "WATextField.h"

@interface WASearchTextField : WATextField

@property (nonatomic, strong) UILabel *customPlaceholderLabel;

- (void)setShowPlaceholder:(bool)showPlaceholder animated:(bool)animated;

@end
