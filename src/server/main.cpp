#include "config.h"
#include "dockman/logger.h"

int main(int argc, char *argv[])
{
    (void)argc;
    (void)argv;

    Log_Info(std::string("Dockman server version: ") + DOCKMAN_VERSION);
    return 0;
}
