//
//  ORBankListViewController.m
//  Converter Lab
//
//  Created by RomanOsadchuk on 12.11.15.
//  Copyright (c) 2015 Osadchuk. All rights reserved.
//

#import <CoreData/CoreData.h>
#import "ORBankListViewController.h"
#import "ORDataManager.h"
#import "ORDataManagerDelegate.h"
#import "ORDatabaseModel.h"
#import "ORBank.h"
#import "ORBankListCell.h"
#import "ORBankDetailViewController.h"

@interface ORBankListViewController ()<ORDataManagerDelegate,NSFetchedResultsControllerDelegate,UISearchBarDelegate,UISearchDisplayDelegate>

@property (nonatomic,strong)ORDataManager *dataManager;
@property (nonatomic,strong) NSFetchedResultsController* fetchedResultController;

@property(nonatomic ,strong) UISearchDisplayController *searchController;
@property (strong, nonatomic) NSFetchRequest *searchFetchRequest;
@property (strong, nonatomic) NSArray *filteredList;


@end

@implementation ORBankListViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    
    UIBarButtonItem* buttonBar=[[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    [self.navigationItem setBackBarButtonItem:buttonBar];
    
    [self performFetch];
    
    self.dataManager=[[ORDataManager alloc]init];
    self.dataManager.delegate=self;
    [self.dataManager fetchData];
    
//    ORDataReciever *dataReciever=[ORDataReciever getClassInstance];
//    dataReciever.delegate=self;
//
    
    
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectZero];
    
    [searchBar sizeToFit];
    
    
    [self setSearchController:[[UISearchDisplayController alloc] initWithSearchBar:searchBar contentsController:self]];
    
    
    [self.searchController setSearchResultsDataSource:self];
    [self.searchController setSearchResultsDelegate:self];
    [self.searchController setDelegate:self];
    [searchBar setDelegate:self];
    
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(actionSearch:)];


}

#pragma mark -
#pragma mark Searching methods

-(void)actionSearch:(id)sender{
    
    [UIView animateWithDuration:0.3 animations:^{
        [self.tableView setTableHeaderView:self.searchController.searchBar];
        [self.searchController.searchBar becomeFirstResponder];
    }completion:^(BOOL finished){
        
    }];
}


-(void)searchDisplayControllerWillEndSearch:(UISearchDisplayController *)controller{
    
    [self performFetch];
    [UIView animateWithDuration:0.6 animations:^{
        [self.tableView setTableHeaderView:nil];
        
    }completion:^(BOOL finished){
        
    }];
    
}

- (void)searchForText:(NSString *)searchText scope:(NSString *)scope
{
    
    ORDatabaseModel *dataBaseModel=[ORDatabaseModel getClassInstance];
    
    if (dataBaseModel.managedObjectContext)
    {
        NSString *predicateFormat = @"title CONTAINS[cd] %@";
        NSString *searchAttribute = @"title";
        
        NSFetchRequest *fetchRequest=[[NSFetchRequest alloc]initWithEntityName:@"ORBank"];
        
        [fetchRequest setSortDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"title" ascending:YES]]];
        
        NSPredicate *predicate = [NSPredicate predicateWithFormat:predicateFormat, searchText];
        [self.searchFetchRequest setPredicate:predicate];
        
        NSError *error = nil;
        self.filteredList = [dataBaseModel.managedObjectContext executeFetchRequest:self.searchFetchRequest error:&error];
    }
    //[self.tableView reloadData];
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
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
    
    ORBank* bank=nil;
    ORBankListCell *cell=nil;
    
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

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
        return 154.0f;
}



-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"BankDetails"]){
        ORBankDetailViewController *detailViewController=(ORBankDetailViewController *)[segue destinationViewController];
        
        NSIndexPath *indexPath=[self indexPathWhenClicked:sender];
        ORBank *selectedBank=nil;
        
        selectedBank=[self.fetchedResultController objectAtIndexPath:indexPath];
        
        if (selectedBank) {
            detailViewController.bankSelected=selectedBank;
        }else{
            NSLog(@"indexPath.row %i",indexPath.row);
            UIButton *button=sender;
            NSInteger index=button.tag;
            detailViewController.bankSelected=self.filteredList[index];
        }
        
    }
}

#pragma mark -
#pragma mark DataManagerDelegate methods

-(void)dataDidUpdate{
    
    NSLog(@"success1");
    [self performFetch];
  //  [self.tableView reloadData];

}

-(void)dataDidFailWithError:(NSError *)error{
    
    UIAlertView* alertView=[[UIAlertView alloc]initWithTitle:@"Error" message:@"Data can't be updated :[\n Please, check your connection" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
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



#pragma mark - 
#pragma mark supporting methods


-(NSIndexPath*)indexPathWhenClicked:(id)sender{
    ORBankListCell* currentCell=(ORBankListCell*)[[[sender superview]superview]superview];
    NSIndexPath* indexPath=[self.tableView indexPathForCell:currentCell];
//    if (!indexPath) {
//        UITableView * tableView=(UITableView *)[[currentCell superview]superview];
//        indexPath= [tableView indexPathForCell:currentCell];
//    }
    return indexPath;
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

- (NSFetchRequest *)searchFetchRequest
{
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
