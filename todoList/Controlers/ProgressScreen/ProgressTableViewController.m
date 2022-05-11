//
//  ProgressTableViewController.m
//  todoList
//
//  Created by Menna on 06/04/2022.
//

#import "ProgressTableViewController.h"
#import "Tasks.h"
#import "DetailsViewController.h"
@interface ProgressTableViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ProgressTableViewController
{
    NSUserDefaults *def;
    NSMutableArray<Tasks*> *_ListOfTasks;
    Tasks *Mytask;
    BOOL isSelected;
    NSMutableArray* selectedTask;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    Mytask=[Tasks new];
    isSelected=NO;

    // Do any additional setup after loading the view.
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _ListOfTasks.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    //cell.accessoryType =UITableViewCellAccessoryNone;
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
           cell.textLabel.text=[[_ListOfTasks objectAtIndex:indexPath.row] name ];
           if([[_ListOfTasks objectAtIndex:indexPath.row] prior]==0){
               cell.imageView.image=[UIImage imageNamed:@"0"];
           }else if ([[_ListOfTasks objectAtIndex:indexPath.row] prior]==1){
               cell.imageView.image=[UIImage imageNamed:@"1"];
           }else{
               cell.imageView.image=[UIImage imageNamed:@"2"];
           }
       }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DetailsViewController *show =[self.storyboard instantiateViewControllerWithIdentifier:@"ProgressDetailsViewController"];
    [show setIndex:indexPath.row];
    show.task=[_ListOfTasks objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:show animated:YES];
    
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return @"PROGRESS TASKS";
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    def=[NSUserDefaults standardUserDefaults];
    _ListOfTasks=[[self readArrayWithCustomObjFromUserDefaults:@"Prog"]mutableCopy];
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
         [_ListOfTasks removeObjectAtIndex:indexPath.row];
         [_tableView deleteRowsAtIndexPaths:[NSMutableArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        def=[NSUserDefaults standardUserDefaults];
        [self writeArrayWithCustomObjToUserDefaults:@"Prog" withArray:_ListOfTasks];
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
