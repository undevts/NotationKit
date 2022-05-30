#import "include/AnyNotationKitTestsSupport.h"

#if TARGET_OS_OSX
#import <AppKit/AppKit.h>
#endif

NSDictionary<NSAttributedStringKey, id> *any_attributes() {
    NSMutableDictionary *attributes = [NSMutableDictionary dictionaryWithCapacity:5];
#if TARGET_OS_IOS
    attributes[NSForegroundColorAttributeName] = [UIColor grayColor];
    attributes[NSBackgroundColorAttributeName] = [UIColor darkTextColor];
#else
    attributes[NSForegroundColorAttributeName] = [NSColor textColor];
    attributes[NSBackgroundColorAttributeName] = [NSColor textBackgroundColor];
#endif
    attributes[NSLigatureAttributeName] = @(1);
    attributes[NSWritingDirectionAttributeName] = @[@(0), @(2)];
#if TARGET_OS_OSX
    attributes[NSAccessibilityAutocorrectedTextAttribute] = @(YES);
#endif
    return attributes;
}
