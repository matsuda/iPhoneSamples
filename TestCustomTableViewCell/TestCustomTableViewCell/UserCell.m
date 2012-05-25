//
//  UserCell.m
//  TestCustomTableViewCell
//
//  Created by matsuda on 12/05/25.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "UserCell.h"
#import "User.h"

@implementation UserCell

@synthesize user = _user;
@synthesize nameLabel = _nameLabel;
@synthesize memoLabel = _memoLabel;
@synthesize avatarImageView = _avatarImageView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (CGFloat)tableView:(UITableView *)tableView heightForObject:(id)object
{
    User *user = object;
    CGFloat height = 0.f;
    height += 30;
    height += [self sizeOfMemo:user].height;
    height += 5;
    return height;
}

- (void)setUser:(User *)user
{
    _user = user;
    [self assignUser:_user];
}

- (void)assignUser:(User *)user
{
    _nameLabel.text = user.name;
    _memoLabel.text = user.memo;
    CGSize size = [[self class] sizeOfMemo:user];
    CGRect f = _memoLabel.frame;
    f.size = size;
    _memoLabel.frame = f;
    _avatarImageView.image = [UIImage imageNamed:@"avatar"];
}

+ (CGSize)sizeOfMemo:(User *)user
{
    return [user.memo sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(200, CGFLOAT_MAX) lineBreakMode:UILineBreakModeCharacterWrap];
}

@end
