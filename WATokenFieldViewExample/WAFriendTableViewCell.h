//
//  InviteFriendTableViewCell.h
//  GetIn
//
//  Created by Wendy Abrantes on 07/09/2015.
//  Copyright (c) 2015 nimbletank. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WAFriendTableViewCell : UITableViewCell
{
    
}

+(NSString*)reuseIdentifier;

-(void)updateWithFirstName:(NSString*)firstName
                  lastName:(NSString*)lastName;

@end
