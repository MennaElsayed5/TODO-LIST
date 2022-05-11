//
//  DetailsViewController.m
//  todoList
//
//  Created by Menna on 05/04/2022.
//

#import "DetailsViewController.h"
#import "TableViewController.h"
#import "DoneTableViewController.h"
#import "ProgressTableViewController.h"
@interface DetailsViewController ()
@property (weak, nonatomic) IBOutlet UITextField *labelName;
@property (weak, nonatomic) IBOutlet UITextField *labelDesc;
@property (weak, nonatomic) IBOutlet UISegmentedControl *labelPrior;
@property (weak, nonatomic) IBOutlet UIDatePicker *labelDate;


@end

@implementation DetailsViewController
{
    Tasks *tasks;
     
    NSMutableArray *listOfTaskDone;
    NSMutableArray *listOfTaskProg;
    NSUserDefaults *def;
    NSUserDefaults *defDone;
    NSUserDefaults *defProg;
    TableViewController *table;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    tasks=  [Tasks new];

    _labelName.text=_task.name;
    _labelDesc.text=_task.desc;
    _labelPrior.selectedSegmentIndex=_task.prior;
    _labelDate.date=_task.date;
    
    def =[NSUserDefaults standardUserDefaults];
    defDone =[NSUserDefaults standardUserDefaults];
    defProg=[NSUserDefaults standardUserDefaults];
    
    listOfTaskDone =[NSMutableArray new];
    
    listOfTaskProg=[NSMutableArray new];
    table = [TableViewController new];
    
    table._ListOfTasks=[[self readArrayWithCustomObjFromUserDefaults:@"menna"]mutableCopy];
    listOfTaskDone=[[self readArrayWithCustomObjFromUserDefaults:@"Done"]mutableCopy ];
    listOfTaskProg=[[self readArrayWithCustomObjFromUserDefaults:@"Prog"]mutableCopy ];

      
    // Do any additional setup after loading the view.
}
- (IBAction)doneBtn:(id)sender {
    tasks.name=_labelName.text;
    tasks.desc=_labelDesc.text;
    tasks.prior=_labelPrior.selectedSegmentIndex;
    tasks.date=_labelDate.date;
    [listOfTaskDone addObject:tasks];
    [table._ListOfTasks removeObjectAtIndex:_index];
    [self writeArrayWithCustomObjToUserDefaults:@"Done" withArray:listOfTaskDone];
    [self writeArrayWithCustomObjToUserDefaults:@"menna" withArray:table._ListOfTasks];
    [self.navigationController popViewControllerAnimated:YES];

    
}
- (IBAction)progressBtn:(id)sender {
    tasks.name=_labelName.text;
    tasks.desc=_labelDesc.text;
    tasks.prior=_labelPrior.selectedSegmentIndex;
    tasks.date=_labelDate.date;
    [listOfTaskProg addObject:tasks];
    [table._ListOfTasks removeObjectAtIndex:_index];
    [self writeArrayWithCustomObjToUserDefaults:@"Prog" withArray:listOfTaskProg];
    [self writeArrayWithCustomObjToUserDefaults:@"menna" withArray:table._ListOfTasks];
    [self.navigationController popViewControllerAnimated:YES];

}
- (IBAction)EditBtn:(id)sender {
    [[table._ListOfTasks objectAtIndex:_index] setName:_labelName.text];
    [[table._ListOfTasks objectAtIndex:_index] setDesc:_labelDesc.text];
    
   [[table._ListOfTasks objectAtIndex:_index] setPrior:_labelPrior.selectedSegmentIndex];
  [[table._ListOfTasks objectAtIndex:_index]setDate:_labelDate.date];

    
    [self writeArrayWithCustomObjToUserDefaults:@"menna" withArray:table._ListOfTasks];
    [self.navigationController popViewControllerAnimated:YES];
    
}
-(void)writeArrayWithCustomObjToUserDefaults:(NSString *)keyName withArray:(NSMutableArray *)myArray
{
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:myArray];
    [def setObject:data forKey:keyName];
    [def synchronize];
}

-(NSArray *)readArrayWithCustomObjFromUserDefaults:(NSString *)keyName
{
    NSData *data = [def objectForKey:keyName];
    NSArray *myArray = [NSMutableArray arrayWithArray:[NSKeyedUnarchiver unarchiveObjectWithData:data] ];
    return myArray;
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
