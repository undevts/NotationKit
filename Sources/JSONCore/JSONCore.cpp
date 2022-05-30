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

#include <string>
#include <JSONCore.h>
#include "itoa.hpp"

size_t json_write_int32(json_number_32 *CS_NONNULL buffer, int32_t value) {
    assert(buffer != nullptr);
    auto target = reinterpret_cast<char*>(buffer->buffer);
    const auto end = internal::i32toa(value, target);
    return end - target;
}

size_t json_write_uint32(json_number_32 *CS_NONNULL buffer, uint32_t value) {
    assert(buffer != nullptr);
    auto target = reinterpret_cast<char*>(buffer->buffer);
    const auto end = internal::u32toa(value, target);
    return end - target;
}

size_t json_write_int64(json_number_64 *CS_NONNULL buffer, int64_t value) {
    assert(buffer != nullptr);
    auto target = reinterpret_cast<char*>(buffer->buffer);
    const auto end = internal::i64toa(value, target);
    return end - target;
}

size_t json_write_uint64(json_number_64 *CS_NONNULL buffer, uint64_t value) {
    assert(buffer != nullptr);
    auto target = reinterpret_cast<char*>(buffer->buffer);
    const auto end = internal::u64toa(value, target);
    return end - target;
}

size_t json_write_string(char* CS_NONNULL buffer, const char* CS_NONNULL value, size_t size) {
    static const char hexDigits[16] = {
        '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C', 'D', 'E', 'F'
    };
    static const char escape[256] = {
#define Z16 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
        //0    1    2    3    4    5    6    7    8    9    A    B    C    D    E    F
        'u', 'u', 'u', 'u', 'u', 'u', 'u', 'u', 'b', 't', 'n', 'u', 'f', 'r', 'u', 'u', // 00
        'u', 'u', 'u', 'u', 'u', 'u', 'u', 'u', 'u', 'u', 'u', 'u', 'u', 'u', 'u', 'u', // 10
        0, 0, '"', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, // 20
        Z16, Z16,                                                                       // 30~4F
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '\\', 0, 0, 0, // 50
        Z16, Z16, Z16, Z16, Z16, Z16, Z16, Z16, Z16, Z16                                // 60~FF
#undef Z16
    };

    assert(value != nullptr);
    auto result = buffer;
    *result++ = '\"';
    auto current = value;
    const auto end = value + size;
    while (current < end) {
        const auto& c = *current;
        if (UNLIKELY(escape[static_cast<uint8_t>(c)])) {
            *result++ = '\\';
            *result++ = escape[static_cast<uint8_t>(c)];
            if (escape[static_cast<uint8_t>(c)] == 'u') {
                *result++ = '0';
                *result++ = '0';
                *result++ = hexDigits[escape[static_cast<uint8_t>(c)] >> 4];
                *result++ = hexDigits[escape[static_cast<uint8_t>(c)] & 0xF];
            }
        } else {
            *result++ = c;
        }
        current += 1;
    }
    *result++ = '\"';
    return result - buffer;
}
