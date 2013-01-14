

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
/*
 @discussion property context for nmanaged object
 */
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
/*
 @discussion property model for nmanaged object
 */
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
/*
 @discussion property for persisten store coordinator
 */

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

/*
 @discussion Сортировка переданного массива по ключу.
 @param arr Массив для сортировки.
 @param key Поле по которому сортировать.
 @param ascend По возростанию или убыванию, YES - (A-Z), NO - (Z-A).
 @result Отсортированный массив.
 */
- (NSArray *) sortArray:(NSArray *) arr byKey:(NSString *)key ascending:(BOOL) ascending;

/*!
 @discussion Remove entities in database with predicate.
 @result 
 */
-(void)removeAllEntityName:(NSString*)entityName withPredicate:(NSPredicate*)predicate;

/*
 @discussion get Array for key
 @param arr object type namr
 @param prdicate fo get objects
 @result Отсортированный массив.
 */
- (NSArray *) getAllByName:(NSString *)objectName predicate:(NSPredicate*)predicate;



@end
