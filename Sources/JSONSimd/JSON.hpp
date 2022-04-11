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

#ifndef NOTATION_KIT_JSON_HPP
#define NOTATION_KIT_JSON_HPP

#include <JSON.h>
#include "simdjson.h"

CS_SIMPLE_CONVERSION(simdjson::dom::document, JSONRef)

CS_SIMPLE_CONVERSION(simdjson::dom::element, JSONValueRef)

CS_SIMPLE_CONVERSION(simdjson::dom::array, JSONArrayRef)

CS_SIMPLE_CONVERSION(simdjson::dom::object, JSONObjectRef)

CS_SIMPLE_CONVERSION(simdjson::padded_string, JSONInputRef)

#endif // NOTATION_KIT_JSON_HPP
