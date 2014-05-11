//
//  ShouyeTableViewController.m
//  Exercise
//
//  Created by JerryLin on 14-5-3.
//  Copyright (c) 2014年 immortal. All rights reserved.
//

#import "ShouyeTableViewController.h"

@interface ShouyeTableViewController ()



@end

@implementation ShouyeTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.navigationItem.leftBarButtonItem.target = nil;
    self.navigationItem.leftBarButtonItem.action = @selector(switch);
    self.tableView.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background.png"]];
    
    // check the insertation sqlite
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Intro"
                                              inManagedObjectContext:self.managedContext];
    [fetchRequest setEntity:entity];
    NSError *error = nil;
    NSArray *fetchedObjects = [self.managedContext executeFetchRequest:fetchRequest error:&error];
    for (Intro *intro in fetchedObjects) {
        NSLog(@"Name: %@", intro.name);
        
    }
    [NSFetchedResultsController deleteCacheWithName:@"root"];
    if (![self.fetchController performFetch:&error]) {
        NSLog(@"Fetch Failed!");
    }
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    self.fetchController = nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - properties

- (NSFetchedResultsController *)fetchController
{
    if (!_fetchController) {
        
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        NSEntityDescription *intro = [NSEntityDescription entityForName:@"Intro" inManagedObjectContext:self.managedContext];
        [fetchRequest setEntity:intro];
        
        // Specify how the fetched objects should be sorted
        NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:NO];
        [fetchRequest setSortDescriptors:[NSArray arrayWithObjects:sortDescriptor, nil]];
        [fetchRequest setFetchBatchSize:20];
        
        _fetchController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedContext sectionNameKeyPath:nil cacheName:@"root"];
        _fetchController.delegate = self;
        
    }
    return _fetchController;
}
/*
- (NSManagedObjectModel *)managedObjectModel
{
    if (!_managedObjectModel) {
        NSURL *modelUrl = [[NSBundle mainBundle] URLForResource:@"DataModel" withExtension:@"momd"];
        _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelUrl];
    }
    return _managedObjectModel;
}
*/

/*
- (NSPersistentStoreCoordinator *)coordinator
{
    if (!_coordinator) {
        NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"Data.sqlite"];
        
        NSError *error = nil;
        _coordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:self.managedObjectModel];
        if (![_coordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
                        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
        
    }
    return _coordinator;
}
*/
/*
- (NSManagedObjectContext *)managedContext
{
    if (!_managedContext) {
        _managedContext = [[NSManagedObjectContext alloc] init];
        [_managedContext setPersistentStoreCoordinator:self.coordinator];
    }
    return _managedContext;
}

- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

*/

#pragma mark - NSFetchedResultsControllerDelegate

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView beginUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath
{
    UITableView *tableView = self.tableView;
    switch (type) {
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate:
            [self configureCell:[tableView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
            break;
            
        case NSFetchedResultsChangeMove:
            [tableView deleteRowsAtIndexPaths:[NSArray
                                               arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [tableView insertRowsAtIndexPaths:[NSArray
                                               arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}

- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id<NSFetchedResultsSectionInfo>)sectionInfo atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type
{
    switch(type) {
            
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView endUpdates];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    id sectionInfo = [[self.fetchController sections] objectAtIndex:section];
    return [sectionInfo numberOfObjects];
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    Intro *intro = [self.fetchController objectAtIndexPath:indexPath];
    ShouyeTableViewCell *mycell = (ShouyeTableViewCell *)cell;
    mycell.nameLabel.text = intro.name;
    mycell.descLabel.text = intro.desc;
    NSData *photo = intro.photo;
    UIImage *image = [UIImage imageWithData:photo];
    mycell.photo.image = image;
    
    
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellid = @"ShouyeCell";
    ShouyeTableViewCell *cell = (ShouyeTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellid forIndexPath:indexPath];
    //ShouyeTableViewCell *cell = [[ShouyeTableViewCell alloc] init];
    // Configure the cell...
    if (!cell) {
        cell = [[ShouyeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
    [self configureCell:cell atIndexPath:indexPath];
    [cell configure];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Intro *intro = [self.fetchController objectAtIndexPath:indexPath];
    UIImage *image = [UIImage imageWithData:intro.photo];
    CGFloat imageWidth = self.view.frame.size.width -40;
    CGFloat imageHeight = imageWidth * image.size.height / image.size.width;
    return imageHeight+30;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    ShouyeTableViewCell *mycell = (ShouyeTableViewCell *)cell;
    CATransform3D t = CATransform3DIdentity;
    t.m34 = 1 / -500;
    t = CATransform3DTranslate(t, mycell.frame.size.width, self.view.frame.size.height , mycell.frame.size.width);
    t = CATransform3DRotate(t, M_PI / 2, 1, 1, 1);
    mycell.layer.transform = t;
    [UIView animateWithDuration:1.0 animations:^{ mycell.layer.transform = CATransform3DIdentity;}];
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        //[tableView beginUpdates];
        
        [self.managedContext deleteObject:[self.fetchController objectAtIndexPath:indexPath]];
        
        //[tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        NSError *err = nil;
        if (![self.managedContext save:&err]) {
            NSLog(@"Unresolved error %@, %@", err, [err userInfo]);
            abort();
        }
        //[tableView endUpdates];
    }
}


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
