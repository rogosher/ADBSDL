x86_64-w64-mingw32-g++ main.cpp -o a.exe

x86_64-w64-mingw32-g++ main.cpp -mwindows -o b.exe

x86_64-w64-mingw32-g++ main.cpp -Wl,-subsystem,windows -o c.exe
