import shutil
import os
import platform
import subprocess

system = platform.system()
home_dir = os.getenv("HOME") if os.getenv("HOME") is not None else None
if home_dir is None:
    print("HOME variable not set up, quitting installation.")
    exit()
dotfile_dir = os.path.join(home_dir, "dotfiles")
if system != "Windows":
    print("Platform is " + system)
    home_dir = os.getenv("HOME")
    if home_dir is not None:
        p = subprocess.run(
            ["bash", os.path.join(home_dir, "dotfiles", "setup")],
        )
        exit()
programs = next(os.walk("."))[1]
for program in programs:
    if shutil.which(program) is not None:
        print("installing " + program)
    if program == "nvim":
        print("Hello")
    else:
        print(program + " is not installed, quitting...")


def setup_vim(home_dir: str, dotfile_dir: str) -> None:
    if os.path.isfile(os.path.join(home_dir, "_vimrc")) is False:
        os.symlink(
            os.path.join(dotfile_dir, "vim", ".vimrc"), os.path.join(home_dir, "_vimrc")
        )
    elif (
        os.path.isfile(os.path.join(home_dir, "_vimrc"))
        and os.path.islink(os.path.join(home_dir, "_vimrc")) is False
    ):
        shutil.move(
            os.path.join(home_dir, "_vimrc"), os.path.join(home_dir, "_vimrc.bak")
        )
        print("your .vimrc have been backed up in _vimrc.bak.")
        os.symlink(
            os.path.join(home_dir, "vim", ".vimrc"), os.path.join(home_dir, "_vimrc")
        )
    else:
        print("Vim is already set up, quitting")
