SET(CMAKE_BUILD_TYPE "Release" CACHE STRING "Build type")
set(CMAKE_CXX_FLAGS_RELEASE "-pipe -std=c++11 -pedantic -Wall -Wformat-nonliteral -Wcast-align -Wpointer-arith -Wcast-qual -Wshadow -Wwrite-strings -Wchar-subscripts -Wredundant-decls -O2 -DNDEBUG -mtune=native" CACHE STRING "Build flags")
