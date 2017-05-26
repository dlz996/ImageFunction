//
//  PhotographController.m
//  ImageModule
//
//  Created by 董立峥 on 2017/5/24.
//  Copyright © 2017年 芦苇科技. All rights reserved.
//

#import "PhotographController.h"
#import <AVFoundation/AVFoundation.h>
@interface PhotographController ()<TZImagePickerControllerDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIAlertViewDelegate>
@property (nonatomic,strong)UIImageView * imageView;
@end

@implementation PhotographController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"拍照";
    self.view.backgroundColor = White_Color;
    /** 调用系统相机 */
    UIImagePickerController *CameraPicker = [[UIImagePickerController alloc] init];
    CameraPicker.delegate = self;
    CameraPicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    [self presentViewController:CameraPicker animated:YES completion:nil];
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if(authStatus == AVAuthorizationStatusRestricted || authStatus ==AVAuthorizationStatusDenied){
        //无权限
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"请在iPhone的“设置-隐私”选项中，允许财富驴访问你的摄像头" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        alertView.tag = 1;
        [alertView show];
        return;
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    if (!image) {
        return;
    }
    
    self.imageView.image = image;

    [picker dismissViewControllerAnimated:YES completion:^{}];
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:^{}];
}

- (UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc]initWithImage:nil];
        _imageView.frame = CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64);
        [self.view addSubview:_imageView];
    }
    return _imageView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
