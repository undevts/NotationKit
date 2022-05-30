cmake_minimum_required(VERSION 3.20)
project(NotationKit)

set(CMAKE_CXX_STANDARD 20)

set(CORE_SWIFT_INCLUDE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/.build/checkouts/CoreSwift/Sources/CoreCxx/include)

add_subdirectory(Sources)
