#include <unistd.h>
#include <iostream>
#include <fstream>
#include <fcntl.h>
#include <sys/stat.h>
#include <errno.h>
#include <csignal>   // ✅ Fix: Include signal()
#include <cstring>   // ✅ Fix: Include strerror()

#define PIPE_NAME "../pipe/spike_rtl_pipe"
#define PIPE_NAME_OUT "../pipe/rtl_spike_pipe"
bool running = true;

void log_message(const std::string& msg) {
    std::ofstream log("verilator_log.txt", std::ios::app);
    log << msg << std::endl;
}

void send_result_to_spike(const std::string& result) {
    int pipe_fd = open(PIPE_NAME_OUT, O_WRONLY);
    if (pipe_fd == -1) {
        std::cerr << "Error: Unable to open output pipe." << std::endl;
        log_message("Error: Unable to open output pipe");
        return;
    }

    write(pipe_fd, result.c_str(), result.size());
    close(pipe_fd);
}

void execute_instruction(const std::string& instruction) {
    std::cout << "RTL executing: " << instruction << std::endl;
    log_message("Executing: " + instruction);

    std::string result = "Execution complete: " + instruction;
    send_result_to_spike(result);
}

void signal_handler(int signum){
    running = false;
    unlink(PIPE_NAME);
    unlink(PIPE_NAME_OUT);
    std::cout << "Exiting...." << std::endl;
    exit(0);
}

int main() {
    signal(SIGINT, signal_handler); // ✅ Fix: SIGINT is now recognized

    // Ensure the pipe exists or create it
    if (mkfifo(PIPE_NAME, 0666) == -1 && errno != EEXIST) {
        std::cerr << "Error creating input pipe: " << strerror(errno) << std::endl;
        return 1;
    }

    if (mkfifo(PIPE_NAME_OUT, 0666) == -1 && errno != EEXIST) {
        std::cerr << "Error creating output pipe: " << strerror(errno) << std::endl;
        return 1;
    }

    std::cout << "Waiting for instruction from Spike... " << std::endl;
    log_message("Waiting for instruction...");

    while(running){
        int pipe_fd = open(PIPE_NAME, O_RDONLY);
        if (pipe_fd == -1) {
            std::cerr << "Error: Unable to open input pipe. " << strerror(errno) << std::endl;
            sleep(1);
            continue;
        }
        char buffer[256];
        ssize_t bytesRead = read(pipe_fd, buffer, sizeof(buffer) - 1);
        if (bytesRead > 0) {
            buffer[bytesRead] = '\0';
            execute_instruction(std::string(buffer));
            close(pipe_fd);
        }
    }
    return 0;
}