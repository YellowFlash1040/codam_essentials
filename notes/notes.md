### 1
Tutorial for Makefiles: https://makefiletutorial.com/

### 2
Memory leak checks:
valgrind --leak-check=full ./

### 3
command to get all of the .c file names inside current directory for the debugger:
```bash
ls *.c | sed 's/\(.*\)/"\1",/'
```

### 4
to run VSCode on a github repo you can change the link from:
https://github.com/user/repo
to:
https://github1s.com/user/repo
or
https://github.dev/user/repo

### 5
If you want to install something on a 42 school computer you can use:  
`capt` instead of `apt`, but you need to install it first if you don't have it yet:  
[Github Link](https://github.com/codam-coding-college/codam-apt)


### 6
Automatic brightness enable/disable:  
`gsettings get org.gnome.settings-daemon.plugins.power ambient-enabled` - check whether it is activated  
`gsettings set org.gnome.settings-daemon.plugins.power ambient-enabled false` - turn it off  
`gsettings set org.gnome.settings-daemon.plugins.power ambient-enabled true` - turn it on  

Manually Adjust Brightness  
If your display supports manual brightness control, you can adjust it in `Settings` > `Power` > `Power saving options` > `Automatic Screen Brightness`.  
If you're using an external monitor without brightness control, you might need tools like ddcutil to adjust brightness.  