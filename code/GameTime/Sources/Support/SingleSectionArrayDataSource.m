#import "SingleSectionArrayDataSource.h"

@interface SingleSectionArrayDataSource ()

@property (nonatomic, copy) NSString *cellIdentifier;
@property (nonatomic, copy) ConfigureCellBlock cellBlock;
@property (nonatomic, copy) NSString *sectionHeaderTitle;
@property (nonatomic, copy) NSString *sectionFooterTitle;

@end

@implementation SingleSectionArrayDataSource

- (id)initWithItems:(NSArray *)items
     cellIdentifier:(NSString *)identifier
 configureCellBlock:(ConfigureCellBlock)configureCellBlock
 sectionHeaderTitle:(NSString *)sectionHeaderTitle
 sectionFooterTitle:(NSString *)sectionFooterTitle
{
    self = [super init];
    if (self) {
        self.items = items;
        self.sectionHeaderTitle = sectionHeaderTitle;
        self.sectionFooterTitle = sectionFooterTitle;
        self.cellIdentifier = identifier;
        self.cellBlock = configureCellBlock;
    }
    
    return self;
}

- (id)itemAtIndexPath:(NSIndexPath *)indexPath
{
    return self.items[(NSUInteger) indexPath.row];
}

- (NSInteger)tableView:(UITableView*)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return self.items.count;
}

- (UITableViewCell*)tableView:(UITableView*)tableView
        cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    id cell = [tableView dequeueReusableCellWithIdentifier:self.cellIdentifier
                                              forIndexPath:indexPath];
    id item = [self itemAtIndexPath:indexPath];
    self.cellBlock(cell, item, indexPath);
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView
titleForHeaderInSection:(NSInteger)section
{
    return self.sectionHeaderTitle;
}

- (NSString *)tableView:(UITableView *)tableView
titleForFooterInSection:(NSInteger)section
{
    return self.sectionFooterTitle;
}

@end
