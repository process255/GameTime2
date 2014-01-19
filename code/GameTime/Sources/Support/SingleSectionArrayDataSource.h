#import <Foundation/Foundation.h>

typedef void (^ConfigureCellBlock)(id cell, id item, NSIndexPath *indexPath);

@interface SingleSectionArrayDataSource : NSObject <UITableViewDataSource>

@property (nonatomic, strong) NSArray *items;

- (id)initWithItems:(NSArray *)items
     cellIdentifier:(NSString *)identifier
 configureCellBlock:(ConfigureCellBlock)configureCellBlock
 sectionHeaderTitle:(NSString *)sectionHeaderTitle
 sectionFooterTitle:(NSString *)sectionFooterTitle;

- (id)itemAtIndexPath:(NSIndexPath *)indexPath;

@end
