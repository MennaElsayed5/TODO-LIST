//
//  ProgressDetailsViewController.h
//  todoList
//
//  Created by Menna on 06/04/2022.
//

#import "ViewController.h"
#import "Tasks.h"
NS_ASSUME_NONNULL_BEGIN

@interface ProgressDetailsViewController : ViewController
@property Tasks *task;
@property int index;
@end

NS_ASSUME_NONNULL_END
