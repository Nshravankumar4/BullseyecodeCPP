cmake_minimum_required(VERSION 3.16)
project(IPC VERSION 1.0 LANGUAGES CXX)

# ============================================
# 1. COVERAGE OPTION (Toggle for Qt Creator GUI)
# ============================================
option(ENABLE_COVERAGE "Enable Bullseye Code Coverage" OFF)

if(ENABLE_COVERAGE)
    message(STATUS "Bullseye Coverage: ENABLED")
    
    # Include Bullseye toolchain configuration
    include(${CMAKE_CURRENT_SOURCE_DIR}/coverage-toolchain.cmake)
    
    # Set coverage file environment variable
    set(ENV{COVFILE} "C:/Users/shravannunsavath/Documents/test.cov")
    message(STATUS "COVFILE: $ENV{COVFILE}")
else()
    message(STATUS "Bullseye Coverage: DISABLED")
endif()

# ============================================
# 2. QT CONFIGURATION
# ============================================
# Set Qt installation path
set(CMAKE_PREFIX_PATH "C:/Qt/5.15.2/msvc2019_64")

# Find Qt5 components
find_package(Qt5 REQUIRED COMPONENTS Widgets Core Gui)

# C++ Standard
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Enable Qt's meta-object compiler (moc)
set(CMAKE_AUTOMOC ON)

# ============================================
# 3. PROJECT TARGET
# ============================================
# Create executable
add_executable(IPC main.cpp)

# Link Qt libraries
target_link_libraries(IPC 
    Qt5::Widgets 
    Qt5::Core 
    Qt5::Gui
)

# ============================================
# 4. BUILD INFORMATION
# ============================================
message(STATUS "Project: ${PROJECT_NAME}")
if(ENABLE_COVERAGE)
    message(STATUS "Build Mode: Debug with Coverage")
    message(STATUS "Note: Run 'cov01 -1' before building")
    message(STATUS "       Run 'cov01 -0' after running app")
else()
    message(STATUS "Build Mode: ${CMAKE_BUILD_TYPE}")
endif()