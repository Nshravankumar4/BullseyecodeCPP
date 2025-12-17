# ============================================
# BULLSEYE COVERAGE TOOLCHAIN CONFIGURATION
# ============================================
# This file configures Bullseye compiler wrappers
# Included when ENABLE_COVERAGE=ON in main CMakeLists.txt
# ============================================

message(STATUS "Loading Bullseye coverage toolchain...")

# 1. BULLSEYE INSTALLATION PATH
set(BULLSEYE_PATH "C:/Program Files/BullseyeCoverage/bin")

# 2. VERIFY BULLSEYE INSTALLATION
if(NOT EXISTS "${BULLSEYE_PATH}/cov01.exe")
    message(FATAL_ERROR "Bullseye not found at ${BULLSEYE_PATH}")
endif()

if(NOT EXISTS "${BULLSEYE_PATH}/cl.exe")
    message(FATAL_ERROR "Bullseye compiler wrapper not found")
endif()

message(STATUS "Bullseye found at: ${BULLSEYE_PATH}")

# 3. OVERRIDE COMPILERS FOR INSTRUMENTATION
# -----------------------------------------
# Bullseye's cl.exe wraps the real MSVC compiler and adds instrumentation
set(CMAKE_C_COMPILER "${BULLSEYE_PATH}/cl.exe" CACHE FILEPATH "C compiler" FORCE)
set(CMAKE_CXX_COMPILER "${BULLSEYE_PATH}/cl.exe" CACHE FILEPATH "C++ compiler" FORCE)
set(CMAKE_LINKER "${BULLSEYE_PATH}/link.exe" CACHE FILEPATH "Linker" FORCE)

# 4. FORCE 64-BIT COMPILATION (Qt is 64-bit)
# ------------------------------------------
# Add architecture flags to avoid x86/x64 mismatch
if(MSVC)
    add_compile_options(/MACHINE:X64)
    set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} /MACHINE:X64")
endif()

# 5. CLEAR COMPILER CACHE (force CMake to re-detect)
# --------------------------------------------------
unset(CMAKE_C_COMPILER_ID CACHE)
unset(CMAKE_CXX_COMPILER_ID CACHE)

# 6. VERIFICATION MESSAGE
# -----------------------
message(STATUS "Compiler configured: ${CMAKE_CXX_COMPILER}")
message(STATUS "Target architecture: x64")