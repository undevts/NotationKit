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

#ifndef NOTATION_KIT_JSON_CORE_H
#define NOTATION_KIT_JSON_CORE_H

#if __has_include(<CoreFoundation/CoreFoundation.h>)
#include <CoreFoundation/CoreFoundation.h>
#endif

#if __has_include(<CoreSwift/Language.h>)
#include <StartPoint/Language.h>
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

CS_C_FILE_END

#endif // NOTATION_KIT_JSON_CORE_H
