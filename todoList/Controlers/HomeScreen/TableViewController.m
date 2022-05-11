//
//  TableViewController.m
//  todoList
//
//  Created by Menna on 05/04/2022.
//

#import "TableViewController.h"
#import "AddTasks.h"
#import "DetailsViewController.h"
#import <Contacts/Contacts.h>
@interface TableViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UISearchBar *search;

@end

@implementation TableViewController
{
    NSUserDefaults *def;
    
    Tasks *Mytask;
    NSMutableArray* selectedTask;
    NSMutableArray* deleteTask;
    BOOL isSelected;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    Mytask=[Tasks new];
    self._ListOfTasks=[NSMutableArray new];
       isSelected=NO;
       _search.delegate=self;
    deleteTask=[NSMutableArray new];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return @"MY TASKS";
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (isSelected) {
        if ([selectedTask count]!=0){
            _tableView.hidden = false;

        }else{
            _tableView.hidden = true;

        }
        return selectedTask.count;
    }else{
        if (self._ListOfTasks.count != 0){
            _tableView.hidden = false;

        }else{
            _tableView.hidden = true;

        }
        return self._ListOfTasks.count;
    }
}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    if(searchText.length==0){
        isSelected=NO;
    }else{
        isSelected=YES;
        selectedTask=[[NSMutableArray alloc]init];
        for (int i=0; i<self._ListOfTasks.count; i++) {
            if ([self._ListOfTasks[i].name hasPrefix:searchText] || [self._ListOfTasks[i].name hasPrefix:[searchText lowercaseString]]) {
                [selectedTask addObject:self._ListOfTasks[i]];
            }
        }
    }
    [_tableView reloadData];
 
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DetailsViewController *show =[self.storyboard instantiateViewControllerWithIdentifier:@"Details"];
    [show setIndex:indexPath.row];
    show.task=[self._ListOfTasks objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:show animated:YES];

}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
//    if(isSelected){
//          cell.textLabel.text=[[selectedTask objectAtIndex:indexPath.row] name ];
//
//          cell.detailTextLabel.text=[[selectedTask objectAtIndex:indexPath.row] desc ];
//      }else{
//          cell.textLabel.text=[[self._ListOfTasks objectAtIndex:indexPath.row] name ];
//
//          cell.detailTextLabel.text=[[self._ListOfTasks objectAtIndex:indexPath.row] desc ];
//      }
    if(isSelected){
           cell.textLabel.text=[[selectedTask objectAtIndex:indexPath.row] name ];
           if([[selectedTask objectAtIndex:indexPath.row] prior]==0){
               cell.imageView.image=[UIImage imageNamed:@"0"];
           }else if ([[selectedTask objectAtIndex:indexPath.row] prior]==1){
               cell.imageView.image=[UIImage imageNamed:@"1"];
           }else{
               cell.imageView.image=[UIImage imageNamed:@"2"];
           }
           
       }else{
           cell.textLabel.text=[[self._ListOfTasks objectAtIndex:indexPath.row] name ];
           if([[self._ListOfTasks objectAtIndex:indexPath.row] prior]==0){
               cell.imageView.image=[UIImage imageNamed:@"0"];
           }else if ([[self._ListOfTasks objectAtIndex:indexPath.row] prior]==1){
               cell.imageView.image=[UIImage imageNamed:@"1"];
           }else{
               cell.imageView.image=[UIImage imageNamed:@"2"];
           }
       }
    return cell;
}
- (IBAction)addTask:(id)sender {
    AddTasks *add =[self.storyboard instantiateViewControllerWithIdentifier:@"AddTasks"];
    [self.navigationController pushViewController:add animated:YES];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    def=[NSUserDefaults standardUserDefaults];
    self._ListOfTasks = [[self readArrayWithCustomObjFromUserDefaults:@"menna"]mutableCopy];
	    [_tableView reloadData];
    
}
-(NSArray *)readArrayWithCustomObjFromUserDefaults:(NSString *)keyName
{
    NSData *data = [def objectForKey:keyName];
    NSArray *myArray = [NSMutableArray arrayWithArray:[NSKeyedUnarchiver unarchiveObjectWithData:data] ];
    return myArray;
}
-(void)writeArrayWithCustomObjToUserDefaults:(NSString *)keyName withArray:(NSMutableArray *)myArray
{
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:myArray];
    [def setObject:data forKey:keyName];
    [def synchronize];
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
         [self._ListOfTasks removeObjectAtIndex:indexPath.row];
         [_tableView deleteRowsAtIndexPaths:[NSMutableArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        def=[NSUserDefaults standardUserDefaults];
        [self writeArrayWithCustomObjToUserDefaults:@"menna" withArray:self._ListOfTasks];
        [_tableView reloadData];

      }
}

- (IBAction)deleteBtn:(UIButton*)sender {
    sender.selected =!sender.selected;
    [self.tableView setEditing:sender.selected animated:YES];
    if(deleteTask.count)
    {
        for(NSString *str in deleteTask){
            [self._ListOfTasks removeObject:str];
        }
        [deleteTask removeAllObjects];
        [_tableView reloadData];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
