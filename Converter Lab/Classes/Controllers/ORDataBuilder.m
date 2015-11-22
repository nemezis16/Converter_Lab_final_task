//
//  ORORDataBuilder.m
//  Converter Lab
//
//  Created by RomanOsadchuk on 13.11.15.
//  Copyright (c) 2015 Osadchuk. All rights reserved.
//

#define NULL_TO_NIL(obj) ({ __typeof__ (obj) __obj = (obj); __obj == [NSNull null] ? nil : obj; })

#import "ORDataBuilder.h"
#import "ORDatabaseModel.h"
#import "ORBank.h"
#import "ORCurrency.h"
#import <CoreData/CoreData.h>

@implementation ORDataBuilder


//refactor later
-(void)updateManagedObjectContextWithData:(NSData *)data{
    
    NSError *error=nil;
    NSDictionary *dataSerialized = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
    
    if (error) {
        NSLog(@" some error occured %@",[error localizedDescription] );
        return;
    }
    
    ORDatabaseModel *databaseModel=[ORDatabaseModel getClassInstance];
    
    // data with values which need to be inserted into organizations
    NSArray *organizationsArray= dataSerialized [@"organizations"];
    NSDictionary *currencies= dataSerialized [@"currencies"];
    NSDictionary *regions= dataSerialized [@"regions"];
    NSDictionary *cities= dataSerialized [@"cities"];
    NSDictionary *orgTypes= dataSerialized [@"orgTypes"];
    
    //bank entity
    NSEntityDescription *bankEntity = [NSEntityDescription entityForName:@"ORBank" inManagedObjectContext:databaseModel.managedObjectContext];
    
    //currency entity
     NSEntityDescription *currencyEnity = [NSEntityDescription entityForName:@"ORCurrency" inManagedObjectContext:databaseModel.managedObjectContext];
    

        for(NSDictionary* organizationDict in organizationsArray){
            
            ORBank *bank=[[ORBank alloc]initWithEntity:bankEntity insertIntoManagedObjectContext:databaseModel.managedObjectContext];
            
            bank.orgType=orgTypes[[NSString stringWithFormat:@"%@",NULL_TO_NIL( organizationDict[@"orgType"])]];
            
            bank.region=NULL_TO_NIL(regions[organizationDict[@"regionId"]]);
            
            bank.city=NULL_TO_NIL(cities[organizationDict[@"cityId"]]);
            
            bank.title=NULL_TO_NIL(organizationDict[@"title"]);
            
            bank.phone=NULL_TO_NIL(organizationDict[@"phone"]);
            
            bank.address=NULL_TO_NIL(organizationDict[@"address"]);
            
            bank.link=NULL_TO_NIL(organizationDict[@"link"]);
            
            
            //working with currency for current bank
            NSDictionary *currenciesInBank=organizationDict[@"currencies"];
            
            NSArray *currencyIDArray=[currenciesInBank allKeys];
            
            NSInteger i;
            for(i=0;i<[currenciesInBank count];i++){
                
                //create currency
                ORCurrency *currency=[[ORCurrency alloc]initWithEntity:currencyEnity insertIntoManagedObjectContext:databaseModel.managedObjectContext];
                
                NSString *currencyID=NULL_TO_NIL(currencyIDArray[i]);
                
                //transform currency description
                NSString *currencyDescription=NULL_TO_NIL( currencies[currencyID]);
                currency.currencyDescription=currencyDescription;
                currency.bid=NULL_TO_NIL([currenciesInBank[currencyID] valueForKey :@"bid"]);
                currency.ask=NULL_TO_NIL([currenciesInBank[currencyID] valueForKey: @"ask"]);
                
                // add currency to bank
                [bank addCurrencyObject: currency];
                
            }
        }
    
    [databaseModel saveContext];
    
}

#pragma mark -
#pragma mark Database clear stack

-(void)clearDatabase{
    
    [self clearBanks];
    
    [self clearCurrencies];
    
    [[ORDatabaseModel getClassInstance] saveContext];
    
}

-(void)clearBanks{
    ORDatabaseModel *databaseModel=[ORDatabaseModel getClassInstance];
    
    //clear banks
    NSFetchRequest *allBanks = [[NSFetchRequest alloc] init];
    
    [allBanks setEntity:[NSEntityDescription entityForName:@"ORBank" inManagedObjectContext:databaseModel.managedObjectContext]];
    
    [allBanks setIncludesPropertyValues:NO];
    
    NSError *error = nil;
    NSArray *banks = [databaseModel.managedObjectContext executeFetchRequest:allBanks error:&error];
    
    if (banks)
        for (NSManagedObject *bank in banks) {
            [databaseModel.managedObjectContext deleteObject:bank];
        }
}

-(void)clearCurrencies{
    
    ORDatabaseModel *databaseModel=[ORDatabaseModel getClassInstance];
    
    //clear currencies
    NSFetchRequest *allCurrencies = [[NSFetchRequest alloc] init];
    
    [allCurrencies setEntity:[NSEntityDescription entityForName:@"ORCurrency" inManagedObjectContext:databaseModel.managedObjectContext]];
    
    [allCurrencies setIncludesPropertyValues:NO];
    
    NSError *error = nil;
    
    NSArray *currencies = [databaseModel.managedObjectContext executeFetchRequest:allCurrencies error:&error];
    
    if (currencies)
        for (NSManagedObject *currency in currencies) {
            [databaseModel.managedObjectContext deleteObject:currency];
        }
    
    
}

@end
