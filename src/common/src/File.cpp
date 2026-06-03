#include <fstream>
#include <sstream>
#include <string>

#include "dockman/File.h"

namespace dockman::file {
std::string readFile(const std::string &path)
{
    std::ifstream f(path, std::ios::binary);
    std::ostringstream ss;
    ss << f.rdbuf();
    return ss.str();
}
} // namespace dockman::file
