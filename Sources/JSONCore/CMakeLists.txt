add_library(JSONCore
    include/JSONCore.h
    itoa.hpp
    JSONCore.cpp)

target_include_directories(JSONCore SYSTEM PUBLIC
    include
    ${CORE_SWIFT_INCLUDE_DIR})
