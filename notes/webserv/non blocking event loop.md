.hpp

```cpp
#pragma once
#include <vector>
#include <unistd.h>
#include <cstdint>

#if defined(__linux__)
#include <sys/epoll.h>
#elif defined(__APPLE__) || defined(__FreeBSD__) || defined(__OpenBSD__) || defined(__NetBSD__) || defined(__DragonFly__)
#include <sys/event.h>
#include <sys/time.h>
#else
#include <poll.h>
#endif

enum class EventType : uint8_t { Read = 1, Write = 2 };

class EventLoop
{
public:
    EventLoop();
    ~EventLoop();

    void addFD(int fd, EventType events);
    void run();

private:
#if defined(__linux__)
    int epoll_fd;
    void initLinux();
    void addFDLinux(int fd, EventType events);
    void runLinux();
    void cleanupLinux();
#elif defined(__APPLE__) || defined(__FreeBSD__) || defined(__OpenBSD__) || defined(__NetBSD__) || defined(__DragonFly__)
    int kqueue_fd;
    void initKqueue();
    void addFDKqueue(int fd, EventType events);
    void runKqueue();
    void cleanupKqueue();
#else
    std::vector<struct pollfd> fds;
    void initPoll();
    void addFDPoll(int fd, EventType events);
    void runPoll();
    void cleanupPoll();
#endif
};

// ==================== Macros for unified interface ====================

#if defined(__linux__)
#define addFD(fd, events) addFDLinux(fd, events)
#define run() runLinux()
#define init() initLinux()
#define cleanup() cleanupLinux()
#elif defined(__APPLE__) || defined(__FreeBSD__) || defined(__OpenBSD__) || defined(__NetBSD__) || defined(__DragonFly__)
#define addFD(fd, events) addFDKqueue(fd, events)
#define run() runKqueue()
#define init() initKqueue()
#define cleanup() cleanupKqueue()
#else
#define addFD(fd, events) addFDPoll(fd, events)
#define run() runPoll()
#define init() initPoll()
#define cleanup() cleanupPoll()
#endif
```

.cpp

```cpp
#include "EventLoop.hpp"
#include <iostream>
#include <fcntl.h>

// ==================== Constructor / Destructor ====================

EventLoop::EventLoop() { init(); }
EventLoop::~EventLoop() { cleanup(); }

// ------------------ Linux (epoll) ------------------
#if defined(__linux__)
void EventLoop::initLinux() { epoll_fd = epoll_create1(0); }

void EventLoop::addFDLinux(int fd, EventType events)
{
    // Set non-blocking
    int flags = fcntl(fd, F_GETFL, 0);
    fcntl(fd, F_SETFL, flags | O_NONBLOCK);

    struct epoll_event ev{};
    ev.data.fd = fd;
    ev.events = 0;
    if (static_cast<uint8_t>(events) & static_cast<uint8_t>(EventType::Read))
        ev.events |= EPOLLIN;
    if (static_cast<uint8_t>(events) & static_cast<uint8_t>(EventType::Write))
        ev.events |= EPOLLOUT;

    epoll_ctl(epoll_fd, EPOLL_CTL_ADD, fd, &ev);
}

void EventLoop::runLinux()
{
    struct epoll_event events[10];
    int n = epoll_wait(epoll_fd, events, 10, -1);
    for (int i = 0; i < n; ++i)
    {
        if (events[i].events & EPOLLIN)
            std::cout << "Read event on fd " << events[i].data.fd << "\n";
        if (events[i].events & EPOLLOUT)
            std::cout << "Write event on fd " << events[i].data.fd << "\n";
    }
}

void EventLoop::cleanupLinux() { close(epoll_fd); }
#endif

// ------------------ BSD / macOS (kqueue) ------------------
#if defined(__APPLE__) || defined(__FreeBSD__) || defined(__OpenBSD__) || defined(__NetBSD__) || defined(__DragonFly__)
void EventLoop::initKqueue() { kqueue_fd = kqueue(); }

void EventLoop::addFDKqueue(int fd, EventType events)
{
    // Set non-blocking
    int flags = fcntl(fd, F_GETFL, 0);
    fcntl(fd, F_SETFL, flags | O_NONBLOCK);

    if (static_cast<uint8_t>(events) & static_cast<uint8_t>(EventType::Read))
    {
        struct kevent ke{};
        EV_SET(&ke, fd, EVFILT_READ, EV_ADD, 0, 0, nullptr);
        kevent(kqueue_fd, &ke, 1, nullptr, 0, nullptr);
    }
    if (static_cast<uint8_t>(events) & static_cast<uint8_t>(EventType::Write))
    {
        struct kevent ke{};
        EV_SET(&ke, fd, EVFILT_WRITE, EV_ADD, 0, 0, nullptr);
        kevent(kqueue_fd, &ke, 1, nullptr, 0, nullptr);
    }
}

void EventLoop::runKqueue()
{
    struct kevent events[10];
    int n = kevent(kqueue_fd, nullptr, 0, events, 10, nullptr);
    for (int i = 0; i < n; ++i)
    {
        if (events[i].filter == EVFILT_READ)
            std::cout << "Read event on fd " << events[i].ident << "\n";
        if (events[i].filter == EVFILT_WRITE)
            std::cout << "Write event on fd " << events[i].ident << "\n";
    }
}

void EventLoop::cleanupKqueue() { close(kqueue_fd); }
#endif

// ------------------ Fallback poll ------------------
#if !defined(__linux__) && !(defined(__APPLE__) || defined(__FreeBSD__) || defined(__OpenBSD__) || defined(__NetBSD__) || defined(__DragonFly__))
void EventLoop::initPoll() {}

void EventLoop::addFDPoll(int fd, EventType events)
{
    fds.push_back({fd, 0});
    if (static_cast<uint8_t>(events) & static_cast<uint8_t>(EventType::Read))
        fds.back().events |= POLLIN;
    if (static_cast<uint8_t>(events) & static_cast<uint8_t>(EventType::Write))
        fds.back().events |= POLLOUT;
}

void EventLoop::runPoll()
{
    int ret = ::poll(fds.data(), fds.size(), -1);
    if (ret > 0)
        for (auto &pfd : fds)
        {
            if (pfd.revents & POLLIN)
                std::cout << "Read event on fd " << pfd.fd << "\n";
            if (pfd.revents & POLLOUT)
                std::cout << "Write event on fd " << pfd.fd << "\n";
        }
}

void EventLoop::cleanupPoll() {}
#endif

```

Usage example:

```cpp
#include "EventLoop.hpp"
#include <sys/socket.h>
#include <netinet/in.h>

int main()
{
    int server_fd = socket(AF_INET, SOCK_STREAM, 0);

    EventLoop loop;
    loop.addFD(server_fd, EventType::Read | EventType::Write);
    loop.run();

    return 0;
}
```
