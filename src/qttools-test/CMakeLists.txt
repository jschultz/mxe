# This file is part of MXE. See LICENSE.md for licensing information.

# Source: https://github.com/mxe/mxe/issues/1185

cmake_minimum_required(VERSION 3.0)
project(qttools-test)

find_package(Qt5 REQUIRED COMPONENTS Core Widgets Gui UiTools)

include_directories(${Qt5UiTools_INCLUDE_DIRS})
link_directories("/home/kdedev/mxe/usr/x86_64-apple-darwin18/lib;/home/kdedev/mxe/usr/x86_64-apple-darwin18/qt5/lib")
add_executable(mxe-cmake-qtuitools mxe-cmake-qtuitools.cpp)
# NB: Qt5Widgets, Qt5Gui, Qt5Core must be given separately; otherwise they are
# appended automatically at the end, making it impossible to satisfy all the
# other implicit dependencies (opengl, harfbuzz, etc.)
target_link_libraries(
    mxe-cmake-qtuitools
    #${Qt5UiTools_LIBRARIES}
    #${Qt5Widgets_LIBRARIES}
    #${Qt5Gui_LIBRARIES}
    #${Qt5Core_LIBRARIES}
    Qt5UiTools
    Qt5Widgets
    Qt5Gui
    Qt5Core
    #netapi32
    #userenv
    #opengl32
    harfbuzz
    jpeg
    png
    glib-2.0
    #winmm
    #dwmapi
    #uxtheme
    #ws2_32
    intl
    iconv
    pcre2-16
    #version
    z
    "-framework CoreServices"
    "-framework AppKit"
    "-framework Security"
    "-framework OpenGL"
    /home/kdedev/osxcross/build/compiler-rt/build/lib/darwin/libclang_rt.osx.a
)
