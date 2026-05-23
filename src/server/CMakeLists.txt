find_package(Protobuf CONFIG REQUIRED)
find_package(gRPC CONFIG REQUIRED)
find_package(nlohmann_json REQUIRED)

get_target_property(GRPC_CPP_PLUGIN_EXECUTABLE gRPC::grpc_cpp_plugin LOCATION)

set(PROTO_FILE ${CMAKE_SOURCE_DIR}/proto/dockman.proto)
get_filename_component(PROTO_DIR ${PROTO_FILE} PATH)

set(PROTO_SRCS
  ${CMAKE_CURRENT_BINARY_DIR}/dockman.pb.cc
)
set(PROTO_HDRS
  ${CMAKE_CURRENT_BINARY_DIR}/dockman.pb.h
)
set(GRPC_SRCS
  ${CMAKE_CURRENT_BINARY_DIR}/dockman.grpc.pb.cc
)
set(GRPC_HDRS
  ${CMAKE_CURRENT_BINARY_DIR}/dockman.grpc.pb.h
)

add_custom_command(
  OUTPUT ${PROTO_SRCS} ${PROTO_HDRS} ${GRPC_SRCS} ${GRPC_HDRS}
  COMMAND protobuf::protoc
  ARGS
  --cpp_out ${CMAKE_CURRENT_BINARY_DIR}
  --grpc_out ${CMAKE_CURRENT_BINARY_DIR}
  -I ${PROTO_DIR}
  --plugin=protoc-gen-grpc=${GRPC_CPP_PLUGIN_EXECUTABLE}
  ${PROTO_FILE}
  DEPENDS ${PROTO_FILE}
)

add_executable(dockman_server
  main.cpp
  ${PROTO_SRCS}
  ${GRPC_SRCS}
)

target_include_directories(dockman_server PRIVATE
  ${CMAKE_CURRENT_BINARY_DIR}
)

target_link_libraries(dockman_server PRIVATE
  common
  protobuf::libprotobuf
  gRPC::grpc++
  nlohmann_json::nlohmann_json
)

if (CMAKE_CXX_COMPILER_ID STREQUAL "Clang")
  target_compile_options(dockman_server PRIVATE
    -Wno-error=nullability-extension
  )
endif()

if(NOT ANDROID)
  set_target_properties(dockman_server PROPERTIES
    RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/server/bin
    OUTPUT_NAME "dockman_server"
  )
  install(TARGETS dockman_server
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
  )
endif()
