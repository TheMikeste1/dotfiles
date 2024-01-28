#!/usr/bin/env python3

import logging
import os

from pathlib import Path
from typing import List

logging.basicConfig(format="%(levelname)s: %(message)s", level=logging.INFO)


def get_list_of_files_and_directories(path: Path) -> List[Path]:
    paths: List[Path] = []
    for file_or_directory in path.iterdir():
        if file_or_directory.is_dir() and not Path(file_or_directory / ".dotfiles_include").exists():
            subpaths = get_list_of_files_and_directories(file_or_directory)
            paths.extend(subpaths)
        else:
            paths.append(file_or_directory)
    return paths


def main():
    # Change into the repository's "home" directory
    dotfiles_dir = os.getenv("DOTFILES")
    os.chdir(f"{dotfiles_dir}/home")

    # Get the list of all the files and directories we want to symlink
    dotfile_paths = get_list_of_files_and_directories(Path("."))

    # Create the symlinks
    user_home = Path.home()
    for dotfile_path in dotfile_paths:
        symlink_path = user_home / dotfile_path
        dotfile_path = dotfile_path.resolve()

        # Check if the symlink already exists
        if symlink_path.exists():
            # Check if it's a symlink or an actual file/directory
            if not symlink_path.is_symlink():
                # Log a warning
                logging.warning(f'"{symlink_path}" already exists and is not a symlink. Skipping.')
            else:
                # Check if the symlink points to the correct file/directory
                if symlink_path.resolve() != dotfile_path:
                    # Log a warning
                    logging.warning(
                        f'"{symlink_path}" already exists and points to a different file/directory. Skipping.'
                    )
                    continue
                logging.info(f'"{symlink_path}" already exists. Skipping.')

        else:
            # Check if the parent directory exists
            if not symlink_path.parent.exists():
                # Create the parent directory
                symlink_path.parent.mkdir(parents=True)
                logging.info(f"Created directory {symlink_path.parent}")
            # Create the symlink
            symlink_path.symlink_to(dotfile_path, target_is_directory=dotfile_path.is_dir())
            logging.info(f"Created symlink {symlink_path} -> {dotfile_path}")


if __name__ == "__main__":
    # Change into the correct directory
    if Path(__file__).parent != Path.cwd():
        os.chdir(Path(__file__).parent)
    main()
