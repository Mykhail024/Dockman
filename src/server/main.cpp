#include <array>
#include <chrono>
#include <cstdio>
#include <grpcpp/grpcpp.h>
#include <grpcpp/security/server_credentials.h>
#include <iostream>
#include <memory>
#include <nlohmann/json.hpp>
#include <sstream>
#include <stdexcept>

#include "config.h"
#include "dockman.grpc.pb.h"
#include "dockman.pb.h"
#include "dockman/File.h"
#include "dockman/Logger.h"

using dockman::ActionResponse;
using dockman::ContainerId;
using dockman::ContainerState;
using dockman::ContainerSummary;
using dockman::DockmanService;
using dockman::ListContainersRequest;
using dockman::ListContainersResponse;
using dockman::PingRequest;
using dockman::PingResponse;
using dockman::PullImageRequest;
using dockman::PullImageResponse;
using dockman::RunContainerRequest;
using dockman::RunContainerResponse;

using grpc::Server;
using grpc::ServerBuilder;
using grpc::ServerContext;
using grpc::Status;

using json = nlohmann::json;

static std::string runCommand(const std::string &cmd)
{
    std::array<char, 4096> buffer{};
    std::string result;

    FILE *pipe = popen(cmd.c_str(), "r");
    if (!pipe)
        throw std::runtime_error("popen() failed: " + cmd);

    while (fgets(buffer.data(), buffer.size(), pipe) != nullptr) {
        result.append(buffer.data());
    }

    int rc = pclose(pipe);
    if (rc != 0) {
        throw std::runtime_error("command failed with code " + std::to_string(rc) + ": " + cmd);
    }

    return result;
}

static dockman::ContainerState mapPodmanState(const std::string &state)
{
    if (state == "running")
        return dockman::RUNNING;
    if (state == "created")
        return dockman::CREATED;
    if (state == "exited" || state == "stopped")
        return dockman::STOPPED;
    if (state == "paused")
        return dockman::PAUSED;
    return dockman::UNKNOWN;
}

class DockmanServiceImpl final : public DockmanService::Service
{
    public:
        Status Ping(ServerContext *, const PingRequest *, PingResponse *response) override
        {
            (void)response;
            return Status::OK;
        }

        Status ListContainers(ServerContext *, const ListContainersRequest *request,
                              ListContainersResponse *response) override
        {
            try {
                std::string cmd = "podman ps --format json";
                if (request->all())
                    cmd = "podman ps -a --format json";

                Log_Info("Executing: " + cmd);
                std::string out = runCommand(cmd);

                json arr = json::parse(out);

                for (const auto &item : arr) {
                    ContainerSummary *c = response->add_containers();

                    // Id / ID
                    std::string id;
                    if (item.contains("Id") && item["Id"].is_string())
                        id = item["Id"].get<std::string>();
                    else if (item.contains("ID") && item["ID"].is_string())
                        id = item["ID"].get<std::string>();
                    c->set_id(id);

                    std::string name;
                    if (item.contains("Names")) {
                        if (item["Names"].is_array() && !item["Names"].empty())
                            name = item["Names"][0].get<std::string>();
                        else if (item["Names"].is_string())
                            name = item["Names"].get<std::string>();
                    }
                    c->set_name(name);

                    if (item.contains("Image") && item["Image"].is_string())
                        c->set_image(item["Image"].get<std::string>());

                    std::string stateStr;
                    if (item.contains("State") && item["State"].is_string())
                        stateStr = item["State"].get<std::string>();
                    c->set_state(mapPodmanState(stateStr));

                    int64_t created = 0;
                    if (item.contains("Created") && item["Created"].is_number_integer())
                        created = item["Created"].get<int64_t>();
                    c->set_created_at(created);
                }

                return Status::OK;
            } catch (const std::exception &ex) {
                Log_Error(std::string("ListContainers failed: ") + ex.what());
                return Status(grpc::StatusCode::INTERNAL, ex.what());
            }
        }

        Status StartContainer(ServerContext *, const ContainerId *request,
                              ActionResponse *response) override
        {
            const std::string &id = request->id();
            Log_Info("StartContainer: id=" + id);

            try {
                std::string cmd = "podman start " + id;
                runCommand(cmd);

                response->set_success(true);
                response->set_error_message("");
                return Status::OK;
            } catch (const std::exception &ex) {
                Log_Warning(std::string("StartContainer failed: ") + ex.what());
                response->set_success(false);
                response->set_error_message(ex.what());
                return Status::OK;
            }
        }

        Status StopContainer(ServerContext *, const ContainerId *request,
                             ActionResponse *response) override
        {
            const std::string &id = request->id();
            Log_Info("StopContainer: id=" + id);

            try {
                std::string cmd = "podman stop " + id;
                runCommand(cmd);

                response->set_success(true);
                response->set_error_message("");
                return Status::OK;
            } catch (const std::exception &ex) {
                Log_Warning(std::string("StopContainer failed: ") + ex.what());
                response->set_success(false);
                response->set_error_message(ex.what());
                return Status::OK;
            }
        }

        Status RestartContainer(ServerContext *, const ContainerId *request,
                                ActionResponse *response) override
        {
            const std::string &id = request->id();
            Log_Info("RestartContainer: id=" + id);

            try {
                std::string cmd = "podman restart " + id;
                runCommand(cmd);

                response->set_success(true);
                response->set_error_message("");
                return Status::OK;
            } catch (const std::exception &ex) {
                Log_Warning(std::string("RestartContainer failed: ") + ex.what());
                response->set_success(false);
                response->set_error_message(ex.what());
                return Status::OK;
            }
        }

        Status RemoveContainer(ServerContext *, const ContainerId *request,
                               ActionResponse *response) override
        {
            const std::string &id = request->id();
            Log_Info("RemoveContainer: id=" + id);

            try {
                std::string cmd = "podman rm -f " + id;
                runCommand(cmd);

                response->set_success(true);
                response->set_error_message("");
                return Status::OK;
            } catch (const std::exception &ex) {
                Log_Warning(std::string("RemoveContainer failed: ") + ex.what());
                response->set_success(false);
                response->set_error_message(ex.what());
                return Status::OK;
            }
        }

        Status PullImage(ServerContext *, const PullImageRequest *request,
                         PullImageResponse *response) override
        {
            const std::string image = request->image();
            Log_Info("PullImage: image=" + image);

            if (image.empty()) {
                response->set_success(false);
                response->set_error_message("image name is empty");
                return Status::OK;
            }

            try {
                std::string cmd = "podman pull " + image;
                std::string out = runCommand(cmd);

                response->set_success(true);
                response->set_error_message("");
                response->set_image_id(out);

                return Status::OK;
            } catch (const std::exception &ex) {
                Log_Warning(std::string("PullImage failed: ") + ex.what());
                response->set_success(false);
                response->set_error_message(ex.what());
                return Status::OK;
            }
        }

        Status RunContainer(ServerContext *, const RunContainerRequest *request,
                            RunContainerResponse *response) override
        {
            const std::string image = request->image();
            const std::string name = request->name();

            Log_Info("RunContainer: image=" + image + ", name=" + name);

            if (image.empty()) {
                response->set_success(false);
                response->set_error_message("image name is empty");
                return Status::OK;
            }

            try {
                std::string cmd = "podman run -d";

                if (!name.empty()) {
                    cmd += " --name " + name;
                }

                for (const auto &arg : request->args()) {
                    cmd += " " + arg;
                }

                cmd += " " + image;

                Log_Info("RunContainer exec: " + cmd);
                std::string out = runCommand(cmd);

                auto pos = out.find_first_not_of(" \t\r\n");
                if (pos != std::string::npos)
                    out.erase(0, pos);
                pos = out.find_last_not_of(" \t\r\n");
                if (pos != std::string::npos)
                    out.erase(pos + 1);

                response->set_success(true);
                response->set_error_message("");
                response->set_container_id(out);

                return Status::OK;
            } catch (const std::exception &ex) {
                Log_Warning(std::string("RunContainer failed: ") + ex.what());
                response->set_success(false);
                response->set_error_message(ex.what());
                return Status::OK;
            }
        }
};

int main(int argc, char *argv[])
{
    (void)argc;
    (void)argv;

    Log_Info(std::string("Dockman server version: ") + DOCKMAN_VERSION);

    auto key = dockman::file::readFile("");
    auto cert = dockman::file::readFile("");
    auto ca = dockman::file::readFile("");

    grpc::SslServerCredentialsOptions ssl_opts;
    ssl_opts.pem_root_certs = ca;
    ssl_opts.pem_key_cert_pairs.push_back({key, cert});

    const std::string address = "0.0.0.0:50051";

    DockmanServiceImpl service;

    ServerBuilder builder;
    builder.AddListeningPort(address, grpc::SslServerCredentials(ssl_opts));
    builder.RegisterService(&service);

    std::unique_ptr<Server> server(builder.BuildAndStart());
    Log_Info("Server listening on " + address);
    server->Wait();
    return 0;
}
