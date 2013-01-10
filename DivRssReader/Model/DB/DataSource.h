

//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface DataSource : NSObject
{
	
	NSManagedObjectModel * _managedObjectModel;
	NSManagedObjectContext * _managedObjectContext;
	NSPersistentStoreCoordinator * _persistentStoreCoordinator;
    
}

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;


- (NSManagedObject *) createNew:(NSString *) entityName;
/*
 @discussion Saves all made changes with db.
 */
- (void) saveChanges;
/*!
 @discussion Returns all objects of entity with given name.
 @param objectName Given name of entity.
 @result array of objects from db.
 */
- (NSArray *) getAllByName:(NSString *)objectName;
/*!
 @discussion Returns array with ManagedObject objects sorted with sortExpression given.
 @param objectName Name of NSManagedObject
 @param sortExpression Sort expresstion.
 @result Array of objects.
 */
//- (NSArray *) getDataFromObject:(NSString *) objectName withSort:(NSString *)sortExpression;
/*!
 @discussion Сортировка переданного массива по ключу.
 @param arr Массив для сортировки.
 @param key Поле по которому сортировать.
 @param ascend По возростанию или убыванию, YES - (A-Z), NO - (Z-A).
 @result Отсортированный массив.
 */
- (NSArray *) sortArray:(NSArray *) arr byKey:(NSString *)key ascending:(BOOL) ascending;
/*!
 @discussion Internal method. Searches .mom files in main bundle to load db scheme from.
 @result File path if found .mom file, otherwise nil.
 */
//- (NSString *) modelFilePath;
/*!
 @discussion File path to save created sqlite or load from into application. Sublasses should overwrite.
 Default is path created with name of .mom file in application documents directory.
 @result 
 */
//- (NSString *) dbSQLiteFilePath;

/*!
 @discussion Remove entities in database with predicate.
 @result 
 */
-(void)removeAllEntityName:(NSString*)entityName withPredicate:(NSPredicate*)predicate;

- (NSArray *) getAllByName:(NSString *)objectName predicate:(NSPredicate*)predicate;



@end
