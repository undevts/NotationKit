#include "JSON.hpp"

#if CS_LANG_OBJC

using namespace simdjson;

NSArray<NSString*>* json_object_get_all_keys(JSONObjectRef ref) {
    if (UNLIKELY(ref == nullptr)) {
        return @[];
    }
    const auto& object = *unwrap(ref);
    auto size = object.size();
    if (size < 1) {
        return @[];
    }
    NSMutableArray* result = [NSMutableArray arrayWithCapacity:size];
    std::for_each(object.begin(), object.end(), [&](const dom::key_value_pair& pair) {
        const auto& key = pair.key;
        NSString* item = [[NSString alloc] initWithBytes:key.data()
                                                    length:key.size()
                                                  encoding:NSUTF8StringEncoding];
        [result addObject:item];
    });
    return result;
}

#endif // CS_LANG_OBJC
