//
//  InviteFriendTableViewCell.m
//  GetIn
//
//  Created by Wendy Abrantes on 07/09/2015.
//  Copyright (c) 2015 nimbletank. All rights reserved.
//

#import "WAFriendTableViewCell.h"

#import "WACheckButton.h"

@implementation WAFriendTableViewCell
{
  CALayer *dividerLayer;
  
  UILabel *firstNameLabel;
  UILabel *lastNameLabel;
  
  WACheckButton *checkButton;

  BOOL isConstraintSetup;
}

+(NSString*)reuseIdentifier
{
  return @"WAFriendTableViewCell";
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
  self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
  if (self) {
    [self setupLayout];
  }
  return self;
}

-(void)prepareForReuse
{
  [super prepareForReuse];
  
  firstNameLabel.text = nil;
  lastNameLabel.text = nil;
}

-(void)layoutSubviews
{
  [self setupConstraint];
  [super layoutSubviews];
}


-(void)setupLayout
{
  self.selectionStyle = UITableViewCellSelectionStyleNone;
  
  firstNameLabel = [UILabel new];
  lastNameLabel = [UILabel new];
  firstNameLabel.textColor = lastNameLabel.textColor = [UIColor blackColor];
  
  firstNameLabel.font = [UIFont systemFontOfSize:15];
  lastNameLabel.font = [UIFont systemFontOfSize:15];
  
  dividerLayer = [CALayer layer];
  dividerLayer.backgroundColor = [UIColor lightGrayColor].CGColor;
  
  checkButton = [[WACheckButton alloc] init];
  checkButton.userInteractionEnabled = NO;
  
  
  
  [self.contentView addSubview:firstNameLabel];
  [self.contentView addSubview:lastNameLabel];
  [self.contentView addSubview:checkButton];
  
  [self.contentView.layer addSublayer:dividerLayer];
}

-(void)setupConstraint
{
  float paddingLeft = 15.0f;
  
  firstNameLabel.frame = CGRectMake(paddingLeft,
                                    self.frame.size.height/2 - (firstNameLabel.frame.size.height+2),
                                    200,
                                    firstNameLabel.frame.size.height);

  lastNameLabel.frame = CGRectMake(paddingLeft,
                                   self.frame.size.height/2 + 2,
                                   200,
                                   lastNameLabel.frame.size.height);
  
  dividerLayer.frame = CGRectMake(0,
                                  self.frame.size.height-1,
                                  self.frame.size.width,
                                  1);
  
  checkButton.frame = CGRectMake(self.frame.size.width - 40,
                                 self.contentView.center.y - 10,
                                 20,
                                 20);
  
  [self setNeedsDisplay];
}

-(void)setHighlighted:(BOOL)highlighted
{
  
}
-(void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
  
}

-(void)setSelected:(BOOL)selected animated:(BOOL)animated
{
  [super setSelected:selected animated:animated];
  [checkButton setChecked:selected animated:YES];
}

-(void)updateWithFirstName:(NSString*)firstName
                  lastName:(NSString*)lastName
{
  firstNameLabel.text = [firstName uppercaseString];
  lastNameLabel.text = [lastName uppercaseString];
  
  [firstNameLabel sizeToFit];
  [lastNameLabel sizeToFit];
  
  
}





@end
