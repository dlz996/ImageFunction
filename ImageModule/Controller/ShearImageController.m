//
//  ShearImageController.m
//  ImageModule
//
//  Created by 董立峥 on 2017/5/24.
//  Copyright © 2017年 芦苇科技. All rights reserved.
//

#import "ShearImageController.h"
#import "LECropPictureViewController.h"

@interface ShearImageController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (nonatomic,strong)UIImageView * imageView;

@end

@implementation ShearImageController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"剪切照片";
    self.view.backgroundColor = White_Color;

    UIImagePickerController *imagePicker = [UIImagePickerController new];
    imagePicker.delegate = self;
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    } else {
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    
    [self presentViewController:imagePicker animated:YES completion:nil];
}
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    [self dismissViewControllerAnimated:NO completion:nil];
    if (!image) {
        return;
    }
    int type = arc4random()%2;
    LECropPictureViewController *cropPictureController = [[LECropPictureViewController alloc] initWithImage:image andCropPictureType:type==0?LECropPictureTypeRounded:LECropPictureTypeRect];
    cropPictureController.cropFrame = CGRectMake(50, 50, 250, 250);
    cropPictureController.borderColor = [UIColor grayColor];
    cropPictureController.borderWidth = 1.0;
    
    cropPictureController.imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    cropPictureController.photoAcceptedBlock = ^(UIImage *croppedPicture){
        self.imageView.image = croppedPicture;
    };
    
    [self presentViewController:cropPictureController animated:NO completion:nil];
}

- (UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc]initWithImage:nil];
        _imageView.frame = CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64);
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
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
