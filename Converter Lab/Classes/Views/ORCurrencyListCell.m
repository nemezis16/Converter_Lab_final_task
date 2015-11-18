//
//  ORCurrencyListCell.m
//  Converter Lab
//
//  Created by RomanOsadchuk on 16.11.15.
//  Copyright (c) 2015 Osadchuk. All rights reserved.
//

#import "ORCurrencyListCell.h"

@implementation ORCurrencyListCell

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
    [super awakeFromNib];
    self.layer.shadowOffset = CGSizeMake(0, 1);
    self.layer.shadowRadius = 3;
    self.layer.shadowOpacity = 0.35;
    
    CGRect shadowRect = CGRectInset(self.bounds, 0, 4);  // inset top/bottom
    self.layer.shadowPath = [[UIBezierPath bezierPathWithRect:shadowRect] CGPath];
}

//-(void)hideShadowBottom{
//    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0,self.frame.size.height, self.frame.size.width, self.frame.size.height/3)];
//    view.backgroundColor=[UIColor whiteColor];
//    [self addSubview:view];
//}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

-(void)setFrame:(CGRect)frame{
    frame.origin.x += 5.0f;
    frame.size.width -= 2 * 5.0f;
   // frame.size.height -=  1.0f;
    [super setFrame:frame];
}

-(void)addShadowPath{
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    // Start at the Top Left Corner
    [path moveToPoint:CGPointMake(0.0, 0.0)];
    
    // Move to the Top Right Corner
    [path addLineToPoint:CGPointMake(CGRectGetWidth(self.frame), 0.0)];
    
    // Move to the Bottom Right Corner
    [path addLineToPoint:CGPointMake(CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))];
    
    // This is the extra point in the middle :) Its the secret sauce.
    [path addLineToPoint:CGPointMake(CGRectGetWidth(self.frame) / 2.0, CGRectGetHeight(self.frame) / 2.0)];
    
    // Move to the Bottom Left Corner
    [path addLineToPoint:CGPointMake(0.0, CGRectGetHeight(self.frame))];
    
    // Move to the Close the Path
    [path closePath];
    
    self.layer.shadowPath = path.CGPath;
}
@end
