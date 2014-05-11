//
//  ShouyeTableViewCell.m
//  Exercise
//
//  Created by JerryLin on 14-5-3.
//  Copyright (c) 2014年 immortal. All rights reserved.
//

#import "ShouyeTableViewCell.h"

@implementation ShouyeTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
/*
- (void)layoutSubviews
{
    CGRect contentFrame = self.contentView.frame;
    //NSString *s = self.descLabel.text;
    
    self.mainView.frame = CGRectMake(20, 0, contentFrame.size.width-40, 150);
    [self.photo sizeToFit];
    self.photo.contentMode = UIViewContentModeScaleAspectFill;
    UIImage *image = self.photo.image;
    CGFloat photoWidth = self.mainView.frame.size.width;
    CGFloat photoHeight = image.size.height * photoWidth / image.size.height;
    self.photo.frame = CGRectMake(0, 0, photoWidth, photoHeight);
    
    self.nameLabel.frame = CGRectMake(0, self.photo.frame.size.height-30, self.mainView.frame.size.width, 30);
    self.descLabel.frame = CGRectMake(0, 120, self.mainView.frame.size.width, 30);
    
    self.mainView.frame = CGRectMake(20, 0, contentFrame.size.width-40, photoWidth+30);
    
    self.contentView.frame = CGRectMake(contentFrame.origin.x,contentFrame.origin.y,contentFrame.size.width,self.mainView.frame.size.height);
    self.mainView.layer.masksToBounds = YES;
    self.mainView.layer.cornerRadius = 5;
    self.mainView.layer.borderColor = [[UIColor whiteColor] CGColor];
    self.mainView.layer.borderWidth = 4;

}
 */

- (void)configure
{
    
    CGRect contentFrame = self.frame;
    //NSString *s = self.descLabel.text;
    
    self.mainView.frame = CGRectMake(20, 0, contentFrame.size.width-40, 150);
    [self.photo sizeToFit];
    self.photo.contentMode = UIViewContentModeScaleAspectFill;
    UIImage *image = self.photo.image;
    CGFloat photoWidth = self.mainView.frame.size.width;
    CGFloat photoHeight = image.size.height * photoWidth / image.size.height;
    self.photo.frame = CGRectMake(0, 0, photoWidth, photoHeight);
    
    self.nameLabel.frame = CGRectMake(0, self.photo.frame.size.height-20, self.mainView.frame.size.width, 30);
    self.descLabel.frame = CGRectMake(0, 120, self.mainView.frame.size.width, 30);
    
    self.mainView.frame = CGRectMake(20, 0, contentFrame.size.width-40, photoWidth+30);
    
    self.contentView.frame = CGRectMake(contentFrame.origin.x,contentFrame.origin.y,contentFrame.size.width,self.mainView.frame.size.height);
    self.mainView.layer.masksToBounds = YES;
    self.mainView.layer.cornerRadius = 5;
    self.mainView.layer.borderColor = [[UIColor whiteColor] CGColor];
    self.mainView.layer.borderWidth = 4;
    
}

@end
