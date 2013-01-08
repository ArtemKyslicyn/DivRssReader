//
//  BaseDataSorce.m
//  Bruegal
//
//  Created by Artem on 01.03.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DataSource.h"


@implementation DataSource
@synthesize managedObjectContext=_managedObjectContext;
@synthesize managedObjectModel=_managedObjectModel;
@synthesize persistentStoreCoordinator=_persistentStoreCoordinator;

- (id) init {
    
    self = [super init];
    if(self) {
        
    }
    
    return self;
}


- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType: NSPrivateQueueConcurrencyType];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
     // [_managedObjectContext setRetainsRegisteredObjects:YES];
    return _managedObjectContext;
}


- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    
    NSURL *modelURL =[[NSBundle mainBundle] URLForResource:DBNAME withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
     
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    NSString *storeString=[NSString stringWithFormat:@"%@.sqlite",DBNAME];
    NSURL *storeURL =[[self applicationDocumentsDirectory] URLByAppendingPathComponent:storeString];
    
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}

#pragma mark - Application's Documents directory


- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSCachesDirectory inDomains:NSUserDomainMask] lastObject];
}



- (NSManagedObject *) createNew:(NSString *) entityName {
	
    NSManagedObject *product=(NSManagedObject *)[NSEntityDescription insertNewObjectForEntityForName:entityName                                                  inManagedObjectContext:self.managedObjectContext];
	return product;
}



- (void) saveChanges{
	NSError * error;
	if (![self.managedObjectContext save:&error]) {
		NSLog(@"%@",error);
	}
    
}


- (NSArray *) getAllByName:(NSString *)objectName{
	
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:objectName inManagedObjectContext:self.managedObjectContext];
    [request setEntity:entity];
    [request setIncludesPropertyValues:YES];
    [request setReturnsObjectsAsFaults:NO];
    [request setShouldRefreshRefetchedObjects :YES];
    
    
    NSError *error = nil;
    NSMutableArray *mutableFetchResults = [[self.managedObjectContext executeFetchRequest:request error:&error] mutableCopy];
    if (mutableFetchResults == nil) {
        NSLog(@"Error: %@", error);
    }
    return mutableFetchResults;
}

- (NSArray *) getAllByName:(NSString *)objectName predicate:(NSPredicate*)predicate{
	
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:objectName inManagedObjectContext:self.managedObjectContext];
    [request setEntity:entity];
    [request setPredicate:predicate];
    
    
    [request setIncludesPropertyValues:YES];
    [request setReturnsObjectsAsFaults:NO];
    [request setShouldRefreshRefetchedObjects :YES];
    
    NSError *error = nil;
    NSMutableArray *mutableFetchResults = [[self.managedObjectContext executeFetchRequest:request error:&error] mutableCopy];
    if (mutableFetchResults == nil) {
        NSLog(@"Error: %@", error);
    }
    return mutableFetchResults;
}



- (NSArray *) sortArray:(NSArray *) arr byKey:(NSString *)key ascending:(BOOL) ascending {
	
	if(!arr) return nil;
	if([arr count] == 0) return nil;
	
	NSSortDescriptor * sortDescriptor = [[NSSortDescriptor alloc] initWithKey:key ascending:ascending];
    
	NSArray *sortedValues = [arr sortedArrayUsingDescriptors:[NSMutableArray arrayWithObjects:sortDescriptor, nil]];
	
	
	return sortedValues;
}


-(void)removeAllEntityName:(NSString*)entityName withPredicate:(NSPredicate*)predicate{
    
    NSFetchRequest * allEntieties = [[NSFetchRequest alloc] init];
   
    
    [allEntieties setEntity:[NSEntityDescription entityForName:entityName inManagedObjectContext:self.managedObjectContext]];
    [allEntieties setIncludesPropertyValues:YES];
    
    //only fetch the managedObjectID
    
    NSError * error = nil;
    NSArray * entities = [self.managedObjectContext executeFetchRequest:allEntieties error:&error];
   
    NSLog(@"%d",entities.count);
    
    if (predicate) {
         NSArray * arr = [entities filteredArrayUsingPredicate:predicate];
         entities=arr;
    }
    
    
    //error handling goes here
    for (NSManagedObject * entity in entities) {
        [self.managedObjectContext deleteObject:entity];
    }
    
    NSError *saveError = nil;
    [self.managedObjectContext save:&saveError];

    
}


@end
