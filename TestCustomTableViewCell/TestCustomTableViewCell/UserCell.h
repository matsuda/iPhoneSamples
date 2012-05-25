//
//  UserCell.h
//  TestCustomTableViewCell
//
//  Created by matsuda on 12/05/25.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class User;
@interface UserCell : UITableViewCell

@property (strong, nonatomic) User *user;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *memoLabel;
@property (strong, nonatomic) IBOutlet UIImageView *avatarImageView;

+ (CGFloat)tableView:(UITableView *)tableView heightForObject:(id)object;

@end
