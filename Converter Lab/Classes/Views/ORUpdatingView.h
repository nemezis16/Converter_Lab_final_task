//
//  ORUpdatingView.h
//  Converter Lab
//
//  Created by RomanOsadchuk on 26.11.15.
//  Copyright (c) 2015 Osadchuk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ORUpdatingView : UIView

- (void) addConstraintsToUpdatingView;

@property (strong,nonatomic) UILabel *label;

@end
