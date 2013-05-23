//
//  ULAccountViewController.m
//  uLoginTestApp
//
//  Created by Alexey Talkan on 15.04.13.
//  Copyright (c) 2013 Alexey Talkan. All rights reserved.
//

#import "ULAccountViewController.h"
#import "UIImageView+WebCache.h"

@interface ULAccountViewController ()

@end

@implementation ULAccountViewController

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewDidLoad{
//	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginSuccess:) name:kuLoginLoginSuccess object:nil];
	
	UIScrollView* scrollView = (UIScrollView*)self.view;
	scrollView.contentSize = ((UIView*)[scrollView.subviews objectAtIndex:0]).frame.size;
	
//	buttonBack.frame = CGRectMake(20, 20, 271, 44);
//	[buttonBack addTarget:self action:@selector(backButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
	
//	UILabel *labelBackCaption = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, buttonBack.frame.size.width, buttonBack.frame.size.height)];
//	labelBackCaption.textColor = [UIColor whiteColor];
//	labelBackCaption.backgroundColor = [UIColor clearColor];
//	labelBackCaption.text = NSLocalizedString(@"Вернуться на главную", nil);
//	labelBackCaption.textAlignment = NSTextAlignmentCenter;
//	[buttonBack addSubview:labelBackCaption];
}

-(id)initWithProfile:(ULUserProfileData*)thisProfile byProvider:(id<ULProvider>)thisProvider{
	profile = thisProfile;
	provider = thisProvider;
	
	return self;
}

-(IBAction)backButtonClicked:(id)sender{
	[self.navigationController popToRootViewControllerAnimated:YES];
}

-(void)viewWillAppear:(BOOL)animated{
	[super viewWillAppear:animated];
	
	labelName.text = [NSString stringWithFormat:@"%@ %@", profile.FirstName, profile.LastName];
	labelVia.text = [NSString stringWithFormat:NSLocalizedString(@"через %@", nil), [provider name]];
	[imagePhoto setImageWithURL:[NSURL URLWithString:profile.PhotoBig]];
	
	[table reloadData];
}


#pragma mark - Table view data source

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [profile.rawData count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];
	
	if (cell == nil) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
	}
	
	cell.textLabel.text = NSLocalizedString([[profile.rawData allKeys] objectAtIndex:indexPath.row], nil);
	cell.detailTextLabel.text = [profile.rawData objectForKey:[[profile.rawData allKeys] objectAtIndex:indexPath.row]];
	
//	if(indexPath.row == 0){
//		cell.textLabel.text = NSLocalizedString(@"Имя", nil);
//		cell.detailTextLabel.text = profile.FirstName;
//	}
//	else if(indexPath.row == 1){
//		cell.textLabel.text = NSLocalizedString(@"Фамилия", nil);
//		cell.detailTextLabel.text = profile.LastName;
//	}
//	else if(indexPath.row == 2){
//		cell.textLabel.text = NSLocalizedString(@"Email", nil);
//		cell.detailTextLabel.text = profile.Email;
//	}
//	else if(indexPath.row == 3){
//		cell.textLabel.text = NSLocalizedString(@"Пол", nil);
//		cell.detailTextLabel.text = profile.Sex;
//	}
	
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
	NSString *key = [[profile.rawData allKeys] objectAtIndex:indexPath.row];
	if([key isEqualToString:@"photo_big"] || [key isEqualToString:@"profile"] || [key isEqualToString:@"identity"]){
		NSURL* url = [NSURL URLWithString:[profile.rawData objectForKey:key]];
		[[UIApplication sharedApplication] openURL:url];
	}
}

//-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
//	return buttonBack.frame.size.height + buttonBack.frame.origin.y;
//}
//-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
//	UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, buttonBack.frame.size.height + buttonBack.frame.origin.y)];
//	[view addSubview:buttonBack];
//	return view;
//}


@end
