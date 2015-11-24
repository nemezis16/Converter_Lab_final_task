//
//  ORFloatingButton.h
//  Converter Lab
//
//  Created by RomanOsadchuk on 24.11.15.
//  Copyright (c) 2015 Osadchuk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "floatTableViewCell.h"

@protocol floatMenuDelegate <NSObject>

@optional
-(void) didSelectMenuOptionAtIndex:(NSInteger)row;
@end

@interface ORFloatingButton : UIView <UITableViewDataSource,UITableViewDelegate>

@property id<floatMenuDelegate> delegate;
@property (strong,nonatomic) NSArray *imagesForMenuRowsArray;
@property (strong,nonatomic) NSArray *labelsForMenuRowsArray;

-(instancetype)initWithFrame:(CGRect)frame defaultButtonImage:(UIImage *)defaultButtonImage highlightedButtonImage:(UIImage *)activeImage view:(UIView *)view ;
@end
