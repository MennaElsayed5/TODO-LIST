//
//  TableViewController.h
//  todoList
//
//  Created by Menna on 05/04/2022.
//

#import <UIKit/UIKit.h>
#import "Tasks.h"
NS_ASSUME_NONNULL_BEGIN

@interface TableViewController : UIViewController <UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>

@property NSMutableArray<Tasks*> *_ListOfTasks;

@end

NS_ASSUME_NONNULL_END
