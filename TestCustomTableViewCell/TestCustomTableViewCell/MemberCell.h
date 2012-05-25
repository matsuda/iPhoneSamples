//
//  MemberCell.h
//  TestCustomTableViewCell
//
//  Created by matsuda on 12/05/25.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class User;
@interface MemberCell : UITableViewCell

@property (strong, nonatomic) User *user;

+ (CGFloat)tableView:(UITableView *)tableView heightForObject:(id)object;

@end
