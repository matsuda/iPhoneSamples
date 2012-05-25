//
//  MemberCell.m
//  TestCustomTableViewCell
//
//  Created by matsuda on 12/05/25.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "MemberCell.h"
#import "User.h"

@implementation MemberCell {
    CGImageRef _aImgRef;
}

@synthesize user = _user;

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

- (void)drawRect:(CGRect)rect
{
    [_user.name drawInRect:CGRectMake(80, 5, 200, 21) withFont:[UIFont boldSystemFontOfSize:16] lineBreakMode:UILineBreakModeCharacterWrap];

    CGSize size = [[self class] sizeOfMemo:_user];
    [_user.memo drawInRect:CGRectMake(80, 30, size.width, size.height) withFont:[UIFont systemFontOfSize:14] lineBreakMode:UILineBreakModeCharacterWrap];

    UIImage *image = [UIImage imageNamed:@"avatar"];
    _aImgRef = CGImageRetain(image.CGImage);

    CGContextRef context = UIGraphicsGetCurrentContext();
    CGRect r = CGRectMake(10, -5, 60, 60);
    CGContextTranslateCTM(context, 0, r.size.height);
    CGContextScaleCTM(context, 1, -1);
    CGContextDrawImage(context, r, _aImgRef);
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self setNeedsDisplay];
}
- (void)setUser:(User *)user
{
    _user = user;
//    UIImage *image = [UIImage imageNamed:@"avatar"];
//    _aImgRef = CGImageRetain(image.CGImage);
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

+ (CGSize)sizeOfMemo:(User *)user
{
    return [user.memo sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(200, CGFLOAT_MAX) lineBreakMode:UILineBreakModeCharacterWrap];
}

@end
