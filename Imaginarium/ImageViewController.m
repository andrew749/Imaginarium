//
//  ImageViewController.m
//  Imaginarium
//
//  Created by Andrew Codispoti on 2014-12-30.
//  Copyright (c) 2014 Andrew Codispoti. All rights reserved.
//

#import "ImageViewController.h"

@interface ImageViewController ()<UIScrollViewDelegate>
@property (nonatomic,strong) UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinner;
@property (nonatomic,strong)UIImage *image;
@end

@implementation ImageViewController
-(UIImageView *)imageView{
    if(!_imageView) _imageView=[[UIImageView alloc]init];
    return _imageView;
}
-(UIImage *)image{
    return self.imageView.image;
}
-(void)setImage:(UIImage *)image{
    if([self.spinner isAnimating]){
        [self.spinner stopAnimating]; 
    }
    self.imageView.image=image;
    [self.imageView sizeToFit];
}
-(void)viewDidLoad{
    [super viewDidLoad];
    [self.scrollView addSubview:self.imageView];
    self.scrollView.contentSize=self.image?self.image.size:CGSizeZero;
}
-(void)setImageURL:(NSURL *)imageURL{
    _imageURL=imageURL;
   //self.image=[UIImage imageWithData:[NSData dataWithContentsOfURL:self.imageURL]];
    [self startDownloadingImage];
}
-(void)startDownloadingImage{
    self.image=nil;
    if(self.imageURL){
        [self.spinner startAnimating];
        NSURLRequest *request=[NSURLRequest requestWithURL:self.imageURL];
        NSURLSessionConfiguration *configuration=[NSURLSessionConfiguration ephemeralSessionConfiguration];
        NSURLSession *session=[NSURLSession sessionWithConfiguration:configuration];
        NSURLSessionDownloadTask *task=[session downloadTaskWithRequest:request completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
            if(!error){
                if([request.URL isEqual:self.imageURL]){
                    UIImage *image=[UIImage imageWithData:[NSData dataWithContentsOfURL:location]];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        self.image=image;
                    });
                }
            }
        }];
        [task resume];
    }
}
-(void)setScrollView:(UIScrollView *)scrollView{
    _scrollView=scrollView;
    _scrollView.maximumZoomScale=2.0;
    _scrollView.minimumZoomScale=0.2;
    _scrollView.delegate=self;
    self.image=[UIImage imageWithData:[NSData dataWithContentsOfURL:self.imageURL]];

}
-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return self.imageView;
}
@end
