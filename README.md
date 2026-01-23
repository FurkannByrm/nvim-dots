Using Neovim special template:

Requirements:

sudo apt update && sudo apt install -y \
    neovim \
    git \
    curl \
    build-essential \
    gdb \
    clangd \
    python3-pip

# Backup existing config if it exists
mv ~/.config/nvim ~/.config/nvim.bak 2>/dev/null

# Clone this repo
git clone https://github.com/YOUR_USERNAME/REPO_NAME ~/.config/nvim

# Open Neovim
nvim


Key,Action
Space + e,Toggle File Explorer (Neo-tree)
a / d / r,(Inside Neo-tree) Create / Delete / Rename
Ctrl + h/j/k/l,Navigate between split windows
Ctrl + \,Toggle Floating Terminal


Key,Action
Space + b,Toggle Breakpoint
F5,Start / Continue Debugging
F10,Step Over
F11,Step Into



For CMake Projects:

Run this in your project root:
Bash

cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=ON .
ln -s build/compile_commands.json .

For ROS2 Projects:

colcon build --cmake-args -DCMAKE_EXPORT_COMPILE_COMMANDS=ON
ln -s build/YOUR_PACKAGE_NAME/compile_commands.json .

Here is the comprehensive Neovim Cheat Sheet in English. This covers every feature we've configured so far, tailored for your C++ and Robotics workflow.

1. File Management (Neo-tree)

Press <leader>e (Space + e) to open the sidebar. While the cursor is in the explorer:
Key	Action
a	Add a new file (add / at the end for a directory, e.g., src/)
d	Delete file or directory
r	Rename file or directory
x	Cut (First step to move a file)
c	Copy file
p	Paste (Moves or copies the file to the selected folder)
y	Copy Path of the file
H	Toggle Hidden files (.git, .clangd, etc.)

2. Windows & Navigation

Manage your screen layout and jump between splits:
Key / Command	Action
:vsplit	Split window vertically (side-by-side)
:split	Split window horizontally
Ctrl + h	Move to the window on the left
Ctrl + l	Move to the window on the right
Ctrl + j	Move to the window below
Ctrl + k	Move to the window above

3. Code Editing & Movement

Standard Vim movements and the custom shortcuts we added for efficiency:
Key	Action
Alt + j	Move current line or selection down
Alt + k	Move current line or selection up
gcc	Toggle Comment for a single line
gc	(Visual mode) Toggle Comment for the selected block
A	Go to end of line and enter Insert Mode
o / O	Open a new line below / above and enter Insert Mode
u / Ctrl + r	Undo / Redo
 4. C++ Intelligence (LSP & Trouble)

Use these to understand code structure and fix errors:
Key	Action
Space + d	Show full Diagnostic (error/warning) message in a popup
]d / [d	Jump to the next / previous error in the file
Space + xx	Trouble: Open a list of all errors in the whole project
gd	Go to Definition (Jump to where a function/variable is defined)
K	Show Documentation (hover) for the symbol under cursor
5. GDB Debugging (DAP)

Control your C++ execution line-by-line:
Key	Action
Space + b	Toggle Breakpoint
F5	Start debugging or Continue to next breakpoint
F10	Step Over (Next line, don't enter functions)
F11	Step Into (Enter the function)
6. Terminal & Shell Commands

Run builds and execute code without leaving the editor:
Key / Command	Action
Ctrl + \	Toggle Floating Terminal
:! <command>	Run a shell command once (e.g., :!make or :!g++ main.cpp)

i (insert): 
a (append):
o (open): İ
