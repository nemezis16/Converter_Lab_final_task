//
//  ORBankDetailViewController.m
//  Converter Lab
//
//  Created by RomanOsadchuk on 16.11.15.
//  Copyright (c) 2015 Osadchuk. All rights reserved.
//

#import "ORBankDetailViewController.h"
#import "ORBankDescriptionCell.h"
#import "ORCurrencyDescriptionCell.h"
#import "ORCurrencyListCell.h"
#import "ORCurrency.h"

@interface ORBankDetailViewController ()

@property (strong,nonatomic) NSArray * currencies;
@property (strong,nonatomic) VCFloatingActionButton* floatingButton;

@end

@implementation ORBankDetailViewController

- (void)viewDidLoad{
    
    [super viewDidLoad];
    
    self.currencies=[[self.bankSelected currency] allObjects];
    
    CGRect floatFrame = CGRectMake([UIScreen mainScreen].bounds.size.width - 44 - 20, [UIScreen mainScreen].bounds.size.height - 44 - 20, 44, 44);
    
    self.floatingButton = [[VCFloatingActionButton alloc]initWithFrame:floatFrame normalImage:[UIImage imageNamed:@"ic_hamburger"] andPressedImage:[UIImage imageNamed:@"ic_close"] withScrollview:self.tableView];
    
    self.floatingButton.delegate = self;
    
    [self.view addSubview:self.floatingButton];
    self.floatingButton.imageArray = @[@"ic_phone_floating",@"ic_link_floating",@"ic_mark_floating"];
    self.floatingButton.labelArray = @[@" Позвонить  ",@" Сайт  ",@" Карта  "];
    
    [self customizeTitle];
}

#pragma mark - 
#pragma mark style

-(void)customizeTitle {
    
    CGRect headerTitleSubtitleFrame = CGRectMake(0, 0, 200, 44);
    UIView* _headerTitleSubtitleView = [[UILabel alloc] initWithFrame:headerTitleSubtitleFrame];
    _headerTitleSubtitleView.backgroundColor = [UIColor clearColor];
    _headerTitleSubtitleView.autoresizesSubviews = NO;
    
    CGRect titleFrame = CGRectMake(0, 2, 200, 24);
    UILabel *titleView = [[UILabel alloc] initWithFrame:titleFrame];
    titleView.backgroundColor = [UIColor clearColor];
    titleView.font = [UIFont fontWithName:@"SinhalaSangamMN" size:18.0];
    titleView.textAlignment = NSTextAlignmentLeft;
    titleView.textColor = [UIColor whiteColor];
    titleView.shadowColor = [UIColor darkGrayColor];
    titleView.shadowOffset = CGSizeMake(0, -1);
    titleView.text = self.bankSelected.title;
    titleView.adjustsFontSizeToFitWidth = YES;
    [_headerTitleSubtitleView addSubview:titleView];
    
    CGRect subtitleFrame = CGRectMake(0, 20, 200, 44-24);
    UILabel *subtitleView = [[UILabel alloc] initWithFrame:subtitleFrame];
    subtitleView.backgroundColor = [UIColor clearColor];
    subtitleView.font = [UIFont fontWithName:@"SinhalaSangamMN" size:13.0];
    subtitleView.textAlignment = NSTextAlignmentLeft;
    subtitleView.textColor = [UIColor whiteColor];
    subtitleView.shadowColor = [UIColor darkGrayColor];
    subtitleView.shadowOffset = CGSizeMake(0, -1);
    subtitleView.text =self.bankSelected.city;
    subtitleView.adjustsFontSizeToFitWidth = YES;
    [_headerTitleSubtitleView addSubview:subtitleView];
    
    _headerTitleSubtitleView.autoresizingMask=UIViewAutoresizingFlexibleLeftMargin;

    self.navigationItem.titleView = _headerTitleSubtitleView;

    
}

#pragma mark - Table view data source required methods


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    switch (section) {
        case 0:
            return 1;
        case 1:
            return 1;
        case 2:
            return [self.currencies count];
        default:
            return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section==0 && indexPath.row==0) {
        ORBankDescriptionCell *bankDescriptionCell=[tableView dequeueReusableCellWithIdentifier:@"bankDetailCell" forIndexPath:indexPath];
        bankDescriptionCell.title.text=self.bankSelected.title;
        bankDescriptionCell.link.text=self.bankSelected.link;
        bankDescriptionCell.address.text=self.bankSelected.address;
        bankDescriptionCell.phone.text=self.bankSelected.phone;
        
    return bankDescriptionCell;
    }
    if (indexPath.section==1 && indexPath.row==0){
        ORCurrencyDescriptionCell *descriptionCell = [tableView dequeueReusableCellWithIdentifier:@"descriptionCurrencyCell" forIndexPath:indexPath];
        return descriptionCell;
    }
    
    if (indexPath.section==2 ) {
        ORCurrencyListCell *currencyCell=[tableView dequeueReusableCellWithIdentifier:@"currencyCell" forIndexPath:indexPath];
        
        ORCurrency *currency=self.currencies[indexPath.row];
        currencyCell.currency.text=currency.currencyDescription;
        currencyCell.bid.text=currency.bid;
        currencyCell.ask.text=currency.ask;
        
        
        return currencyCell;
    }
    return nil;
}

#pragma mark -
#pragma mark - Table view data source optional methods

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 5.0f;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:
            return 157.0f;
        case 1:
            return 51.0f;
        case 2:
            return 51.0f;
        default:
            return 0;
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
        self.floatingButton.transform = CGAffineTransformMakeTranslation(0, scrollView.contentOffset.y);
}

-(void)didSelectMenuOptionAtIndex:(NSInteger)row{
    switch (row) {
        case 0:
            NSLog(@"phone");
            break;
        case 1:
            NSLog(@"link");
            break;
        case 2:
            NSLog(@"map");
            break;
        default:
            break;
    }
}


//-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    UIView *shadowView  =  [[UIView alloc] initWithFrame: CGRectMake(0,0,320,100)];
//    shadowView.backgroundColor = [UIColor whiteColor];
//    
//    // Doing the Decoration Part
//    shadowView.layer.shadowColor = [[UIColor blackColor] CGColor];
//    shadowView.layer.shadowOffset = CGSizeMake(1.0f, 1.0f);
//    shadowView.layer.shadowRadius = 3.0f;
//    shadowView.layer.shadowOpacity = 1.0f;
//    
//    return shadowView;
//}


@end
