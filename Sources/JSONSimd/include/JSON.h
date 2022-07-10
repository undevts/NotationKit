#ifndef NOTATION_KIT_JSON_H
#define NOTATION_KIT_JSON_H

#if COCOAPODS
#include <NotationKit/JSONCore.h>
#else
#include <JSONCore.h>
#endif

#if CS_LANG_CXX
#include <cstdlib>
#include <cstdint>
#include <cstdbool>
#else
#include <stdlib.h>
#include <stdint.h>
#include <stdbool.h>
#endif

#if CS_LANG_OBJC
#include <Foundation/Foundation.h>
#endif

CS_C_FILE_BEGIN

#if CS_LANG_CXX
static const inline NSInteger NK_JSON_DATA_PADDING = 32;
#else
static const NSInteger NK_JSON_DATA_PADDING = 32;
#endif

struct JSONObject {
    uint8_t data[16];
};

struct JSONObjectIterator {
    uint8_t data[16];
};

struct JSONArray {
    uint8_t data[16];
};

struct JSONArrayIterator {
    uint8_t data[16];
};

struct JSONValue {
    uint8_t data[16];
};

typedef struct NKOpaqueJSON* JSONRef;
typedef struct NKOpaqueJSONInput* JSONInputRef;

typedef struct JSONValue* JSONValueRef;
typedef struct JSONArray* JSONArrayRef;
typedef struct JSONArrayIterator* JSONArrayIteratorRef;
typedef struct JSONObject* JSONObjectRef;
typedef struct JSONObjectIterator* JSONObjectIteratorRef;

JSONInputRef json_input_create(const char* value);
JSONInputRef json_input_create_length(const char* value, size_t length);
void json_input_free(JSONInputRef CS_NULLABLE ref);

const char* json_error_message(JSONParseErrorCode code);

JSONRef json_create_null();
void json_free(JSONRef ref);
JSONRef CS_NULLABLE json_parse_string(JSONInputRef data, JSONParseErrorCode *CS_NULLABLE out);
JSONRef CS_NULLABLE json_parse_data(const uint8_t* data, size_t size, JSONParseErrorCode *CS_NULLABLE out);

JSONType json_get_type(JSONValueRef ref);
void json_get_root(JSONRef ref, JSONValueRef out);

bool json_is_null(JSONValueRef ref);
bool json_is_array(JSONValueRef ref);
bool json_is_object(JSONValueRef ref);
bool json_is_number(JSONValueRef ref);

bool json_get_bool(JSONValueRef ref, JSONParseErrorCode *CS_NULLABLE out);
NSInteger json_get_int(JSONValueRef ref, JSONParseErrorCode *CS_NULLABLE out);
int32_t json_get_int32(JSONValueRef ref, JSONParseErrorCode *CS_NULLABLE out);
int64_t json_get_int64(JSONValueRef ref, JSONParseErrorCode *CS_NULLABLE out);
NSUInteger json_get_uint(JSONValueRef ref, JSONParseErrorCode *CS_NULLABLE out);
uint32_t json_get_uint32(JSONValueRef ref, JSONParseErrorCode *CS_NULLABLE out);
uint64_t json_get_uint64(JSONValueRef ref, JSONParseErrorCode *CS_NULLABLE out);
double json_get_double(JSONValueRef ref, JSONParseErrorCode *CS_NULLABLE out);
const char* CS_NULLABLE json_get_string(JSONValueRef ref, size_t* size, JSONParseErrorCode *CS_NULLABLE out);
char* CS_NULLABLE json_get_string_copy(JSONValueRef ref, size_t* size, JSONParseErrorCode *CS_NULLABLE out);

JSONParseErrorCode json_get_array(JSONValueRef ref, JSONArrayRef out);
size_t json_array_get_count(JSONArrayRef ref);
JSONParseErrorCode json_array_get(JSONArrayRef ref, size_t index, JSONValueRef out);

void json_array_get_begin_iterator(JSONArrayRef ref, JSONArrayIteratorRef out);
void json_array_get_end_iterator(JSONArrayRef ref, JSONArrayIteratorRef out);
JSONParseErrorCode json_array_iterator_get_value(JSONArrayIteratorRef ref, JSONValueRef out);
bool json_array_iterator_is_equal(JSONArrayIteratorRef lhs, JSONArrayIteratorRef rhs);
int json_array_iterator_compare(JSONArrayIteratorRef lhs, JSONArrayIteratorRef rhs);
void json_array_iterator_move(JSONArrayIteratorRef ref, NSInteger length);
void json_array_iterator_move_next(JSONArrayIteratorRef ref);

JSONParseErrorCode json_get_object(JSONValueRef ref, JSONObjectRef out);
size_t json_object_get_count(JSONObjectRef ref);
const char* CS_NULLABLE json_object_get_key(JSONObjectRef ref, size_t index);
bool json_object_contains(JSONObjectRef ref, const char* key);
JSONParseErrorCode json_object_get(JSONObjectRef ref, const char* key, JSONValueRef out);

void json_object_get_begin_iterator(JSONObjectRef ref, JSONObjectIteratorRef out);
void json_object_get_end_iterator(JSONObjectRef ref, JSONObjectIteratorRef out);
const char* CS_NULLABLE json_object_iterator_get_key(JSONObjectIteratorRef ref, size_t* size);
JSONParseErrorCode json_object_iterator_get_value(JSONObjectIteratorRef ref, JSONValueRef out);
bool json_object_iterator_is_equal(JSONObjectIteratorRef lhs, JSONObjectIteratorRef rhs);
int json_object_iterator_compare(JSONObjectIteratorRef lhs, JSONObjectIteratorRef rhs);
void json_object_iterator_move(JSONObjectIteratorRef ref, NSInteger length);
void json_object_iterator_move_next(JSONObjectIteratorRef ref);

#if CS_LANG_OBJC
NSArray<NSString*>* json_object_get_all_keys(JSONObjectRef ref);
#endif

CS_C_FILE_END

#endif // NOTATION_KIT_JSON_H
