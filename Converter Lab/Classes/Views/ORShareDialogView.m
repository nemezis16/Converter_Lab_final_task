//
//  ORShareDialogView.m
//  Converter Lab
//
//  Created by RomanOsadchuk on 23.11.15.
//  Copyright (c) 2015 Osadchuk. All rights reserved.
//

#import "ORShareDialogView.h"


@interface ORShareDialogView ()

@property (strong,nonatomic) UIView *backgrondView;
@property (strong,nonatomic) UIView *dialogView;
@property (strong,nonatomic) UIView *buttonView;
@property (strong,nonatomic) UILabel *buttonLabel;

@property (strong,nonatomic) UILabel *bankLabel;
@property (strong,nonatomic) UILabel *regionLabel;
@property (strong,nonatomic) UILabel *cityLabel;

@property (strong, nonatomic) UITableView *tableView;
@property (strong,nonatomic) UILabel *currencyIDLabel;
@property (strong,nonatomic) UILabel *currencyLabel;

@property (strong,nonatomic) NSArray *currenciesArray;

@end

@implementation ORShareDialogView

- (id)initWithFrame:(CGRect)frame {
    self=[super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor colorWithWhite:0.4 alpha:0.6];

        self.translatesAutoresizingMaskIntoConstraints = NO;
        
        UITapGestureRecognizer *backgroundRacognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleBackgroundTap:)];
        [self addGestureRecognizer:backgroundRacognizer];
        [self configureTableView];
        
    }
    return self;
}

#pragma mark - 
#pragma mark window configs

- (void)configureWindow {
    [self dialogView];
    [self buttonView];
    [self buttonLabel];
    [self bankLabel];
    [self regionLabel];
    [self cityLabel];
    
    [self configureTableView];
    [self configureConstraints];
}

- (UIView *)dialogView {
    if (_dialogView) {
        return _dialogView;
    }
    
    _dialogView = [[UIView alloc]init];
    _dialogView.translatesAutoresizingMaskIntoConstraints = NO;
    _dialogView.backgroundColor = [UIColor whiteColor];
    _dialogView.layer.shadowOffset = CGSizeMake(0, 4);
    _dialogView.layer.shadowRadius = 3;
    _dialogView.layer.shadowOpacity = 0.35;
    
    [self addSubview:_dialogView];
    
    //dialog window constraints
    NSDictionary *dialogViewConstrain = NSDictionaryOfVariableBindings(_dialogView);
    NSDictionary *verticalMetrics = @{@"verticalMetrics":@"80.0"};
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-verticalMetrics-[_dialogView(<=280)]-(>=30)-|" options:0 metrics:verticalMetrics views:dialogViewConstrain]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_dialogView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX  multiplier:1.f constant:0.f]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(>=0)-[_dialogView(290)]-(>=0)-|" options:0 metrics:nil views:dialogViewConstrain]];
    
    return _dialogView;
}

- (UIView *)buttonView {
    if (_buttonView) {
        return _buttonView;
    }
    
    _buttonView = [[UIView alloc]init];
    _buttonView.translatesAutoresizingMaskIntoConstraints = NO;
    _buttonView.backgroundColor = [UIColor colorWithRed:167.0/255.0 green:180.0/255.0 blue:187.0/255.0 alpha:1.0];
    [_dialogView addSubview:_buttonView];
  
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleShareTap:)];
    [_buttonView addGestureRecognizer:gestureRecognizer];
    
    return _buttonView;
}

-(UIView *)buttonLabel {
    if(_buttonLabel){
        return _buttonLabel;
    }
    
    _buttonLabel = [UILabel new];
    _buttonLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _buttonLabel.textAlignment = NSTextAlignmentCenter;
    _buttonLabel.textColor = [UIColor colorWithRed:197.0/255.0 green:17.0/255.0 blue:98.0/255.0 alpha:1.0];
    _buttonLabel.font = [UIFont systemFontOfSize:14.0];
    _buttonLabel.text = @"SHARE";
    [_buttonView addSubview:_buttonLabel];
    
    return _buttonLabel;
}

- (UILabel *)bankLabel {
    if (_bankLabel) {
        return _bankLabel;
    }
    
    _bankLabel = [UILabel new];
    _bankLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _bankLabel.textColor = [UIColor colorWithRed:197.0/255.0 green:17.0/255.0 blue:98.0/255.0 alpha:1.0];
    _bankLabel.font = [UIFont systemFontOfSize:17.0];
    _bankLabel.text=self.bank.title;
    [_dialogView addSubview:_bankLabel];

    return _buttonLabel;
}

- (UILabel *)regionLabel {
    if (_regionLabel) {
        return _regionLabel;
    }
    
    _regionLabel = [UILabel new];
    _regionLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _regionLabel.textColor = [UIColor colorWithRed:68.0/255.0 green:103.0/255.0 blue:112.0/255.0 alpha:1.0];
    _regionLabel.font = [UIFont systemFontOfSize:12.0];
    _regionLabel.text=self.bank.region;
    [_dialogView addSubview:_regionLabel];
    
    return _regionLabel;
}

- (UILabel *)cityLabel {
    if (_cityLabel) {
        return _cityLabel;
    }
    
    _cityLabel = [UILabel new];
    _cityLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _cityLabel.textColor =  [UIColor colorWithRed:68.0/255.0 green:103.0/255.0 blue:112.0/255.0 alpha:1.0];
    _cityLabel.font = [UIFont systemFontOfSize:12.0];
    _cityLabel.text=self.bank.city;
    [_dialogView addSubview:_cityLabel];
    
    return _cityLabel;
}

- (void)configureTableView {
    
    self.currenciesArray=[[self.bank currency]  allObjects];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.allowsSelection = NO;
    [_dialogView addSubview:self.tableView];
    self.tableView.translatesAutoresizingMaskIntoConstraints = NO;
}

- (void)configureConstraints {
    
    //add button label constraints
    NSDictionary *shareLabelConstraint = NSDictionaryOfVariableBindings(_buttonLabel);
    [_buttonView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_buttonLabel]|" options:0 metrics:nil views:shareLabelConstraint]];
    [_buttonView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_buttonLabel]|" options:0 metrics:nil views:shareLabelConstraint]];
    
    //title & region & city labels constraints + button configs
     NSDictionary *views = NSDictionaryOfVariableBindings(_bankLabel,_regionLabel,_cityLabel,_buttonView,_tableView);
    NSDictionary *metrics = @{@"labelSpacing":@"6",@"labelPadding":@"20"};
    
    //vertical contsraints
    [_dialogView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-labelPadding-[_bankLabel]-labelSpacing-[_regionLabel]-labelSpacing-[_cityLabel]-4-[_tableView(>=0)]-0-[_buttonView(44)]|" options:0 metrics:metrics views:views]];
    
    //horizontal contsraints
    [_dialogView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-labelPadding-[_bankLabel]-labelPadding-|" options:0 metrics:metrics views:views]];
    
    [_dialogView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-labelPadding-[_regionLabel]-labelPadding-|" options:0 metrics:metrics views:views]];
    
    [_dialogView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-labelPadding-[_cityLabel]-labelPadding-|" options:0 metrics:metrics views:views]];
    
    [_dialogView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_tableView]-|" options:0 metrics:metrics views:views]];
    
    [_dialogView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_buttonView]|" options:0 metrics:metrics views:views]];
}

#pragma mark -
#pragma mark table view data source methods

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.currenciesArray count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell * currencyCell = [tableView dequeueReusableCellWithIdentifier:@"currency"];
    if (!currencyCell)
    {
        currencyCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"currency"];
    }
    
    ORCurrency *currency = self.currenciesArray[indexPath.row];
    currencyCell.textLabel.text = currency.id;
    currencyCell.detailTextLabel.text = [NSString stringWithFormat:@"%.2f/%.2f",[currency.ask floatValue],[currency.bid floatValue]];
    
    currencyCell.textLabel.textColor = [UIColor colorWithRed:197.0/255.0 green:17.0/255.0 blue:98.0/255.0 alpha:1.0];
    currencyCell.detailTextLabel.textColor = [UIColor colorWithRed:68.0/255.0 green:103.0/255.0 blue:112.0/255.0 alpha:1.0];
    
    return currencyCell;
}

#pragma mark -
#pragma mark actionRecognizers

-(void)handleBackgroundTap:(UITapGestureRecognizer *)recognizer  {
    CGPoint location = [recognizer locationInView:self];
    
    if (!CGRectContainsPoint(_dialogView.frame, location)) {
        [self removeFromSuperview];
        self.completionBlock();
    }
}

-(void)handleShareTap:(UITapGestureRecognizer *)recognizer {
    [self removeFromSuperview];
    self.completionBlockWithEmail();
}


@end
