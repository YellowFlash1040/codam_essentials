Version 1:

```cpp
#include <iostream>
#include <vector>
#include <unistd.h>

#if defined(__linux__)
#include <sys/epoll.h>
#elif defined(__APPLE__) || defined(__FreeBSD__) || defined(__OpenBSD__) || defined(__NetBSD__) || defined(__DragonFly__)
#include <sys/event.h>
#include <sys/time.h>
#else
#include <poll.h>
#endif

class EventLoop
{
public:
    EventLoop();
    ~EventLoop();
    void addFD(int fd);
    void run();

private:
#if defined(__linux__)
    void initLinux();
    void addFDLinux(int fd);
    void runLinux();
    void cleanupLinux();
    int epoll_fd;

#elif defined(__APPLE__) || defined(__FreeBSD__) || defined(__OpenBSD__) || defined(__NetBSD__) || defined(__DragonFly__)
    void initKqueue();
    void addFDKqueue(int fd);
    void runKqueue();
    void cleanupKqueue();
    int kqueue_fd;

#else
    void initPoll();
    void addFDPoll(int fd);
    void runPoll();
    void cleanupPoll();
    std::vector<struct pollfd> fds;
#endif
};

// ========================= Implementation =========================

EventLoop::EventLoop()
{
#if defined(__linux__)
    initLinux();
#elif defined(__APPLE__) || defined(__FreeBSD__) || defined(__OpenBSD__) || defined(__NetBSD__) || defined(__DragonFly__)
    initKqueue();
#else
    initPoll();
#endif
}

EventLoop::~EventLoop()
{
#if defined(__linux__)
    cleanupLinux();
#elif defined(__APPLE__) || defined(__FreeBSD__) || defined(__OpenBSD__) || defined(__NetBSD__) || defined(__DragonFly__)
    cleanupKqueue();
#else
    cleanupPoll();
#endif
}

void EventLoop::addFD(int fd)
{
#if defined(__linux__)
    addFDLinux(fd);
#elif defined(__APPLE__) || defined(__FreeBSD__) || defined(__OpenBSD__) || defined(__NetBSD__) || defined(__DragonFly__)
    addFDKqueue(fd);
#else
    addFDPoll(fd);
#endif
}

void EventLoop::run()
{
#if defined(__linux__)
    runLinux();
#elif defined(__APPLE__) || defined(__FreeBSD__) || defined(__OpenBSD__) || defined(__NetBSD__) || defined(__DragonFly__)
    runKqueue();
#else
    runPoll();
#endif
}

// ------------------ Linux (epoll) ------------------
#if defined(__linux__)
void EventLoop::initLinux() { epoll_fd = epoll_create1(0); }
void EventLoop::addFDLinux(int fd)
{
    struct epoll_event ev{};
    ev.events = EPOLLIN;
    ev.data.fd = fd;
    epoll_ctl(epoll_fd, EPOLL_CTL_ADD, fd, &ev);
}
void EventLoop::runLinux()
{
    struct epoll_event events[10];
    int n = epoll_wait(epoll_fd, events, 10, -1);
    for (int i = 0; i < n; ++i)
        std::cout << "Event on fd " << events[i].data.fd << "\n";
}
void EventLoop::cleanupLinux() { close(epoll_fd); }
#endif

// ------------------ BSD / macOS (kqueue) ------------------
#if defined(__APPLE__) || defined(__FreeBSD__) || defined(__OpenBSD__) || defined(__NetBSD__) || defined(__DragonFly__)
void EventLoop::initKqueue() { kqueue_fd = kqueue(); }
void EventLoop::addFDKqueue(int fd)
{
    struct kevent ke{};
    EV_SET(&ke, fd, EVFILT_READ, EV_ADD, 0, 0, nullptr);
    kevent(kqueue_fd, &ke, 1, nullptr, 0, nullptr);
}
void EventLoop::runKqueue()
{
    struct kevent events[10];
    int n = kevent(kqueue_fd, nullptr, 0, events, 10, nullptr);
    for (int i = 0; i < n; ++i)
        std::cout << "Event on fd " << events[i].ident << "\n";
}
void EventLoop::cleanupKqueue() { close(kqueue_fd); }
#endif

// ------------------ Fallback poll ------------------
#if !defined(__linux__) && !(defined(__APPLE__) || defined(__FreeBSD__) || defined(__OpenBSD__) || defined(__NetBSD__) || defined(__DragonFly__))
void EventLoop::initPoll() {}
void EventLoop::addFDPoll(int fd) { fds.push_back({fd, POLLIN}); }
void EventLoop::runPoll()
{
    int ret = ::poll(fds.data(), fds.size(), -1);
    if (ret > 0)
        for (auto &pfd : fds)
            if (pfd.revents & POLLIN)
                std::cout << "Event on fd " << pfd.fd << "\n";
}
void EventLoop::cleanupPoll() {}
#endif
```

Version 2:

```cpp
EventLoop.hpp
#pragma once
#include <vector>
#include <unistd.h>

#if defined(__linux__)
#include <sys/epoll.h>
#elif defined(__APPLE__) || defined(__FreeBSD__) || defined(__OpenBSD__) || defined(__NetBSD__) || defined(__DragonFly__)
#include <sys/event.h>
#include <sys/time.h>
#else
#include <poll.h>
#endif

class EventLoop
{
public:
    EventLoop();
    ~EventLoop();

    void addFD(int fd);
    void run();

private:
#if defined(__linux__)
    int epoll_fd;
    void initLinux();
    void addFDLinux(int fd);
    void runLinux();
    void cleanupLinux();
#elif defined(__APPLE__) || defined(__FreeBSD__) || defined(__OpenBSD__) || defined(__NetBSD__) || defined(__DragonFly__)
    int kqueue_fd;
    void initKqueue();
    void addFDKqueue(int fd);
    void runKqueue();
    void cleanupKqueue();
#else
    std::vector<struct pollfd> fds;
    void initPoll();
    void addFDPoll(int fd);
    void runPoll();
    void cleanupPoll();
#endif
};

// ==================== Macros for unified interface ====================

#if defined(__linux__)
#define init() initLinux()
#define addFD(fd) addFDLinux(fd)
#define run() runLinux()
#define cleanup() cleanupLinux()
#elif defined(__APPLE__) || defined(__FreeBSD__) || defined(__OpenBSD__) || defined(__NetBSD__) || defined(__DragonFly__)
#define init() initKqueue()
#define addFD(fd) addFDKqueue(fd)
#define run() runKqueue()
#define cleanup() cleanupKqueue()
#else
#define init() initPoll()
#define addFD(fd) addFDPoll(fd)
#define run() runPoll()
#define cleanup() cleanupPoll()
#endif


EventLoop.cpp
#include "EventLoop.hpp"
#include <iostream>

// ==================== Constructor / Destructor ====================

EventLoop::EventLoop() { init(); }
EventLoop::~EventLoop() { cleanup(); }

// ==================== Public interface ====================

void EventLoop::addFD(int fd) { addFD(fd); }
void EventLoop::run() { run(); }

// ==================== Linux (epoll) ====================
#if defined(__linux__)
void EventLoop::initLinux() { epoll_fd = epoll_create1(0); }
void EventLoop::addFDLinux(int fd)
{
    struct epoll_event ev{};
    ev.events = EPOLLIN;
    ev.data.fd = fd;
    epoll_ctl(epoll_fd, EPOLL_CTL_ADD, fd, &ev);
}
void EventLoop::runLinux()
{
    struct epoll_event events[10];
    int n = epoll_wait(epoll_fd, events, 10, -1);
    for (int i = 0; i < n; ++i)
        std::cout << "Event on fd " << events[i].data.fd << "\n";
}
void EventLoop::cleanupLinux() { close(epoll_fd); }
#endif

// ==================== BSD / macOS (kqueue) ====================
#if defined(__APPLE__) || defined(__FreeBSD__) || defined(__OpenBSD__) || defined(__NetBSD__) || defined(__DragonFly__)
void EventLoop::initKqueue() { kqueue_fd = kqueue(); }
void EventLoop::addFDKqueue(int fd)
{
    struct kevent ke{};
    EV_SET(&ke, fd, EVFILT_READ, EV_ADD, 0, 0, nullptr);
    kevent(kqueue_fd, &ke, 1, nullptr, 0, nullptr);
}
void EventLoop::runKqueue()
{
    struct kevent events[10];
    int n = kevent(kqueue_fd, nullptr, 0, events, 10, nullptr);
    for (int i = 0; i < n; ++i)
        std::cout << "Event on fd " << events[i].ident << "\n";
}
void EventLoop::cleanupKqueue() { close(kqueue_fd); }
#endif

// ==================== Fallback poll ====================
#if !defined(__linux__) && !(defined(__APPLE__) || defined(__FreeBSD__) || defined(__OpenBSD__) || defined(__NetBSD__) || defined(__DragonFly__))
void EventLoop::initPoll() {}
void EventLoop::addFDPoll(int fd) { fds.push_back({fd, POLLIN}); }
void EventLoop::runPoll()
{
    int ret = ::poll(fds.data(), fds.size(), -1);
    if (ret > 0)
        for (auto &pfd : fds)
            if (pfd.revents & POLLIN)
                std::cout << "Event on fd " << pfd.fd << "\n";
}
void EventLoop::cleanupPoll() {}
#endif

```

Usage example:

```cpp
#include "EventLoop.hpp"

int main()
{
    EventLoop loop;
    loop.addFD(mySocketFd); // macro automatically calls addFDLinux/addFDKqueue
    loop.run();             // macro automatically calls runLinux/runKqueue
    return 0;
}
```
