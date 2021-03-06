//
//  ORBankListCell.m
//  Converter Lab
//
//  Created by RomanOsadchuk on 16.11.15.
//  Copyright (c) 2015 Osadchuk. All rights reserved.
//

#import "ORBankListCell.h"

@implementation ORBankListCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.layer.shadowOffset = CGSizeMake(0, 1);
    self.layer.shadowRadius = 3;
    self.layer.shadowOpacity = 0.45;
    
    [self setupConstraints];
}

-(void)setupConstraints{
    [self setupWidthForButton:self.detailsButton];
    [self setupWidthForButton:self.callButton];
    [self setupWidthForButton:self.linkButton];
    [self setupWidthForButton:self.mapButton];
}

-(void)setupWidthForButton:(UIButton *)button{
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:button
                                                     attribute:NSLayoutAttributeWidth
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeWidth
                                                    multiplier:0.25
                                                      constant:0]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    //[super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

-(void)setFrame:(CGRect)frame{
    frame.origin.x += 5.0f;
    frame.origin.y += 5.0f;
    frame.size.width -= 2 * 5.0f;
    frame.size.height -= 2 * 3.0f;
    [super setFrame:frame];
}



@end
