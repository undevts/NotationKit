add_library(JSONSimd
    include/JSON.h
    JSON.cpp
    JSON.hpp
    JSON.mm
    simdjson.cpp
    simdjson.h)

target_include_directories(JSONSimd SYSTEM PUBLIC
    include
    ${JSON_CORE_INCLUDE_DIR}
    ${CORE_SWIFT_INCLUDE_DIR})
