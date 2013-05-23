//
//  ULProvidersViewController.m
//
//  Created by Alexey Talkan on 10.04.13.
//  Copyright (c) 2013 Alexey Talkan. All rights reserved.
//

#import "ULProvidersViewController.h"
#import "ULProvider.h"

@interface ULProvidersViewController ()

@end

@implementation ULProvidersViewController

@synthesize config;

-(IBAction)backButtonClick:(id)sender{
	[self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)uLoginButtonClicked:(id)sender{
	[self.navigationController pushViewController:infoView animated:YES];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return config.providers.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];

	if (cell == nil) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
	}
		
	cell.textLabel.text = ((id<ULProvider>)[config.providers objectAtIndex:indexPath.row]).title;
	cell.imageView.image = [UIImage imageNamed:((id<ULProvider>)[config.providers objectAtIndex:indexPath.row]).name];

    return cell;
}



#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ULWebViewController *webViewController = [[[ULWebViewController alloc] initWithNibName:@"ULWebViewController" bundle:nil] initWithProvider:((id<ULProvider>)[config.providers objectAtIndex:indexPath.row]) andConfigurator:config];
	[self.navigationController pushViewController:webViewController animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
	return 30;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
	UIView *footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 30)];
	footer.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
	
	UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
	[button addTarget:self action:@selector(uLoginButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
	button.frame = CGRectMake(320 - 90 - [self groupedCellMarginWithTableWidth:tableView.frame.size.width], 0, 90, 30);
	button.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
	[button setTitle:@"powered by uLogin" forState:UIControlStateNormal];
	[button setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
	button.titleLabel.font = [UIFont systemFontOfSize:10];
	
	[footer addSubview:button];
	return footer;
}


- (float) groupedCellMarginWithTableWidth:(float)tableViewWidth {
	
    float marginWidth;
    if(tableViewWidth > 20)
    {
        if(tableViewWidth < 600)
        {
            marginWidth = 10;
        }
        else
        {
            marginWidth = MAX(31, MIN(45, tableViewWidth*0.06));
        }
    }
    else
    {
        marginWidth = tableViewWidth - 10;
    }
	NSLog(@"%f, %f", tableViewWidth, marginWidth);
    return marginWidth;
}


@end



@implementation ULInfoViewController


-(void)viewDidLoad{
	scrollView.contentSize = ((UIView*)[scrollView.subviews objectAtIndex:0]).frame.size;
}

-(void)viewDidAppear:(BOOL)animated{
	[super viewDidAppear:animated];
}

-(IBAction)backButtonClick:(id)sender{
	[self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - Table view data source

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return section == 0 ? 2 : 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];
	
	if (cell == nil) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];

//		cell.textLabel.frame = CGRectMake(cell.textLabel.frame.origin.x, cell.textLabel.frame.origin.y, cell.textLabel.frame.size.width + 130, cell.textLabel.frame.size.height);
//		cell.detailTextLabel.frame = CGRectMake(cell.detailTextLabel.frame.origin.x + 130, cell.detailTextLabel.frame.origin.y, cell.detailTextLabel.frame.size.width - 130, cell.detailTextLabel.frame.size.height);
	}
	
	if(indexPath.section == 0 && indexPath.row == 0){
		cell.textLabel.text = NSLocalizedString(@"сайт проекта", nil);
		cell.detailTextLabel.text = NSLocalizedString(@"ulogin.ru", nil);
	}
	else if(indexPath.section == 0 && indexPath.row == 1){
		cell.textLabel.text = NSLocalizedString(@"поддержка", nil);
		cell.detailTextLabel.text = NSLocalizedString(@"team@ulogin.ru", nil);
	}
	else if(indexPath.section == 1 && indexPath.row == 0){
		cell.textLabel.text = NSLocalizedString(@"SDK for iOs", nil);
		cell.detailTextLabel.text = NSLocalizedString(@"ulogin.ru/mobile/ios", nil);
	}

    return cell;
}


#pragma mark - Table view delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	if(indexPath.section == 0 && indexPath.row == 0){
		[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://ulogin.ru"]];
	}
	else if(indexPath.section == 0 && indexPath.row == 1){
		[[UIApplication sharedApplication] openURL:[NSURL URLWithString:[@"mailto:team@ulogin.ru" stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
	}
	else if(indexPath.section == 1 && indexPath.row == 0){
		[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://ulogin.ru/mobile/ios"]];
	}
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
	return section == 0 ? 0 : 30;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
	if(section == 0){
		return nil;
	}
	UIView *footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 30)];
	
	UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
	button.frame = CGRectMake(20, 0, 220, 30);
	button.backgroundColor = [UIColor clearColor];
	[button setTitle:NSLocalizedString(@"Разработчикам приложений", nil) forState:UIControlStateNormal];
	[button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
	button.titleLabel.font = [UIFont boldSystemFontOfSize:15];
	button.titleLabel.textAlignment = NSTextAlignmentLeft;
//	button.titleLabel.shadowColor = [UIColor colorWithRed:213.0/255.0 green:213.0/255.0 blue:213.0/255.0 alpha:0.42];
//	button.titleLabel.shadowOffset = CGSizeMake(0, 1);
	
	[footer addSubview:button];
	return footer;
}

@end