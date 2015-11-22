//
//  UIView+UITableView.m
//  Converter Lab
//
//  Created by RomanOsadchuk on 19.11.15.
//  Copyright (c) 2015 Osadchuk. All rights reserved.
//

#import "UIView+UITableView.h"

@implementation UIView (UITableView)

-(UITableView *)superTableView{
    if ([self.superview isKindOfClass:[UITableView class]]) {
        return (UITableView *)self.superview;
    }
    if (!self.superview) {
        return nil;
    }
    return [self.superview superTableView];
}

@end
