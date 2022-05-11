//
//  ProgressDetailsViewController.m
//  todoList
//
//  Created by Menna on 06/04/2022.
//

#import "ProgressDetailsViewController.h"
#import "DoneTableViewController.h"
@interface ProgressDetailsViewController ()
@property (weak, nonatomic) IBOutlet UITextField *txtNAme;
@property (weak, nonatomic) IBOutlet UITextView *txtDesc;

@property (weak, nonatomic) IBOutlet UISegmentedControl *txtPrior;
@property (weak, nonatomic) IBOutlet UIDatePicker *txtDate;

@end

@implementation ProgressDetailsViewController
{
    Tasks *tasks;
     
    NSMutableArray *listOfTaskDone;
    NSMutableArray *listOfTaskProg;
    NSUserDefaults *def;
    NSUserDefaults *defDone;
    NSUserDefaults *defProg;
   // TableViewController *table;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    tasks=  [Tasks new];

    _txtNAme.text=_task.name;
    _txtDesc.text=_task.desc;
    _txtPrior.selectedSegmentIndex=_task.prior;
    _txtDate.date=_task.date;
    
    def =[NSUserDefaults standardUserDefaults];
    defDone =[NSUserDefaults standardUserDefaults];
    defProg=[NSUserDefaults standardUserDefaults];
    
    listOfTaskDone =[NSMutableArray new];
    
    listOfTaskProg=[NSMutableArray new];
    
    listOfTaskDone=[[self readArrayWithCustomObjFromUserDefaults:@"Done"]mutableCopy ];
    listOfTaskProg=[[self readArrayWithCustomObjFromUserDefaults:@"Prog"]mutableCopy ];
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

- (IBAction)btnDone:(id)sender {
    tasks.name=_txtNAme.text;
    tasks.desc=_txtDesc.text;
    tasks.prior=_txtPrior.selectedSegmentIndex;
    tasks.date=_txtDate.date;
   
    [listOfTaskDone addObject:tasks];
    [listOfTaskProg removeObjectAtIndex:_index];
    [self writeArrayWithCustomObjToUserDefaults:@"Done" withArray:listOfTaskDone];
    [self writeArrayWithCustomObjToUserDefaults:@"Prog" withArray:listOfTaskProg];
    [self.navigationController popViewControllerAnimated:YES];

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
