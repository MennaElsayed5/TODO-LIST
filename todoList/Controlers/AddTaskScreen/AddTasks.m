//
//  AddTasks.m
//  todoList
//
//  Created by Menna on 05/04/2022.
//

#import "AddTasks.h"
#import "Tasks.h"
@interface AddTasks ()
@property (weak, nonatomic) IBOutlet UITextField *txtName;
@property (weak, nonatomic) IBOutlet UITextView *txtDesc;

@property (weak, nonatomic) IBOutlet UISegmentedControl *txtPriority;

@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;

@end

@implementation AddTasks
{
    Tasks *tasks;
    NSMutableArray *listOfTask;
    NSUserDefaults *def;
}

- (void)viewDidLoad {
    [super viewDidLoad];
  tasks=  [Tasks new];
    def =[NSUserDefaults standardUserDefaults];
    listOfTask=  [NSMutableArray new];
    listOfTask=[[self readArrayWithCustomObjFromUserDefaults:@"menna"]mutableCopy];
    
    
    // Do any additional setup after loading the view.
}
-(void)InformativeAlertWithmsg:(NSString *)msg
{
    UIAlertController * alertvc = [UIAlertController alertControllerWithTitle: @ "Info alert"
    message: msg preferredStyle: UIAlertControllerStyleAlert];
    UIAlertAction * action = [UIAlertAction actionWithTitle: @ "Dismiss"
    style: UIAlertActionStyleDefault handler: ^ (UIAlertAction * _Nonnull action) {
        NSLog(@ "Dismiss Tapped");
    }
                              ];
    [alertvc addAction: action];
    [self presentViewController: alertvc animated: true completion: nil];
}
- (IBAction)insert:(id)sender {
    tasks.name=_txtName.text;
    tasks.desc=_txtDesc.text;
    tasks.prior=_txtPriority.selectedSegmentIndex;
    tasks.date=_datePicker.date;
    if(![_txtName.text isEqual:@""] && ![_txtDesc.text isEqual:@""] &&  ![_datePicker.date isEqual:@""])
    {
        [listOfTask addObject:tasks];
        [self writeArrayWithCustomObjToUserDefaults:@"menna" withArray:listOfTask];
        [self.navigationController popViewControllerAnimated:YES];
    }
    else{
        [self InformativeAlertWithmsg:@"empty input"];

    }
   
    
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
