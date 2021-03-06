//
//  ORBankListViewController.m
//  Converter Lab
//
//  Created by RomanOsadchuk on 12.11.15.
//  Copyright (c) 2015 Osadchuk. All rights reserved.
//

#import <CoreData/CoreData.h>
#import "ORBankListViewController.h"
#import "ORBankDetailViewController.h"
#import "ORMapViewController.h"

#import "ORDataManager.h"
#import "ORDataManagerDelegate.h"

#import "ORDatabaseModel.h"
#import "ORBank.h"
#import "ORBankListCell.h"

#import "UIView+UITableView.h"
#import "UIView+UITableViewCell.h"
#import "ORUpdatingView.h"

@interface ORBankListViewController ()<ORDataManagerDelegate,NSFetchedResultsControllerDelegate,UISearchBarDelegate,UISearchDisplayDelegate>

@property (strong, nonatomic) ORDataManager *dataManager;
@property (strong, nonatomic) NSFetchedResultsController* fetchedResultController;

@property (strong, nonatomic) UISearchDisplayController *searchController;
@property (strong, nonatomic) NSFetchRequest *searchFetchRequest;
@property (strong, nonatomic) NSArray *filteredList;
@property (strong, nonatomic) UIView *shadowButton;
@property (strong,nonatomic) ORUpdatingView *updatingView;
@property (strong,nonatomic) UISearchBar *searchBar;

@end

@implementation ORBankListViewController

- (void)viewDidLoad  {
    
    [super viewDidLoad];
    
    [self performFetch];
    
    self.dataManager=[[ORDataManager alloc]init];
    self.dataManager.delegate=self;
    [self.dataManager fetchData];
    
    
    self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectZero];
    [self.searchBar sizeToFit];
    [self setSearchController:[[UISearchDisplayController alloc] initWithSearchBar:self.searchBar contentsController:self]];
    [self.searchController setSearchResultsDataSource:self];
    [self.searchController setSearchResultsDelegate:self];
    [self.searchController setDelegate:self];
    [self.searchBar setDelegate:self];
    
    [self addUpdatingView];
    [self customizeSearchBarButtonItem];
    [self customizeBackBarButtonItem];
    [self setTitle:@"Converter Lab"];
}

#pragma mark -
#pragma mark style

- (void)addUpdatingView {
    self.updatingView = [[ORUpdatingView alloc]initWithFrame:CGRectZero];
    [self.navigationController.view addSubview:self.updatingView];
    [self.updatingView addConstraintsToUpdatingView];
}



- (void)setTitle:(NSString *)title {
    [super setTitle:title];
    UIColor *textColor=[UIColor colorWithRed:245.0/255.0 green:245.0/255.0 blue:245.0/255.0 alpha:1.0];
    [self.navigationController.navigationBar setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys:
      textColor,NSForegroundColorAttributeName,
      [UIFont fontWithName:@"SinhalaSangamMN" size:21.0],NSFontAttributeName,
      nil]];
}

-(void)customizeSearchBarButtonItem {
    UIImage* imageSearch = [UIImage imageNamed:@"ic_search"];
    CGRect frameImg = CGRectMake(0, 0, imageSearch.size.width, imageSearch.size.height);
    UIButton *searchButton = [[UIButton alloc] initWithFrame:frameImg];
    [searchButton setImage:imageSearch forState:UIControlStateNormal];
    [searchButton addTarget:self action:@selector(actionSearch:)
         forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *searchBarButtonItem =[[UIBarButtonItem alloc] initWithCustomView:searchButton];
    self.navigationItem.rightBarButtonItem =  searchBarButtonItem;
}

-(void)customizeBackBarButtonItem {
    UIImage *backBtn = [UIImage imageNamed:@"ic_back"];
    backBtn = [backBtn imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.navigationController.navigationBar.backIndicatorTransitionMaskImage = backBtn;
    self.navigationController.navigationBar.backIndicatorImage=backBtn;
}


#pragma mark -
#pragma mark Searching methods

-(void)actionSearch:(id)sender{
    
    [(UIButton *)sender setEnabled:NO];
    [self.searchController setActive:NO];
    
    [UIView animateWithDuration:0.3 animations:^{
        [self.tableView setTableHeaderView:self.searchBar];
        [self.searchController.searchBar becomeFirstResponder];
    }completion:^(BOOL finished){
        [(UIButton *)sender setEnabled:YES];
        [self.searchController setActive:YES];
    }];
    
}

-(void)searchDisplayControllerWillEndSearch:(UISearchDisplayController *)controller{
    [self.tableView setTableHeaderView:nil];
}

- (void)searchForText:(NSString *)searchText scope:(NSString *)scope {
    ORDatabaseModel *dataBaseModel=[ORDatabaseModel getClassInstance];
    
    if (dataBaseModel.managedObjectContext){
        NSPredicate *predicateTitle = [NSPredicate predicateWithFormat:@"title BEGINSWITH[cd] %@", searchText];
        NSPredicate *predicateCity = [NSPredicate predicateWithFormat:@"city BEGINSWITH[cd] %@", searchText];
        NSPredicate *predicateAddres = [NSPredicate predicateWithFormat:@"address BEGINSWITH[cd] %@", searchText];
        NSPredicate *predicateRegion = [NSPredicate predicateWithFormat:@"region BEGINSWITH[cd] %@", searchText];
        
        NSPredicate *predicate =[NSCompoundPredicate orPredicateWithSubpredicates:@[predicateTitle,predicateRegion,predicateCity,predicateAddres]];
        
        [self.searchFetchRequest setPredicate:predicate];
        
        NSError *error = nil;
        self.filteredList = [dataBaseModel.managedObjectContext executeFetchRequest:self.searchFetchRequest error:&error];
    }
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString {
    [self searchForText:searchString scope:nil];
    return YES;
}

#pragma mark -
#pragma mark TableViewDelegate methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (tableView == self.tableView){
        return [[self.fetchedResultController sections] count];
    }
    else
        tableView.allowsSelection=NO;
        return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.tableView){
        NSArray *sections = [self.fetchedResultController sections];
        id<NSFetchedResultsSectionInfo> sectionInfo = [sections objectAtIndex:section];
        return [sectionInfo numberOfObjects];
    }else
        return [self.filteredList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ORBank* bank;
    ORBankListCell *cell;
    
    if (tableView == self.tableView)
    {
        bank = [self.fetchedResultController objectAtIndexPath:indexPath];
        cell = (ORBankListCell *)[tableView dequeueReusableCellWithIdentifier:@"Cell" ];
    }else{
        bank = [self.filteredList objectAtIndex:indexPath.row];
        cell = (ORBankListCell *)[self.tableView dequeueReusableCellWithIdentifier:@"Cell" ];
    }
    
    if (cell==nil) {
        cell=[[ORBankListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    
    cell.title.text= [bank title];
    cell.region.text= [bank region];
    cell.city.text = [bank city];
    cell.phone.text=[NSString stringWithFormat:@"Тел.: %@", [bank phone]];
    cell.address.text =[NSString stringWithFormat:@"Адрес: %@", [bank address]];
    cell.detailsButton.tag=indexPath.row;
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
        return 154.0f;
}

#pragma mark - 
#pragma mark actions

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    ORBank * selectedBank=[self bankForSender:sender];
    
    if([segue.identifier isEqualToString:@"BankDetails"]){
        ORBankDetailViewController *detailViewController=(ORBankDetailViewController *)[segue destinationViewController];
        detailViewController.bankSelected=selectedBank;
    }
    
    if ([segue.identifier isEqualToString:@"mapViewController"]) {
        ORMapViewController *mapViewController=(ORMapViewController *)[segue destinationViewController];
        mapViewController.bankSelected=selectedBank;
    }
    
}

-(ORBank*)bankForSender:(id)sender{
    //used class category
    UITableView *tableView=[sender superTableView];
    ORBankListCell* bankListCell=[sender superBankListCell];
    
    NSIndexPath *indexPath=[tableView indexPathForCell:bankListCell];
    
    //is standart table view
    if (tableView==self.tableView ) {
        return  [self.fetchedResultController objectAtIndexPath:indexPath];
    }else{
        return  [self.filteredList objectAtIndex:indexPath.row];
    }
    
}
- (IBAction)linkButtonPressed:(id)sender {
    
    ORBank * selectedBank=[self bankForSender:sender];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:selectedBank.link]];
}

- (IBAction)phoneButtonPressed:(id)sender {
    ORBank * selectedBank=[self bankForSender:sender];
    
    NSString *phoneNumber = [@"tel:" stringByAppendingString:selectedBank.phone];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneNumber]];
    
}


#pragma mark -
#pragma mark DataManagerDelegate methods

-(void)dataDidUpdate {
    NSLog(@"update success");
    [self.updatingView removeFromSuperview];
}

-(void)dataDidFailWithError:(NSError *)error {
    [self.updatingView removeFromSuperview];
    UIAlertView* alertView=[[UIAlertView alloc]initWithTitle:@"Ошибка" message:@"Нельзя обновить данные :[\n Пожалуйста, проверьте соединение" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alertView show];
}


#pragma mark -
#pragma mark FetchedResultControllerDelegate methods

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView beginUpdates];
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView endUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath {
    switch (type) {
        case NSFetchedResultsChangeInsert: {
            [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
        }
        case NSFetchedResultsChangeDelete: {
            [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
        }
        case NSFetchedResultsChangeUpdate: {
           [self.tableView cellForRowAtIndexPath:indexPath];
            break;
        }
        case NSFetchedResultsChangeMove: {
            [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
        }
    }
}

-(void)performFetch{
    
    ORDatabaseModel *dataBaseModel=[ORDatabaseModel getClassInstance];
    NSFetchRequest *fetchRequest=[[NSFetchRequest alloc]initWithEntityName:@"ORBank"];
    
    [fetchRequest setSortDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"title" ascending:YES]]];
    
    self.fetchedResultController=[[NSFetchedResultsController alloc]initWithFetchRequest:fetchRequest managedObjectContext:dataBaseModel.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    
    [self.fetchedResultController setDelegate:self];
    
    
    NSError *error = nil;
    [self.fetchedResultController performFetch:&error];
    
    if (error) {
        NSLog(@"Unable to perform fetch.");
        NSLog(@"%@, %@", error, error.localizedDescription);
    }
}

- (NSFetchRequest *)searchFetchRequest {
    
    if (_searchFetchRequest != nil)
    {
        return _searchFetchRequest;
    }
    
    ORDatabaseModel *dataBaseModel=[ORDatabaseModel getClassInstance];
    _searchFetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"ORBank" inManagedObjectContext:dataBaseModel.managedObjectContext];
    [_searchFetchRequest setEntity:entity];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"title" ascending:YES];
    NSArray *sortDescriptors = [NSArray arrayWithObjects:sortDescriptor, nil];
    [_searchFetchRequest setSortDescriptors:sortDescriptors];
    
    return _searchFetchRequest;
}

@end
