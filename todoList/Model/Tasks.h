//
//  Tasks.h
//  todoList
//
//  Created by Menna on 05/04/2022.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Tasks : NSObject
@property NSString *name;
@property NSString *desc;
@property int prior;
@property NSDate *date;
@end

NS_ASSUME_NONNULL_END
