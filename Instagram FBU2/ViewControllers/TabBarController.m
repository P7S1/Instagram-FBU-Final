//
//  TabBarViewController.m
//  Instagram FBU
//
//  Created by Keng Fontem on 7/6/21.
//

#import "TabBarController.h"
#import "EditPostViewController.h"
@interface TabBarController ()<UITabBarControllerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@end

@implementation TabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.delegate = self;
}


- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
    
    if ([viewController isKindOfClass:[EditPostViewController class]]){
        UIImagePickerController* pickerController = [[UIImagePickerController alloc]init];
        pickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        pickerController.delegate = self;
        [self presentViewController:pickerController animated:YES completion:nil];
        return NO;
    }
    
    return YES;
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info{
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    
    if (image == nil) { return; }
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    EditPostViewController* vc = [storyboard instantiateViewControllerWithIdentifier:@"EditPostViewController"];
    vc.image = image;
    
    UINavigationController* presentedVC = self.viewControllers[self.selectedIndex];
    [presentedVC pushViewController:vc animated:YES];
    
    
    
}



@end
