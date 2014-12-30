//
//  ViewController.m
//  Imaginarium
//
//  Created by Andrew Codispoti on 2014-12-30.
//  Copyright (c) 2014 Andrew Codispoti. All rights reserved.
//

#import "ViewController.h"
#import "ImageViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.destinationViewController isKindOfClass:[ImageViewController class]]){
        ImageViewController *ivc=(ImageViewController *)segue.destinationViewController;
        ivc.imageURL=[NSURL URLWithString:[NSString stringWithFormat:@"https://images.apple.com/v/iphone-5s/gallery/a/images/download/%@",segue.identifier]];
        ivc.imageURL=[NSURL URLWithString:[NSString stringWithFormat:@"http://imageserver.moviepilot.com/shield_logo_01-agents-of-s-h-i-e-l-d-season-2-easter-eggs-and-behind-the-scenes-moments-agents-of-s-h-i-e-l-d-how-marvel-is-working-throu.jpeg?width=1280&height=720"]];

        ivc.title=segue.identifier;
    }
}
@end
