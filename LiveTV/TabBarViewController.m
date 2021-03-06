//
//  TabBarViewController.m
//  LiveTV
//
//  Created by Charlies Wang on 15/12/19.
//  Copyright © 2015年 Charlies Wang. All rights reserved.
//

#import "TabBarViewController.h"
#import "TVListViewController.h"
#import "FilmViewController.h"
#import "SearchViewController.h"
#import "SeriesViewController.h"
#import "VarietyViewController.h"
#import "JTHamburgerButton.h"
#import "MLKMenuPopover.h"
#import "AboutViewController.h"

@interface TabBarViewController () <MLKMenuPopoverDelegate>

@property(nonatomic,strong) MLKMenuPopover *menuPopover;
@property(nonatomic,strong) NSArray *menuItems;

@end

@implementation TabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.menuItems = [NSArray arrayWithObjects:@"关于", nil];
    // Do any additional setup after loading the view.
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    
    UIView *customView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 44, 44 * self.menuItems.count)];
    JTHamburgerButton *jtBtn = [[JTHamburgerButton alloc] initWithFrame:customView.bounds];
    [[jtBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        // Hide already showing popover
        [self.menuPopover dismissMenuPopover];
        self.menuPopover = [[MLKMenuPopover alloc] initWithFrame:CGRectMake(20, 0, 66, 44) menuItems:self.menuItems];
        self.menuPopover.menuPopoverDelegate = self;
        [self.menuPopover showInView:self.view];
    }];
    [customView addSubview:jtBtn];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:customView];
    
    TVListViewController *viewController = [[TVListViewController alloc] initWithTitle:@"电视" image:[UIImage imageNamed:@"tv_nor"] selectedImage:[UIImage imageNamed:@"tv"]];
    
    FilmViewController *filmViewController = [[FilmViewController alloc] initWithTitle:@"电影" image:[UIImage imageNamed:@"movie_nor"] selectedImage:[UIImage imageNamed:@"movie"]];
    
    SeriesViewController *seriesViewController = [[SeriesViewController alloc] initWithTitle:@"电视剧" image:[UIImage imageNamed:@"series_nor"] selectedImage:[UIImage imageNamed:@"series"]];
    
    VarietyViewController *varietyViewController = [[VarietyViewController alloc] initWithTitle:@"综艺" image:[UIImage imageNamed:@"art_nor"] selectedImage:[UIImage imageNamed:@"art"]];
    
    SearchViewController * searchViewController = [[SearchViewController alloc] initWithTitle:@"发现" image:[UIImage imageNamed:@"search_nor"] selectedImage:[UIImage imageNamed:@"search"]];
    
    self.viewControllers = @[viewController, filmViewController, seriesViewController, varietyViewController, searchViewController];
}

- (void)menuPopover:(MLKMenuPopover *)menuPopover didSelectMenuItemAtIndex:(NSInteger)selectedIndex
{
    [self.menuPopover dismissMenuPopover];
    if (selectedIndex == 0) {
        AboutViewController *aboutViewController = [[AboutViewController alloc] init];
        [self.navigationController pushViewController:aboutViewController animated:YES];
    }
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
