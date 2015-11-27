//
//  ORUpdatingView.m
//  Converter Lab
//
//  Created by RomanOsadchuk on 26.11.15.
//  Copyright (c) 2015 Osadchuk. All rights reserved.
//

#import "ORUpdatingView.h"

@implementation ORUpdatingView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:84.0/255.0 green:110.0/255.0 blue:122.0/255.0 alpha:1.0];
        
        self.label = [[UILabel alloc]init];
        self.label.textColor = [UIColor whiteColor];
        self.label.text = @"Updating...";
        self.label.font = [UIFont fontWithName:@"SinhalaSangamMN" size:17.0];
        [self addSubview:self.label];
        [self addLabelConstraints];
    }
    return self;
}

- (void)addConstraintsToUpdatingView {
    self.translatesAutoresizingMaskIntoConstraints = NO;
    NSDictionary *views = @{@"updatingView": self};
    [self.superview addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[updatingView]|" options:0 metrics:nil views:views]];
    [self.superview addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(>=0)-[updatingView(40)]|" options:0 metrics:nil views:views]];
}

- (void)addLabelConstraints {
    self.label.translatesAutoresizingMaskIntoConstraints = NO;
    NSDictionary *views = @{@"updatingViewLabel": self.label};
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[updatingViewLabel]|" options:0 metrics:nil views:views]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(>=0)-[updatingViewLabel(40)]|" options:0 metrics:nil views:views]];
}

@end
