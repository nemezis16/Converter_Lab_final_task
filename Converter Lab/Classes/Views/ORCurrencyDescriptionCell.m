//
//  ORCurrencyDescriptionCell.m
//  Converter Lab
//
//  Created by RomanOsadchuk on 16.11.15.
//  Copyright (c) 2015 Osadchuk. All rights reserved.
//

#import "ORCurrencyDescriptionCell.h"

@implementation ORCurrencyDescriptionCell

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
    self.layer.shadowOffset = CGSizeMake(1, 1);
    self.layer.shadowRadius = 3;
    self.layer.shadowOpacity = 0.55;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setFrame:(CGRect)frame{
    frame.origin.x += 5.0f;
    frame.origin.y += 1.0f;
    frame.size.width -= 2 * 5.0f;
    frame.size.height -= 2 * 2.0f;
    [super setFrame:frame];
}

@end
