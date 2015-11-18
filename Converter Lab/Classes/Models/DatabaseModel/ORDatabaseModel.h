//
//  ORDatabaseModel.h
//  Converter Lab
//
//  Created by RomanOsadchuk on 12.11.15.
//  Copyright (c) 2015 Osadchuk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ORDatabaseModel : NSObject

-(void)saveContext;
+(id)getClassInstance;

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) NSManagedObjectModel *managedObjectModel;


@end
