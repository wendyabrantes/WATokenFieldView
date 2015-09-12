//
//  ViewController.m
//  WATokenFieldView
//
//  Created by Wendy Abrantes on 12/09/2015.
//  Copyright (c) 2015 ABRANTES DIGITAL LTD. All rights reserved.
//

#import "ViewController.h"

#import "WAFriendTableViewCell.h"

@interface ViewController ()
{
  CGFloat tokenViewHeight;
  CGFloat minimumHeight;
  WATokenFieldView *_tokenFieldView;
  UITableView *_friendsTableView;
  
  NSArray *allFriendsData;
  NSArray *filteredFriendsData;
  NSArray *currentData;
  
}
@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.
  
  allFriendsData = @[
  @{
    @"id": @"435gdrg45",
    @"first_name":@"bessie",
    @"last_name":@"smith"
  },
  @{
    @"id": @"dvrt435",
    @"first_name":@"michelle",
    @"last_name":@"obama"
  },
  @{
    @"id": @"3juk78",
    @"first_name":@"serena",
    @"last_name":@"williams"
  },
  @{
    @"id": @"ghkio53",
    @"first_name":@"oprah",
    @"last_name":@"winfrey"
  },
  @{
    @"id": @"srthrb3",
    @"first_name":@"halle",
    @"last_name":@"berry"
  },
  @{
    @"id": @"fgnhjklu34",
    @"first_name":@"lolo",
    @"last_name":@"jones"
  },
  @{
    @"id": @"scq325",
    @"first_name":@"venus",
    @"last_name":@"williams"
  },
  @{
    @"id": @"dfbtkuy96",
    @"first_name":@"marcia",
    @"last_name":@"fudge"
  },
  @{
    @"id": @"luodf34",
    @"first_name":@"gween",
    @"last_name":@"moore"
  },
  @{
    @"id": @"bvnstuy",
    @"first_name":@"laura",
    @"last_name":@"richardson"
  },
  @{
    @"id": @"fbwrt47",
    @"first_name":@"barbara lee",
    @"last_name":@"winfrey"
  },
  @{
    @"id": @"hg0daf",
    @"first_name":@"toni",
    @"last_name":@"morrisson"
  },
  @{
    @"id": @"xvewftyr54",
    @"first_name":@"audrey",
    @"last_name":@"lorde"
  },
  @{
    @"id": @"bgfjyt3456",
    @"first_name":@"wanda",
    @"last_name":@"coleman"
  },
  @{
    @"id": @"gfnoi765543fv",
    @"first_name":@"alice",
    @"last_name":@"walker"
  },
  @{
    @"id": @"vbwoi765",
    @"first_name":@"rita",
    @"last_name":@"dove"
  },
  @{
    @"id": @"vfs423i8uyt",
    @"first_name":@"maya",
    @"last_name":@"angelou"
  },
  @{
    @"id": @"gfyti9765432fe",
    @"first_name":@"lisa",
    @"last_name":@"leslie"
  }];
  
  currentData = allFriendsData;
  
  minimumHeight = 50;
  tokenViewHeight = 100;
  
  _tokenFieldView = [[WATokenFieldView alloc]initWithTextColor:[UIColor blackColor]
                                              placeholderColor:[UIColor lightGrayColor]
                                                separatorColor:[UIColor lightGrayColor]
                                             tagHighlightColor:[UIColor blueColor]
                                                 textFieldFont:[UIFont systemFontOfSize:15]
                                              maxNumberOfLines:2];

  _tokenFieldView.delegate = self;
  _tokenFieldView.placeholder = @"enter a name";

  _friendsTableView = [[UITableView alloc] init];
  _friendsTableView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
  _friendsTableView.dataSource = self;
  _friendsTableView.delegate = self;
  _friendsTableView.allowsMultipleSelection = YES;
  [_friendsTableView registerClass:[WAFriendTableViewCell class] forCellReuseIdentifier:[WAFriendTableViewCell reuseIdentifier]];
  
  [self.view addSubview:_tokenFieldView];
  [self.view addSubview:_friendsTableView];
  
  [_friendsTableView reloadData];
}

-(void)viewWillLayoutSubviews
{
  [super viewWillLayoutSubviews];
  [self doLayout];
}
                                                                   
-(void)doLayout{
  
    _tokenFieldView.frame = CGRectMake(0, 20, CGRectGetWidth(self.view.frame), tokenViewHeight);
    _friendsTableView.frame = CGRectMake(0,
                                         CGRectGetMaxY(_tokenFieldView.frame) + 1,
                                         CGRectGetWidth(self.view.frame),
                                         CGRectGetHeight(self.view.frame) - CGRectGetMaxY(_tokenFieldView.frame));
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}


#pragma mark TABLE VIEW

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  WAFriendTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[WAFriendTableViewCell reuseIdentifier]];
  
  NSDictionary *friend = [currentData objectAtIndex:indexPath.row];
  
  if(!cell){
    cell = [[WAFriendTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[WAFriendTableViewCell reuseIdentifier]];
  }
  
  if([_tokenFieldView.tokenIds containsObject:friend[@"id"]]){
    [_friendsTableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionNone];
  }

  [cell updateWithFirstName:friend[@"first_name"]
                   lastName:friend[@"last_name"]];
  
  return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
  return 100;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return currentData.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
  return 1;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  NSDictionary *friend = [currentData objectAtIndex:indexPath.row];
  
  //check doesnt exist in token views
  if(![[_tokenFieldView tokenIds] containsObject:friend[@"id"]]){
    [_tokenFieldView addToken:[NSString stringWithFormat:@"%@ %@", friend[@"first_name"], friend[@"last_name"]]
                      tokenId:friend[@"id"]
                     animated:YES];
  }
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
  NSDictionary *friend = [currentData objectAtIndex:indexPath.row];
  if(friend){
    if([[_tokenFieldView tokenIds] indexOfObject:friend[@"id"]] != -1)
    {
      NSInteger index = [[_tokenFieldView tokenIds] indexOfObject:friend[@"id"]];
      [_tokenFieldView removeTokensAtIndexes:[[NSIndexSet alloc] initWithIndex:index]];
    }
  }
}

#pragma mark SCROLLVIEW DELEGATE
- (void)clearFirstResponder:(UIView *)v
{
  if (v == nil)
    return;
  
  for (UIView *view in v.subviews)
  {
    if ([view isFirstResponder])
    {
      [view resignFirstResponder];
      return;
    }
    [self clearFirstResponder:view];
  }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
  if([_tokenFieldView hasFirstResponder]){
    [self clearFirstResponder:_tokenFieldView];
  }
}

#pragma mark TOKEN VIEW


-(void)tokenFieldView:(WATokenFieldView *)tokenFieldView didChangeHeight:(float)height
{
  if(height != tokenFieldView.frame.size.height)
  {
    tokenViewHeight = height;
    [UIView animateWithDuration:0.3
                     animations:^{
                       [self doLayout];
                     }];
  }
}

-(void)tokenFieldView:(WATokenFieldView *)tokenFieldView didChangeSearchStatus:(bool)searchIsActive byClearingTextField:(bool)byClearingTextField
{
  if(!searchIsActive){
    currentData = allFriendsData;
    [_friendsTableView reloadData];
  }
}

-(void)beginSearchWithName:(NSString*)paramName
{
  NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(first_name CONTAINS[cd] %@) || (last_name CONTAINS[cd] %@)", paramName, paramName];
  filteredFriendsData = [allFriendsData filteredArrayUsingPredicate:predicate];
  currentData = filteredFriendsData;
  [_friendsTableView reloadData];
}

-(void)tokenFieldView:(WATokenFieldView *)tokenFieldView
        didChangeText:(NSString *)text
{
  [self beginSearchWithName:text];
}

-(void)tokenFieldView:(WATokenFieldView *)tokenFieldView
 didDeleteTokenWithId:(id)tokenId
{
  if (tokenFieldView == _tokenFieldView)
  {
    if ([tokenId isKindOfClass:[NSString class]])
    {
      NSMutableArray *selectedRows = [NSMutableArray arrayWithArray:_friendsTableView.indexPathsForSelectedRows];
      for(NSIndexPath *indexPath in selectedRows)
      {
        if([currentData objectAtIndex:indexPath.row][@"id"] == tokenId){
          
          [_friendsTableView deselectRowAtIndexPath:indexPath
                                          animated:NO];
        }
      }
    }
  }
}

@end
