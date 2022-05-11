//
//  Tasks.m
//  todoList
//
//  Created by Menna on 05/04/2022.
//

#import "Tasks.h"

@implementation Tasks

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super init];
    if (self) {
        _name = [coder decodeObjectForKey:@"name"];
       _desc = [coder decodeObjectForKey:@"desc"];;
       _prior = [coder decodeIntForKey:@"priority"];
       _date = [coder decodeObjectForKey:@"date"];
    }
    return self;
}
 

- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:_name forKey:@"name"];
    [coder encodeObject:_desc forKey:@"desc"];
    [coder encodeInt:_prior forKey:@"priority"];
    [coder encodeObject:_date forKey:@"date"];

    
}

@end
