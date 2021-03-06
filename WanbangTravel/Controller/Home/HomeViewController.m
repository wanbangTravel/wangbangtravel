//
//  HomeViewController.m
//  WanBangTravel
//
//  Created by 沈凡 on 16/4/7.
//  Copyright © 2016年 mmt&sf. All rights reserved.
//

#import "HomeViewController.h"

#define UISCREENHEIGHT  self.view.frame.size.height
#define UISCREENWIDTH  self.view.frame.size.width

@interface HomeViewController () <UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate> {
    UIScreen *mainScreen;
    UIScrollView *_scrollView;
}

@property (strong, nonatomic) IBOutlet UITableView *homeTableView;
@property (strong, nonatomic)  NSArray<HomeTableViewCell *> *homeTableViewCells;

@end

@implementation HomeViewController

- (instancetype)init {
    
    if (self = [super init]) {
//        self.tabBarItem.selectedImage = [[UIImage imageNamed:@"门票"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    return self;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    UIButton *leftBarBtn = [[UIButton alloc] init];
    leftBarBtn.frame = CGRectMake(20, 5, 50, 20);
    leftBarBtn.backgroundColor = [UIColor redColor];
    [leftBarBtn setTitle:@"南京" forState:UIControlStateNormal];
    [leftBarBtn addTarget:self action:@selector(chooseLocation) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftBarBtn];
    
    UIButton *telephoneBtn = [[UIButton alloc] initWithFrame:CGRectMake(150, 7, 50, 30)];
    [telephoneBtn setTitle:@"电话" forState:UIControlStateNormal];
    [telephoneBtn setBackgroundColor:[UIColor greenColor]];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:telephoneBtn];
    
    mainScreen = [UIScreen mainScreen];
    
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 150, 30)];
    searchBar.backgroundColor = [UIColor clearColor];
    //去除搜索框的背景，不然会有灰色背景 (未在iOS其他版本中测试过 iOS9中可行)
    for (UIView *subView in [[searchBar.subviews objectAtIndex:0] subviews]) {
        if ([subView isKindOfClass:NSClassFromString(@"UISearchBarBackground")]) {
            [subView removeFromSuperview];
        }
    }
    [searchBar setPlaceholder:@"请输入搜索内容"];
    searchBar.delegate = self;
    UIView *searchView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 150, 30)];
    //searchView addGestureRecognizer:[UIGestureRecognizer al]
    [searchView addSubview:searchBar];
    [self.navigationItem setTitleView:searchView];
    
    //创建顶部视图
    self.tableView.tableHeaderView = [HeaderView generateHeaderView];
    
}

- (void)chooseLocation{
    LocationViewController *vc = [[LocationViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //1,创建可重用的自定义cell
    HomeTableViewCell *cell = [HomeTableViewCell homeCellWithTableView:tableView];
    //2,设置控件的值
    //MicroBlogFrame *frame = self.microBlogFrames[indexPath.row];
    //cell.microBlog = microBlog;
    //cell.microBlogFrame = frame;
    //3,返回
    return cell;
}

#pragma mark - Table view delegate methods

//选中跳转到WebView
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    WebViewController *vc = [[WebViewController alloc] init];
    [vc setUrl:@"http://www.baidu.com"];
    [self.navigationController pushViewController:vc animated:YES];
}

//取消选中
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

//单元格行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 160;
}

#pragma mark - UISearch bar delegate methods
-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    [self resignFirstResponder];
    SearchViewController *vc = [[SearchViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}


@end
