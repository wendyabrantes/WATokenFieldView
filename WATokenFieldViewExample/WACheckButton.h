//
//  GICheckButton.h
//  GetIn
//
//  Created by Wendy Abrantes on 07/09/2015.
//  Copyright (c) 2015 nimbletank. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WACheckButton : UIButton

@property (nonatomic, strong) UIImageView *checkView;

- (void)setChecked:(bool)checked animated:(bool)animated;

@end
