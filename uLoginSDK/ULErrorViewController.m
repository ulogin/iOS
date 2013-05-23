//
//  ULErrorViewController.m
//  uLoginTestApp
//
//  Created by Alexey Talkan on 15.04.13.
//  Copyright (c) 2013 Alexey Talkan. All rights reserved.
//

#import "ULErrorViewController.h"

@interface ULErrorViewController ()

@end

@implementation ULErrorViewController

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(id)initWithErrorCode:(NSString*)thisErrCode andProvider:(id<ULProvider>)thisProvider{
	errCode = thisErrCode;
	provider = thisProvider;
	return self;
}

-(void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated{
	[super viewWillAppear:animated];
	[self reinit];
}

-(IBAction)backButtonClicked:(id)sender{
	[self.navigationController popViewControllerAnimated:YES];
}

-(void)reinit{
	imageProvider.image = [UIImage imageNamed:[provider name]];
	
	if([errCode isEqualToString:@"invalid token"]){
		labelDescription.text = [NSString stringWithFormat:NSLocalizedString(@"Не удаётся войти через %@\n.Пожалуйста, выберите другой способ входа.", nil), [provider title]];
	}
	else if([errCode isEqualToString:@"host is not"]){
		labelDescription.text = [NSString stringWithFormat:NSLocalizedString(@"Не удаётся войти через %@\nПожалуйста, выберите другой способ входа", nil), [provider title]];
	}
	else if([errCode isEqualToString:@"token expired"]){
		labelDescription.text = [NSString stringWithFormat:NSLocalizedString(@"Не удаётся войти через %@\nПожалуйста, выберите другой способ входа", nil), [provider title]];
	}
	else{
		labelDescription.text = [NSString stringWithFormat:NSLocalizedString(@"Не удаётся войти через %@\nПожалуйста, выберите другой способ входа", nil), [provider title]];
	}
}

@end
