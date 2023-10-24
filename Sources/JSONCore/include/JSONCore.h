#ifndef NOTATION_KIT_JSON_CORE_H
#define NOTATION_KIT_JSON_CORE_H

#if __has_include(<CoreFoundation/CoreFoundation.h>)
#include <CoreFoundation/CoreFoundation.h>
#endif

#if __has_include(<CoreSwift/Language.h>)
#include <CoreSwift/Language.h>
#else
#include <Language.h>
#endif

CS_C_FILE_BEGIN

typedef CS_CLOSED_ENUM(NSUInteger, JSONType) {
    JSONTypeArray = 91,
    JSONTypeObject = 123,
    JSONTypeInt64 = 108,
    JSONTypeUint64 = 117,
    JSONTypeDouble = 100,
    JSONTypeString = 34,
    JSONTypeBool = 116,
    JSONTypeNull = 110,
};

typedef CS_CLOSED_ENUM(NSUInteger, JSONParseErrorCode) {
    /// No error.
    JSONParseErrorCodeSuccess, // 0
    /// This parser can't support a document that big.
    JSONParseErrorCodeCapacity, // 1
    /// Error allocating memory, most likely out of memory.
    JSONParseErrorCodeMemalloc, // 2
    /// Something went wrong while writing to the tape (stage 2), this is a generic error.
    JSONParseErrorCodeTape, // 3
    /// Your document exceeds the user-specified depth limitation.
    JSONParseErrorCodeDepth, // 4
    /// Problem while parsing a string.
    JSONParseErrorCodeString, // 5
    /// Problem while parsing an atom starting with the letter 't'.
    JSONParseErrorCodeTAtom, // 6
    /// Problem while parsing an atom starting with the letter 'f'.
    JSONParseErrorCodeFAtom, // 7
    /// Problem while parsing an atom starting with the letter 'n'.
    JSONParseErrorCodeNAtom, // 8
    /// Problem while parsing a number.
    JSONParseErrorCodeNumber, // 9
    /// the input is not valid UTF-8.
    JSONParseErrorCodeUTF8, // 10
    /// unknown error, or uninitialized document.
    JSONParseErrorCodeUninitialized, // 11
    /// no structural element found.
    JSONParseErrorCodeEmpty, // 12
    /// found unescaped characters in a string..
    JSONParseErrorCodeUnescapedChars, // 13
    /// missing quote at the end.
    JSONParseErrorCodeUnclosedString, // 14
    /// unsupported architecture.
    JSONParseErrorCodeUnsupportedArchitecture, // 15
    /// JSON element has a different type than user expected.
    JSONParseErrorCodeIncorrectType, // 16
    /// JSON number does not fit in 64 bits.
    JSONParseErrorCodeNumberOutOfRange, // 17
    /// JSON array index too large.
    JSONParseErrorCodeIndexOutOfBounds, // 18
    /// JSON field not found in object.
    JSONParseErrorCodeNoSuchField, // 19
    /// Error reading a file.
    JSONParseErrorCodeIO, // 20
    /// Invalid JSON pointer reference.
    JSONParseErrorCodeInvalidJSONPointer, // 21
    /// Invalid URI fragment.
    JSONParseErrorCodeInvalidURIFragment, // 22
    /// indicative of a bug in JSONSimd.
    JSONParseErrorCodeUnexpectedError, // 23
    /// parser is already in use..
    JSONParseErrorCodeParserInUse, // 24
    /// tried to iterate an array or object out of order.
    JSONParseErrorCodeOutOfOrderIteration, // 25
    /// The JSON doesn't have enough padding for JSONSimd to safely parse it..
    JSONParseErrorCodeInsufficientPadding, // 26
    /// The document ends early..
    JSONParseErrorCodeIncompleteArrayOrObject, // 27
    /// A scalar document is treated as a value..
    JSONParseErrorCodeScalarDocumentAsValue, // 28
    /// Attempted to access location outside of document..
    JSONParseErrorCodeOutOfBounds, // 29
};

typedef struct {
    uint8_t buffer[11];
} json_number_32;

typedef struct {
    uint8_t buffer[21];
} json_number_64;

typedef struct json_object {
    uint8_t data[16];
} json_object;

typedef struct json_object_iterator {
    uint8_t data[16];
} json_object_iterator;

typedef struct json_array {
    uint8_t data[16];
} json_array;

typedef struct json_array_iterator {
    uint8_t data[16];
} json_array_iterator;

typedef struct json_value {
    uint8_t data[16];
} json_value;

size_t nk_json_write_int32(json_number_32* CS_NONNULL buffer, int32_t value);
size_t nk_json_write_uint32(json_number_32* CS_NONNULL buffer, uint32_t value);
size_t nk_json_write_int64(json_number_64* CS_NONNULL buffer, int64_t value);
size_t nk_json_write_uint64(json_number_64* CS_NONNULL buffer, uint64_t value);
size_t nk_json_write_string(char* CS_NONNULL buffer, const char* CS_NONNULL value, size_t size);

CS_C_FILE_END

#endif // NOTATION_KIT_JSON_CORE_H
