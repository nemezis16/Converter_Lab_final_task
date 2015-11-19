//
//  UIView+UITableViewCell.m
//  Converter Lab
//
//  Created by RomanOsadchuk on 19.11.15.
//  Copyright (c) 2015 Osadchuk. All rights reserved.
//

#import "UIView+UITableViewCell.h"


@implementation UIView (ORBankListCell)

-(ORBankListCell *)superBankListCell{
    if ([self.superview isKindOfClass:[ORBankListCell class]]) {
        return (ORBankListCell *)self.superview;
    }
    if (!self.superview) {
        return nil;
    }
    return [self.superview superBankListCell];
}

@end
