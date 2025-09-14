1.  **Nginx architecture**:

    - There is **one master process** that handles configuration, signals, and spawning worker processes.
    - Worker processes handle incoming connections on all configured ports.

2.  **Signal handling**:

    - `SIGINT` or `SIGTERM` sent to the **master process** triggers a **graceful shutdown**.
    - The master tells all worker processes to terminate.
    - All listening sockets (for all ports) are closed.

3.  **Behavior**:

    - Connections are stopped.
    - Any in-progress requests are handled (for a short while) and then the server exits.

---

✅ **Key point:** Nginx doesn’t manage ports separately — shutting down the master process stops **everything**, regardless of how many ports it was listening on.

My conclusion:

If I want to have a server that can listen on multiple ports at once,
then the solution is to create a program that will spawn multiple processes,
with one Server class instance per process

Then I also need to consider signals hadling and clean exit.
Here is some code that showcases how I can/need to handle a signal send to the
"master" process that has children:

```cpp
#include <iostream>
#include <vector>
#include <csignal>
#include <unistd.h>
#include <sys/wait.h>
#include <cerrno>

std::vector<pid_t> child_pids;

void sigint* handler(int /* _sig */)
{
    std::cout << "\nMaster received SIGINT, forwarding to children...\n";
    for (pid_t pid : child_pids)
    {
        if (kill(pid, 0) == 0)
        { // check if child still exists
            kill(pid, SIGINT);
        }
    }

    // Reap children
    for (pid_t pid : child_pids)
    {
        int status;
        waitpid(pid, &status, 0);
    }

    std::cout << "All children cleaned up. Master exiting.\n";
    exit(0);
}

int main()
{
    signal(SIGINT, sigint_handler);

    for (int i = 0; i < 2; ++i)
    {
        pid_t pid = fork();
        if (pid < 0)
        {
            std::cerr << "fork failed\n";
            return 1;
        }
        else if (pid == 0)
        {
            // Child process
            std::cout << "Child " << getpid() << " started.\n";
            while (true)
            {
                pause(); // wait for signals
            }
        }
        else
        {
            // Master stores child PID
            child_pids.push_back(pid);
        }
    }

    std::cout << "Master PID: " << getpid() << ", children started.\n";

    // Master loop
    while (true)
    {
        pause(); // wait for signals
    }

    return 0;
}
```
