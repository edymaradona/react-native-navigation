#import "RNNSplitViewOptions.h"
#import "RNNParentProtocol.h"

@implementation RNNSplitViewOptions

- (instancetype)initWithDict:(NSDictionary *)dict {
	self = [super init];
	
	self.displayMode = dict[@"displayMode"];
	self.primaryEdge = dict[@"primaryEdge"];
	NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
	f.numberStyle = NSNumberFormatterDecimalStyle;
	self.minWidth = [f numberFromString:dict[@"minWidth"]];
	self.maxWidth = [f numberFromString:dict[@"maxWidth"]];
	
	return self;	
}

-(void)applyOn:(UIViewController<RNNParentProtocol> *)viewController {
	
	UISplitViewController *svc = (UISplitViewController*) viewController;

	if (@available(iOS 11.0, *)) {
		if ([self.primaryEdge isEqualToString:@"trailing"]) {
			[svc setPrimaryEdge:UISplitViewControllerPrimaryEdgeTrailing];
		} else {
			[svc setPrimaryEdge:UISplitViewControllerPrimaryEdgeLeading];
		}
	}
	
	if ([self.displayMode isEqualToString:@"visible"]) {
		[svc setPreferredDisplayMode:UISplitViewControllerDisplayModeAllVisible];
	} else if ([self.displayMode isEqualToString:@"hidden"]) {
		[svc setPreferredDisplayMode:UISplitViewControllerDisplayModePrimaryHidden];
	} else if ([self.displayMode isEqualToString:@"overlay"]) {
		[svc setPreferredDisplayMode:UISplitViewControllerDisplayModePrimaryOverlay];
	} else {
		[svc setPreferredDisplayMode:UISplitViewControllerDisplayModeAutomatic];
	}

	if (self.minWidth) {
		[svc setMinimumPrimaryColumnWidth:[self.minWidth doubleValue]];
	}

	if (self.maxWidth) {
		[svc setMaximumPrimaryColumnWidth:[self.maxWidth doubleValue]];
	}
}

@end
