//
//  floatTableViewCell.m
//  floatingButtonTrial
//
//  Created by Giridhar on 26/03/15.
//  Copyright (c) 2015 Giridhar. All rights reserved.
//

#import "floatTableViewCell.h"

@implementation floatTableViewCell
@synthesize imgView, title,roundView;

- (void)awakeFromNib
{
    // Initialization code
//    overlay = [UIView new];
//    overlay.backgroundColor = [UIColor colorWithWhite:0.8 alpha:0.6];
//    [title addSubview:overlay];
    
      self.imgView.layer.masksToBounds = YES;
    self.roundView.layer.cornerRadius=15.0f;
    self.roundView.layer.shadowColor = [UIColor blackColor].CGColor;
    self.roundView.layer.shadowRadius = 5.f;
    self.roundView.layer.shadowOffset = CGSizeMake(0, 10);
    self.roundView.layer.shadowOpacity = 0.45;
    
    self.title.layer.shadowColor = [UIColor blackColor].CGColor;
    self.title.layer.shadowRadius = 3.f;
    self.title.layer.shadowOffset = CGSizeMake(0, 4);
    self.title.layer.shadowOpacity = 0.45;
    
//    self.title.backgroundColor = [UIColor colorWithWhite:0.8 alpha:0.8];
//    self.title.layer.cornerRadius = 5.f;
//    self.title.layer.masksToBounds = YES;
    
    self.imgView.center = self.roundView.center;
    self.imgView.contentMode = UIViewContentModeScaleAspectFit;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = [UIColor clearColor];
    self.contentView.transform = CGAffineTransformMakeRotation(-M_PI);
}


-(void)setTitle:(NSString*)txt andImage:(UIImage*)img
{
//    self.title.text = txt;
//    
//    CGFloat width = ceil([self.title.text sizeWithAttributes:@{NSFontAttributeName: self.title.font}].width);
//    
//    CGFloat height = ceil([self.title.text sizeWithAttributes:@{NSFontAttributeName: self.title.font}].height);
//    
//    overlay.frame = CGRectMake(CGRectGetMaxX(self.title.frame), CGRectGetMaxY(self.title.frame), width, height);
//    
//    
//    
//    self.imgView.image = img;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
