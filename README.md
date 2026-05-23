# Dockman

Dockman is a cross-platform desktop application for managing Docker containers and remote Docker hosts through a unified graphical interface.

It provides core container operations such as creation, start, stop, restart, removal, real-time logs, and resource monitoring. The application supports multiple Docker servers with fast switching between local and remote environments.

Secure communication is ensured via TLS authentication using client certificates. Dockman also includes Docker image management, allowing users to view and remove images.

The UI is designed for simplicity and speed, with search, filtering, and automatic state updates. Connection profiles are stored locally for convenient reuse.

---

## License

This project is licensed under the GNU GPL-3.0. See [LICENSE](./LICENSE) for details.

---

## Built With

- Qt 6 — UI framework
- Protobuf — data serialization
- gRPC — remote communication

---

## Build Instructions (Linux)

Dockman currently supports **Linux only**.

### Requirements

Make sure the following dependencies are installed:

- CMake (>= 3.16)
- Qt 6
- Protobuf
- gRPC
- C++ compiler (GCC or Clang)

---

### Build steps

```bash
# Clone repository
git clone https://github.com/Mykhail024/Dockman.git
cd Dockman

# Create build directory
mkdir build
cd build

# Configure project
cmake ..

# Build project
cmake --build . --parallel
```

---

### Run applications

After successful build, binaries will be located at:
- Client: `build/client/bin/dockman`
- Server: `build/server/bin/dockman_server`

---

## Project Status

Early development stage. No stable releases and no backward compatibility guarantees.
