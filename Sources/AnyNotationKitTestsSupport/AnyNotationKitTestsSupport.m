// MIT License
//
// Copyright (c) 2022 Notation Kit Project Authors
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

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
