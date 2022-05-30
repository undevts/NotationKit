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
