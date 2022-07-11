#include <JSON.h>
#include "simdjson.h"
#include "JSON.hpp"

using namespace simdjson;

static_assert(sizeof(dom::array) == sizeof(json_array));
static_assert(sizeof(dom::array::iterator) == sizeof(json_array_iterator));
static_assert(sizeof(dom::object) == sizeof(json_object));
static_assert(sizeof(dom::object::iterator) == sizeof(json_object_iterator));
static_assert(sizeof(dom::element) == sizeof(json_value));

template<typename T, std::enable_if_t<std::is_same_v<T, bool>, bool> = true>
static inline JSONParseErrorCode json_get_number(const dom::element& value, T& out) {
    auto code = value.get_bool().get(out);
    return static_cast<JSONParseErrorCode>(code);
}

template<typename T, std::enable_if_t<std::is_same_v<T, int64_t>, bool> = true>
static inline JSONParseErrorCode json_get_number(const dom::element& value, T& out) {
    auto code = value.get_int64().get(out);
    return static_cast<JSONParseErrorCode>(code);
}

template<typename T, std::enable_if_t<std::is_same_v<T, uint64_t>, bool> = true>
static inline JSONParseErrorCode json_get_number(const dom::element& value, T& out) {
    auto code = value.get_uint64().get(out);
    return static_cast<JSONParseErrorCode>(code);
}

template<typename T, std::enable_if_t<std::is_same_v<T, double>, bool> = true>
static inline JSONParseErrorCode json_get_number(const dom::element& value, T& out) {
    auto code = value.get_double().get(out);
    return static_cast<JSONParseErrorCode>(code);
}

template<typename from_t, typename to_t, std::enable_if_t<std::is_same_v<to_t, double>, bool> = true>
static inline JSONParseErrorCode value_as(const from_t& value, to_t& out) {
    out = static_cast<double>(value);
    return JSONParseErrorCodeSuccess;
}

template<typename from_t, typename to_t, std::enable_if_t<
    std::is_same_v<to_t, from_t> && !std::is_same_v<to_t, double>, bool> = true>
static inline JSONParseErrorCode value_as(const from_t& value, to_t& out) {
    out = value;
    return JSONParseErrorCodeSuccess;
}

template<typename from_t, typename to_t, std::enable_if_t<
    !std::is_same_v<to_t, from_t> && !std::is_same_v<to_t, double>, bool> = true>
static inline JSONParseErrorCode value_as(const from_t& value, to_t& out) {
    auto signedFrom = std::numeric_limits<from_t>::is_signed;
    if (signedFrom && !std::numeric_limits<to_t>::is_signed && value < 0) {
        return JSONParseErrorCodeNumberOutOfRange;
    }
    if (value > static_cast<to_t>(std::numeric_limits<to_t>::max())) {
        return JSONParseErrorCodeNumberOutOfRange;
    }
    if (signedFrom && value < static_cast<to_t>(std::numeric_limits<to_t>::min())) {
        return JSONParseErrorCodeNumberOutOfRange;
    }
    out = static_cast<to_t>(value);
    return JSONParseErrorCodeSuccess;
}

template<typename T>
static inline JSONParseErrorCode json_as_number(const dom::element& value, T& out) {
    if (LIKELY(value.is_number())) {
        if (value.is_uint64()) {
            uint64_t u = 0;
            auto code = json_get_number(value, u);
            if (code != JSONParseErrorCodeSuccess) {
                return code;
            }
            return value_as<uint64_t, T>(u, out);
        } else if (value.is_int64()) {
            int64_t u = 0;
            auto code = json_get_number(value, u);
            if (code != JSONParseErrorCodeSuccess) {
                return code;
            }
            return value_as<int64_t, T>(u, out);
        } else if (value.is_double()) {
            double u = 0;
            auto code = json_get_number(value, u);
            if (code != JSONParseErrorCodeSuccess) {
                return code;
            }
            return value_as<double, T>(u, out);
        } else if (value.is_bool()) {
            auto flag = false;
            auto code = value.get_bool().get(flag);
            if (code == error_code::SUCCESS) {
                out = static_cast<T>(flag ? 0 : 1);
            }
            return static_cast<JSONParseErrorCode>(code);
        }
    }
    return JSONParseErrorCodeIncorrectType;
}

template<typename T>
static inline T json_get(JSONValueRef ref, JSONParseErrorCode *CS_NULLABLE out) {
    if (UNLIKELY(ref == nullptr)) {
        return JSONParseErrorCodeUninitialized;
    }
    T result{};
    auto code = json_as_number(*unwrap(ref), result);
    if (out != nullptr) {
        *out = static_cast<JSONParseErrorCode>(code);
    }
    return result;
}

JSONInputRef json_input_create(const char* value) {
    auto result = new padded_string;
    ""_padded;
    *result = padded_string(value, strnlen(value, std::numeric_limits<std::size_t>::max()));
    return wrap(result);
}

JSONInputRef json_input_create_length(const char* value, size_t length) {
    auto result = new padded_string;
    *result = padded_string(value, length);
    return wrap(result);
}

void json_input_free(JSONInputRef CS_NULLABLE ref) {
    delete unwrap(ref);
}

const char* json_error_message(JSONParseErrorCode code) {
    return error_message(static_cast<error_code>(code));
}

JSONRef json_create_null() {
    auto document = new dom::document;
    auto json = "null"_padded;
    dom::parser parser;
    parser.parse_into_document(*document, json);
    return wrap(document);
}

void json_free(JSONRef ref) {
    delete unwrap(ref);
}

JSONRef CS_NULLABLE json_parse_string(JSONInputRef data, JSONParseErrorCode *CS_NULLABLE out) {
    if (UNLIKELY(data == nullptr)) {
        return nullptr;
    }
    dom::parser parser;
    auto document = new dom::document;
    auto code = parser.parse_into_document(*document, *unwrap(data))
        .error();
    if (out != nullptr) {
        *out = static_cast<JSONParseErrorCode>(code);
    }
    return wrap(document);
}

JSONRef CS_NULLABLE json_parse_data(const uint8_t* data, size_t size, JSONParseErrorCode *CS_NULLABLE out) {
    if (UNLIKELY(data == nullptr || out == nullptr)) {
        return nullptr;
    }
    dom::parser parser;
    auto document = new dom::document;
    auto code = parser.parse_into_document(*document, data, size, false)
        .error();
    if (out != nullptr) {
        *out = static_cast<JSONParseErrorCode>(code);
    }
    return wrap(document);
}

JSONType json_get_type(JSONValueRef ref) {
    if (UNLIKELY(ref == nullptr)) {
        return JSONTypeNull;
    }
    return static_cast<JSONType>(unwrap(ref)->type());
}

void json_get_root(JSONRef ref, JSONValueRef out) {
    if (UNLIKELY(ref == nullptr || out == nullptr)) {
        return;
    }
    auto& root = *unwrap(out);
    root = unwrap(ref)->root();
}

bool json_is_null(JSONValueRef ref) {
    if (UNLIKELY(ref == nullptr)) {
        return false;
    }
    return unwrap(ref)->is_null();
}

bool json_is_array(JSONValueRef ref) {
    if (UNLIKELY(ref == nullptr)) {
        return false;
    }
    return unwrap(ref)->is_array();
}

bool json_is_object(JSONValueRef ref) {
    if (UNLIKELY(ref == nullptr)) {
        return false;
    }
    return unwrap(ref)->is_object();
}

bool json_is_number(JSONValueRef ref) {
    if (UNLIKELY(ref == nullptr)) {
        return false;
    }
    return unwrap(ref)->is_number();
}

bool json_get_bool(JSONValueRef ref, JSONParseErrorCode *CS_NULLABLE out) {
    if (UNLIKELY(ref == nullptr)) {
        return JSONParseErrorCodeUninitialized;
    }
    bool result = false;
    auto code = unwrap(ref)->get_bool().get(result);
    if (out != nullptr) {
        *out = static_cast<JSONParseErrorCode>(code);
    }
    return result;
}

NSInteger json_get_int(JSONValueRef ref, JSONParseErrorCode *CS_NULLABLE out) {
#if __LP64__
    return json_get_int64(ref, out);
#else
    return json_get_int32(ref, out);
#endif
}

int32_t json_get_int32(JSONValueRef ref, JSONParseErrorCode *CS_NULLABLE out) {
    return json_get<int32_t>(ref, out);
}

int64_t json_get_int64(JSONValueRef ref, JSONParseErrorCode *CS_NULLABLE out) {
    return json_get<int64_t>(ref, out);
}

NSUInteger json_get_uint(JSONValueRef ref, JSONParseErrorCode *CS_NULLABLE out) {
#if __LP64__
    return json_get<uint64_t>(ref, out);
#else
    return json_get<uint32_t>(ref, out);
#endif
}

uint32_t json_get_uint32(JSONValueRef ref, JSONParseErrorCode *CS_NULLABLE out) {
    return json_get<uint32_t>(ref, out);
}

uint64_t json_get_uint64(JSONValueRef ref, JSONParseErrorCode *CS_NULLABLE out) {
    return json_get<uint64_t>(ref, out);
}

double json_get_double(JSONValueRef ref, JSONParseErrorCode *CS_NULLABLE out) {
    return json_get<double>(ref, out);
}

const char* CS_NULLABLE json_get_string(JSONValueRef ref, size_t* size, JSONParseErrorCode *CS_NULLABLE out) {
    if (UNLIKELY(ref == nullptr)) {
        return nullptr;
    }
    std::string_view value;
    auto code = unwrap(ref)->get_string().get(value);
    if (out != nullptr) {
        *out = static_cast<JSONParseErrorCode>(code);
    }
    if (code != error_code::SUCCESS) {
        return nullptr;
    }
    *size = value.length();
    return value.data();
}

char* CS_NULLABLE json_get_string_copy(JSONValueRef ref, size_t* size, JSONParseErrorCode *CS_NULLABLE out) {
    if (UNLIKELY(ref == nullptr)) {
        return nullptr;
    }
    std::string_view value;
    auto code = unwrap(ref)->get_string().get(value);
    if (out != nullptr) {
        *out = static_cast<JSONParseErrorCode>(code);
    }
    if (code != error_code::SUCCESS) {
        return nullptr;
    }
    *size = value.length();
    auto result = static_cast<char*>(malloc((*size + 1) * sizeof(char)));
    strncpy(result, value.data(), *size);
    return result;
}

JSONParseErrorCode json_get_array(JSONValueRef ref, JSONArrayRef out) {
    if (UNLIKELY(ref == nullptr || out == nullptr)) {
        return JSONParseErrorCodeUninitialized;
    }
    auto array = unwrap(out);
    auto code = unwrap(ref)->get_array().get(*array);
    return static_cast<JSONParseErrorCode>(code);
}

size_t json_array_get_count(JSONArrayRef ref) {
    if (UNLIKELY(ref == nullptr)) {
        return JSONParseErrorCodeUninitialized;
    }
    return unwrap(ref)->size();
}

JSONParseErrorCode json_array_get(JSONArrayRef ref, size_t index, JSONValueRef out) {
    if (UNLIKELY(ref == nullptr || out == nullptr)) {
        return JSONParseErrorCodeUninitialized;
    }
    auto value = unwrap(out);
    auto code = unwrap(ref)->at(index).get(*value);
    return static_cast<JSONParseErrorCode>(code);
}

void json_array_get_begin_iterator(JSONArrayRef ref, JSONArrayIteratorRef out) {
    if (UNLIKELY(ref == nullptr || out == nullptr)) {
        return;
    }
    auto result = unwrap(out);
    *result = unwrap(ref)->begin();
}

void json_array_get_end_iterator(JSONArrayRef ref, JSONArrayIteratorRef out) {
    if (UNLIKELY(ref == nullptr || out == nullptr)) {
        return;
    }
    auto result = unwrap(out);
    *result = unwrap(ref)->end();
}

JSONParseErrorCode json_array_iterator_get_value(JSONArrayIteratorRef ref, JSONValueRef out) {
    if (UNLIKELY(ref == nullptr || out == nullptr)) {
        return JSONParseErrorCodeUninitialized;
    }
    auto value = unwrap(out);
    const auto& elements = unwrap(ref)->operator*();
    *value = elements;
    return JSONParseErrorCodeSuccess;
}

bool json_array_iterator_is_equal(JSONArrayIteratorRef lhs, JSONArrayIteratorRef rhs) {
    if (UNLIKELY(lhs == nullptr || rhs == nullptr)) {
        return false;
    }
    return unwrap(lhs)->operator==(*unwrap(rhs));
}

int json_array_iterator_compare(JSONArrayIteratorRef lhs, JSONArrayIteratorRef rhs) {
    if (UNLIKELY(lhs == nullptr || rhs == nullptr)) {
        return false;
    }
    const auto& _lhs = unwrap(lhs);
    const auto& _rhs = unwrap(rhs);
    if (_lhs == _rhs) {
        return 0;
    }
    return _lhs > _rhs ? 1 : -1;
}

void json_array_iterator_move(JSONArrayIteratorRef ref, NSInteger length) {
    if (UNLIKELY(ref == nullptr)) {
        return;
    }
    unwrap(ref)->operator++(static_cast<int>(length));
}

void json_array_iterator_move_next(JSONArrayIteratorRef ref) {
    if (UNLIKELY(ref == nullptr)) {
        return;
    }
    unwrap(ref)->operator++();
}

JSONParseErrorCode json_get_object(JSONValueRef ref, JSONObjectRef out) {
    if (UNLIKELY(ref == nullptr || out == nullptr)) {
        return JSONParseErrorCodeUninitialized;
    }
    auto object = unwrap(out);
    auto code = unwrap(ref)->get_object().get(*object);
    return static_cast<JSONParseErrorCode>(code);
}

size_t json_object_get_count(JSONObjectRef ref) {
    if (UNLIKELY(ref == nullptr)) {
        return JSONParseErrorCodeUninitialized;
    }
    return unwrap(ref)->size();
}

const char* json_object_get_key(JSONObjectRef ref, size_t index) {
    if (UNLIKELY(ref == nullptr)) {
        return nullptr;
    }
    auto begin = unwrap(ref)->begin();
    const auto& end = unwrap(ref)->end();
    begin.operator++(static_cast<int>(index));
    if (begin < end) {
        return begin.key().data();
    }
    return nullptr;
}

bool json_object_contains(JSONObjectRef ref, const char* key) {
    if (UNLIKELY(ref == nullptr)) {
        return JSONParseErrorCodeUninitialized;
    }
    auto code = unwrap(ref)->at_key({key}).error();
    return code == error_code::SUCCESS;
}

JSONParseErrorCode json_object_get(JSONObjectRef ref, const char* key, JSONValueRef out) {
    if (UNLIKELY(ref == nullptr)) {
        return JSONParseErrorCodeUninitialized;
    }
    auto value = unwrap(out);
    auto code = unwrap(ref)->at_key({key}).get(*value);
    return static_cast<JSONParseErrorCode>(code);
}

void json_object_get_begin_iterator(JSONObjectRef ref, JSONObjectIteratorRef out) {
    if (UNLIKELY(ref == nullptr || out == nullptr)) {
        return;
    }
    auto result = unwrap(out);
    *result = unwrap(ref)->begin();
}

void json_object_get_end_iterator(JSONObjectRef ref, JSONObjectIteratorRef out) {
    if (UNLIKELY(ref == nullptr || out == nullptr)) {
        return;
    }
    auto result = unwrap(out);
    *result = unwrap(ref)->end();
}

const char* CS_NULLABLE json_object_iterator_get_key(JSONObjectIteratorRef ref, size_t* size) {
    if (UNLIKELY(ref == nullptr)) {
        return nullptr;
    }
    const auto& key = unwrap(ref)->key();
    *size = key.length();
    return key.data();
}

JSONParseErrorCode json_object_iterator_get_value(JSONObjectIteratorRef ref, JSONValueRef out) {
    if (UNLIKELY(ref == nullptr)) {
        return JSONParseErrorCodeUninitialized;
    }
    auto value = unwrap(out);
    auto code = unwrap(ref)->value().get(*value);
    return static_cast<JSONParseErrorCode>(code);
}

bool json_object_iterator_is_equal(JSONObjectIteratorRef lhs, JSONObjectIteratorRef rhs) {
    if (UNLIKELY(lhs == nullptr || rhs == nullptr)) {
        return false;
    }
    return unwrap(lhs)->operator==(*unwrap(rhs));
}

int json_object_iterator_compare(JSONObjectIteratorRef lhs, JSONObjectIteratorRef rhs) {
    if (UNLIKELY(lhs == nullptr || rhs == nullptr)) {
        return false;
    }
    const auto& _lhs = unwrap(lhs);
    const auto& _rhs = unwrap(rhs);
    if (_lhs == _rhs) {
        return 0;
    }
    return _lhs > _rhs ? 1 : -1;
}

void json_object_iterator_move(JSONObjectIteratorRef ref, NSInteger length) {
    if (UNLIKELY(ref == nullptr)) {
        return;
    }
    unwrap(ref)->operator++(static_cast<int>(length));
}

void json_object_iterator_move_next(JSONObjectIteratorRef ref) {
    if (UNLIKELY(ref == nullptr)) {
        return;
    }
    unwrap(ref)->operator++();
}
