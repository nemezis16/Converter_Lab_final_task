//
//  ORFloatingButton.m
//  Converter Lab
//
//  Created by RomanOsadchuk on 24.11.15.
//  Copyright (c) 2015 Osadchuk. All rights reserved.
//

#import "ORFloatingButton.h"

@interface ORFloatingButton ()

@property (strong,nonatomic) UIImageView *buttonImageView;
@property (strong,nonatomic) UIImage *imageDefault;
@property (strong,nonatomic) UIImage *imageHighlighted;

@property (strong,nonatomic) UIView *backgroundView;
@property (strong,nonatomic) UIView *mainView;

@property (strong,nonatomic) UITableView *menuTable;
@property (assign,nonatomic) NSInteger numberOfRowsInMenuTable;

@end

@implementation ORFloatingButton


-(instancetype)initWithFrame:(CGRect)frame defaultButtonImage:(UIImage *)defaultButtonImage highlightedButtonImage:(UIImage *)highlightedButtonImage view:(UIView *)view {
    self = [super initWithFrame:frame];
    if (self) {
        
        self.imageDefault = defaultButtonImage;
        self.imageHighlighted = highlightedButtonImage;
        self.mainView = view;
        
        [self configButton];
        [self configBackground];
        [self configMenuTable];
        
        [self addSubview:self.buttonImageView];
        
        
    }
    return self;
}

#pragma mark -
#pragma mark configs

- (void)configButton {
    
    self.autoresizingMask=UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin;
    self.layer.cornerRadius=CGRectGetWidth(self.frame)/2;
    self.backgroundColor = [UIColor colorWithRed:197.0/255.0 green:17.0/255.0 blue:98.0/255.0 alpha:1.0];
    [self setShadow:self];
    
    CGRect imageViewFrame = CGRectMake(CGRectGetMinX(self.bounds),CGRectGetMinY(self.bounds), CGRectGetWidth(self.bounds)/2.5, CGRectGetHeight(self.bounds)/2.5);
    
    self.buttonImageView = [[UIImageView alloc]initWithFrame:imageViewFrame];
    self.buttonImageView.image = self.imageDefault;
    [self.buttonImageView setCenter:CGPointMake(CGRectGetWidth(self.bounds)/2, CGRectGetHeight(self.bounds)/2)];
    
    UITapGestureRecognizer *buttonTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTapButton:)];
    [self addGestureRecognizer:buttonTap];
}

- (void)configBackground {
    
    self.backgroundView = [[UIView alloc] init];
    self.backgroundView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    self.backgroundView.backgroundColor = [UIColor colorWithWhite:0.9f alpha:0.8];
    
    UITapGestureRecognizer *gestureRecognizerForClose =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTapBackground:)];
    [self.backgroundView addGestureRecognizer:gestureRecognizerForClose];
}

- (void)configMenuTable {
    
    self.menuTable = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.menuTable.translatesAutoresizingMaskIntoConstraints = NO;
    
    self.menuTable.scrollEnabled = NO;
    self.menuTable.dataSource = self;
    self.menuTable.delegate = self;
    self.menuTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.menuTable.backgroundColor = [UIColor clearColor];
    self.menuTable.transform = CGAffineTransformMakeRotation(-M_PI);
}

-(void)configuMenuTableConstraints {
    NSDictionary *dictionary = @{@"menuTable": self.menuTable};
    [self.mainView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(>=0)-[menuTable(180)]-(2)-|" options:0 metrics:nil views:dictionary]];
    [self.mainView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(>=0)-[menuTable(180)]-(70)-|" options:0 metrics:nil views:dictionary]];
}

- (void)setShadow:(UIView *) view{
    view.layer.shadowColor = [UIColor blackColor].CGColor;
    view.layer.shadowRadius = 5.f;
    view.layer.shadowOffset = CGSizeMake(0, 10);
    view.layer.shadowOpacity = 0.45;
}

#pragma mark -
#pragma mark actions

- (void)handleTapBackground:(UITapGestureRecognizer *)recognizer {
    CGPoint location = [recognizer locationInView:self.backgroundView];
    if (!CGRectContainsPoint(self.menuTable.frame, location)) {
        [self handleTapButton:nil];
    }
}

- (void)handleTapButton:(UITapGestureRecognizer *)recognizer {
    self.buttonImageView.transform = CGAffineTransformMakeRotation(M_PI);
    self.buttonImageView.alpha = 0.0;
    self.userInteractionEnabled = NO;
    [self changeStateButton];
    
    [UIView animateWithDuration:0.2 animations:^
     {
         self.buttonImageView.alpha = 1.0;
         self.buttonImageView.transform = CGAffineTransformMakeRotation(M_PI);
         self.buttonImageView.transform = CGAffineTransformIdentity;
         
         [self changeStateButtonImage];
     }
        completion:^(BOOL finished) {
            self.userInteractionEnabled = YES;
        }];
}

- (void)changeStateButtonImage {
    if (self.buttonImageView.image == self.imageHighlighted) {
        self.buttonImageView.image = self.imageDefault;
    }else{
        self.buttonImageView.image = self.imageHighlighted;
    }
}

- (void)changeStateButton {
    if (self.buttonImageView.image == self.imageHighlighted) {
        [self actionIfHighlightedTaped];
    }else{
        [self actionIfDefaultTaped];
    }
}

- (void)actionIfDefaultTaped {
    self.backgroundView.frame = self.mainView.frame;
    [self.mainView addSubview:self.backgroundView];
    [self.mainView bringSubviewToFront:self];
    
    self.numberOfRowsInMenuTable = [self.labelsForMenuRowsArray count];
    [self.mainView addSubview:self.menuTable];
    [self.mainView bringSubviewToFront:self.menuTable];
    [self configuMenuTableConstraints];
    [self.menuTable reloadData];
}

- (void)actionIfHighlightedTaped {
    [UIView animateWithDuration:0.55/2 animations:^
     {
         self.backgroundView.alpha = 0;
         self.menuTable.alpha = 0;
         
     } completion:^(BOOL finished)
     {
         self.numberOfRowsInMenuTable = 0;
         [self.backgroundView removeFromSuperview];
         [self.menuTable removeFromSuperview];
         self.backgroundView.alpha = 1;
         self.menuTable.alpha = 1;
     }];
}

#pragma mark - 
#pragma mark table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60.0;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.numberOfRowsInMenuTable;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(floatTableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSTimeInterval delay = (indexPath.row*indexPath.row) * 0.004;
    
    CGAffineTransform scaleTransform = CGAffineTransformMakeScale(1, 1);
    CGAffineTransform translationTransform = CGAffineTransformMakeTranslation(0,-(indexPath.row+1)*CGRectGetHeight(cell.imgView.frame));
    cell.transform = CGAffineTransformConcat(scaleTransform, translationTransform);
    cell.alpha = 0.f;
    
    [UIView animateWithDuration:0.55/2 delay:delay options:UIViewAnimationOptionCurveEaseOut animations:^{
         cell.transform = CGAffineTransformIdentity;
         cell.alpha = 1.f;
     } completion:^(BOOL finished){
     }];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *identifier = @"cell";
    floatTableViewCell *cell = [_menuTable dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell){
        [_menuTable registerNib:[UINib nibWithNibName:@"floatTableViewCell" bundle:nil]forCellReuseIdentifier:identifier];
        cell = [_menuTable dequeueReusableCellWithIdentifier:identifier];
    }
    cell.imgView.image = [UIImage imageNamed:[self.imagesForMenuRowsArray objectAtIndex:indexPath.row]];
    cell.title.text    = [self.labelsForMenuRowsArray objectAtIndex:indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.delegate didSelectMenuOptionAtIndex:indexPath.row];
    [self handleTapButton:nil];
}

@end
