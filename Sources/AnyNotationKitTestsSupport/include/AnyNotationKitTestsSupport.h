#include <Foundation/Foundation.h>

#if TARGET_OS_IOS
#include <UIKit/UIKit.h>
#endif

#if TARGET_OS_IOS
NSDictionary<UIApplicationLaunchOptionsKey, id> *_Nonnull any_launchOptions();
#endif

NSDictionary<NSAttributedStringKey, id> *_Nonnull any_attributes();
