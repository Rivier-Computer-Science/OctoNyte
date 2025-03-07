#include <iostream>
#include <fstream>
#include <thread>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>
#include <cstring>  // ✅ Fix: For strerror()

#define PIPE_NAME "../pipe/spike_rtl_pipe"

void log_message(const std::string& msg) {
    std::ofstream log("spike_log.txt", std::ios::app);
    log << msg << std::endl;
}

void create_fifo() {
    if (mkfifo(PIPE_NAME, 0666) == -1) {
        if (errno != EEXIST) {
            std::cerr << "Failed to create FIFO: " << strerror(errno) << std::endl;  // ✅ Now strerror() is recognized
            log_message("Failed to create FIFO");
            exit(1);
        }
    }
}

void send_instruction(const std::string& instruction) {
    int pipe_fd = open(PIPE_NAME, O_WRONLY);
    if (pipe_fd == -1) {
        std::cerr << "Error: Unable to open pipe." << std::endl;
        log_message("Error: Failed to open pipe.");
        return;
    }

    write(pipe_fd, instruction.c_str(), instruction.size());
    log_message("Sent instruction: " + instruction);
    close(pipe_fd);
}

int main() {
    create_fifo();
    std::string instruction = "ADD x1, x2, x3";
    send_instruction(instruction);
    return 0;
}