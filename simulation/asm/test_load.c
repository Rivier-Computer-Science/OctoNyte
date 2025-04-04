#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>
#include <unistd.h>
#include <arpa/inet.h>

// Register structure
typedef struct {
    unsigned long ra, sp, gp, tp;
    unsigned long t0, t1, t2;
    unsigned long s0, s1;
    unsigned long a0, a1, a2, a3, a4, a5, a6, a7;
    unsigned long s2, s3, s4, s5, s6, s7, s8;
    unsigned long s9, s10, s11;
    unsigned long t3, t4, t5, t6;
} RegisterState;

// Function to get the register values
void get_registers(RegisterState *regs) {
    __asm__ volatile (
        "mv %0, ra\n"
        "mv %1, sp\n"
        "mv %2, gp\n"
        "mv %3, tp\n"
        "mv %4, t0\n"
        "mv %5, t1\n"
        "mv %6, t2\n"
        "mv %7, s0\n"
        "mv %8, s1\n"
        "mv %9, a0\n"
        "mv %10, a1\n"
        "mv %11, a2\n"
        "mv %12, a3\n"
        "mv %13, a4\n"
        "mv %14, a5\n"
        "mv %15, a6\n"
        : "=r"(regs->ra), "=r"(regs->sp), "=r"(regs->gp), "=r"(regs->tp),
          "=r"(regs->t0), "=r"(regs->t1), "=r"(regs->t2), "=r"(regs->s0),
          "=r"(regs->s1), "=r"(regs->a0), "=r"(regs->a1), "=r"(regs->a2),
          "=r"(regs->a3), "=r"(regs->a4), "=r"(regs->a5), "=r"(regs->a6)
   );

   __asm__ volatile (
        "mv %0, a7\n"
        "mv %1, s2\n"
        "mv %2, s3\n"
        "mv %3, s4\n"
        "mv %4, s5\n"
        "mv %5, s6\n"
        "mv %6, s7\n"
        "mv %7, s8\n"
        "mv %8, s9\n"
        "mv %9, s10\n"
        "mv %10, s11\n"
        "mv %11, t3\n"
        "mv %12, t4\n"
        "mv %13, t5\n"
        "mv %14, t6\n"
        : "=r"(regs->a7), "=r"(regs->s2), "=r"(regs->s3), "=r"(regs->s4), "=r"(regs->s5),
          "=r"(regs->s6), "=r"(regs->s7), "=r"(regs->s8), "=r"(regs->s9), "=r"(regs->s10),
          "=r"(regs->s11), "=r"(regs->t3), "=r"(regs->t4), "=r"(regs->t5), "=r"(regs->t6)
   );
}

// Function to convert register state into a JSON formatted string
void register_state_to_json(RegisterState *regs, char *json_str) {
    sprintf(json_str, 
            "{\"ra\":%lu,\"sp\":%lu,\"gp\":%lu,\"tp\":%lu,"
            "\"t0\":%lu,\"t1\":%lu,\"t2\":%lu,\"s0\":%lu,\"s1\":%lu,"
            "\"a0\":%lu,\"a1\":%lu,\"a2\":%lu,\"a3\":%lu,\"a4\":%lu,"
            "\"a5\":%lu,\"a6\":%lu,\"a7\":%lu,\"s2\":%lu,\"s3\":%lu,"
            "\"s4\":%lu,\"s5\":%lu,\"s6\":%lu,\"s7\":%lu,\"s8\":%lu,"
            "\"s9\":%lu,\"s10\":%lu,\"s11\":%lu,\"t3\":%lu,\"t4\":%lu,"
            "\"t5\":%lu,\"t6\":%lu}", 
            regs->ra, regs->sp, regs->gp, regs->tp, regs->t0, regs->t1, regs->t2,
            regs->s0, regs->s1, regs->a0, regs->a1, regs->a2, regs->a3, regs->a4,
            regs->a5, regs->a6, regs->a7, regs->s2, regs->s3, regs->s4, regs->s5,
            regs->s6, regs->s7, regs->s8, regs->s9, regs->s10, regs->s11, regs->t3,
            regs->t4, regs->t5, regs->t6);
}

// Function to send JSON data to a server via HTTP POST using sockets
void send_registers_to_server(const char *server_ip, int server_port, const char *json_str) {
    int sockfd;
    struct sockaddr_in server_addr;
    char request[1024];
    
    // Create socket
    sockfd = socket(AF_INET, SOCK_STREAM, 0);
    if (sockfd < 0) {
        perror("Socket creation failed");
        exit(1);
    }

    // Define server address
    server_addr.sin_family = AF_INET;
    server_addr.sin_port = htons(server_port);
    server_addr.sin_addr.s_addr = inet_addr(server_ip);
    
    // Connect to server
    if (connect(sockfd, (struct sockaddr*)&server_addr, sizeof(server_addr)) < 0) {
        perror("Connection failed");
        close(sockfd);
        exit(1);
    }

    // Prepare HTTP POST request
    snprintf(request, sizeof(request),
             "POST /register_state HTTP/1.1\r\n"
             "Host: %s\r\n"
             "Content-Type: application/json\r\n"
             "Content-Length: %ld\r\n\r\n%s",
             server_ip, strlen(json_str), json_str);

    // Send request
    send(sockfd, request, strlen(request), 0);

    // Receive response
    char response[1024];
    int bytes_received = recv(sockfd, response, sizeof(response) - 1, 0);
    if (bytes_received > 0) {
        response[bytes_received] = '\0';
        printf("Server Response: %s\n", response);
    }

    // Close socket
    close(sockfd);
}

int main() {
    // Define server IP and port
    const char *server_ip = "127.0.0.1";  // Replace with your server's IP
    int server_port = 8080;               // Replace with your server's port

    // Get register values
    RegisterState regs;
    get_registers(&regs);

    // Convert register values to JSON string
    char json_str[1024];
    register_state_to_json(&regs, json_str);

    // Send JSON data to server (behind a load balancer)
    send_registers_to_server(server_ip, server_port, json_str);

    return 0;
}
