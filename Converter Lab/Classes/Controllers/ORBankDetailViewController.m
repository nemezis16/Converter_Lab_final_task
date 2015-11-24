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
#import "ORMapViewController.h"
#import "ORShareDialogView.h"

@interface ORBankDetailViewController ()

@property (strong,nonatomic) NSArray *currencies;
@property (strong,nonatomic) ORShareDialogView *shareWindow;
@property (strong,nonatomic) ORFloatingButton *floatingButton;
@end

@implementation ORBankDetailViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    
    self.currencies=[[self.bankSelected currency] allObjects];
    self.tableView.delegate=self;
    
    [self addFloatingButton];
    [self customizeTitle];
    [self customizeButtonBarShare];
}

#pragma mark - 
#pragma mark style

-(void)addFloatingButton {
    
    CGRect floatFrame = CGRectMake([UIScreen mainScreen].bounds.size.width - 64, [UIScreen mainScreen].bounds.size.height - 64, 44, 44);
    
    self.floatingButton = [[ORFloatingButton alloc]initWithFrame:floatFrame defaultButtonImage:[UIImage imageNamed:@"ic_hamburger"] highlightedButtonImage:[UIImage imageNamed:@"ic_close"] view:self.view];
    
    self.floatingButton.delegate = self;
    
    [self.view addSubview:self.floatingButton];
    self.floatingButton.imagesForMenuRowsArray = @[@"ic_phone_floating",@"ic_link_floating",@"ic_mark_floating"];
    self.floatingButton.labelsForMenuRowsArray = @[@" Позвонить  ",@" Сайт  ",@" Карта  "];
}


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

-(void)customizeButtonBarShare {
    UIImage* imageShare = [UIImage imageNamed:@"ic_share"];
    CGRect frameImg = CGRectMake(0, 0, imageShare.size.width, imageShare.size.height);
    UIButton *shareButton = [[UIButton alloc] initWithFrame:frameImg];
    [shareButton setImage:imageShare forState:UIControlStateNormal];
    [shareButton addTarget:self action:@selector(actionShare:)
           forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *searchBarButtonItem =[[UIBarButtonItem alloc] initWithCustomView:shareButton];
    self.navigationItem.rightBarButtonItem =  searchBarButtonItem;
}

#pragma mark - Table view data source required methods


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
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

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 5.0f;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
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

#pragma mark -
#pragma mark float button menu

- (void)didSelectMenuOptionAtIndex:(NSInteger)row {
    switch (row) {
        case 0:
            [self goToPhone];
            break;
        case 1:
            [self goToLink];
            break;
        case 2:
            [self goToMap];
            break;
        default:
            break;
    }
}

- (void)goToLink {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.bankSelected.link]];
}

- (void)goToPhone {
    NSString *phoneNumber = [@"tel:" stringByAppendingString:self.bankSelected.phone];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneNumber]];
}

- (void)goToMap {
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main"  bundle: nil];
    ORMapViewController *controller = (ORMapViewController*)[mainStoryboard instantiateViewControllerWithIdentifier: @"mapViewController"];
    controller.bankSelected=self.bankSelected;
    [self.navigationController pushViewController:controller animated:YES];
}


#pragma mark -
#pragma mark share

-(void)actionShare:(id) sender {
    
    if (!self.shareWindow) {
        CGRect frame = self.view.frame;
        self.shareWindow = [[ORShareDialogView alloc]initWithFrame:CGRectMake(0,0,CGRectGetWidth(frame),CGRectGetHeight(frame))];
        self.shareWindow.bank=self.bankSelected;
        [self.shareWindow configureWindow];
    }
    
    [self.view addSubview:self.shareWindow];
    [self addContraintsToShareWindow];
    
    [(UIButton *)sender setEnabled:NO];
    
    //if tapped out
    self.shareWindow.completionBlock=^{
        [(UIButton *)sender setEnabled:YES];
    };
    
    __weak id selfObject=self;
    //if tapped share
    self.shareWindow.completionBlockWithEmail=^{
        [(UIButton *)sender setEnabled:YES];
        [selfObject sendEmail];
    };
}

- (void)addContraintsToShareWindow {
    
    NSDictionary *shareWindow = @{@"shareWindow": self.shareWindow};
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[shareWindow]|" options:0 metrics:nil views:shareWindow]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[shareWindow]|" options:0 metrics:nil views:shareWindow]];
    

}

-(void)sendEmail  {
    
    if ([MFMailComposeViewController canSendMail]) {
        MFMailComposeViewController* controller = [[MFMailComposeViewController alloc] init];
        controller.mailComposeDelegate = self;
        [controller setSubject:self.bankSelected.title];
        [controller setMessageBody:self.bankSelected.link isHTML:NO];
        if (controller) [self presentViewController:controller animated:YES completion:NULL];
        

    } else {
        NSLog(@"device couldn't send e-mail");
    }
   
}

-(void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error{
    if (result == MFMailComposeResultSent) {
        NSLog(@"It's away!");
    }
    [self dismissViewControllerAnimated:YES completion:NULL];
}



@end
