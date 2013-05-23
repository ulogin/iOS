//
//  ULLoginViewController.h
//  uLoginTestApp
//
//  Created by Alexey Talkan on 10.04.13.
//  Copyright (c) 2013 Alexey Talkan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "uLogin.h"

@interface ULLoginViewController : UIViewController {
	IBOutlet UIButton *buttonPoweredBy;
}

@end

@interface ULMyConfigurator : ULDefaultConfigurator {
	id<ULProvider> provider;
}

-(id)initWithSingleProvider:(id<ULProvider>)thisProvider;

@end

