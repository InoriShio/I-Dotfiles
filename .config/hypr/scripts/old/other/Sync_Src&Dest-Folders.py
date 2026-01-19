import os
from datetime import datetime
import shutil
import re

FOLDERS = [
    "/home/inorishio/.config/nvim/",
    "/home/inorishio/.config/hypr/",
    "/home/inorishio/.config/yay",
    "/home/inorishio/.config/zshrc/",
    "/home/inorishio/.config/zellij/",
    "/home/inorishio/.config/ohmyposh/",
    "/home/inorishio/.config/fastfetch/"
]
GITREPO = "/home/inorishio/Documents/Git/Hyprland/Programs/"

EXCLUDE_PATTERN = re.compile(r'.*\.git$')

def get_file_date(filepath):
    return os.path.getmtime(filepath)

def sync_folders():
    for folder in FOLDERS:
        if not os.path.exists(folder):
            continue
            
        for root, _, files in os.walk(folder):
            for file in files:
                source_path = os.path.join(root, file)
                
                # Apply regex pattern to exclude files
                if EXCLUDE_PATTERN.match(file):
                    continue
                
                # Create corresponding path in GITREPO
                relative_path = os.path.relpath(source_path, folder)
                dest_path = os.path.join(GITREPO, relative_path)
                
                # Ensure destination directory exists
                os.makedirs(os.path.dirname(dest_path), exist_ok=True)
                
                try:
                    # Compare modification times
                    if os.path.exists(dest_path):
                        source_time = get_file_date(source_path)
                        dest_time = get_file_date(dest_path)
                        
                        if source_time > dest_time:
                            shutil.copy2(source_path, dest_path)
                        elif dest_time > source_time:
                            shutil.copy2(dest_path, source_path)
                    else:
                        # If file doesn't exist in destination, copy it
                        shutil.copy2(source_path, dest_path)
                except Exception as e:
                    print(f"Error copying file {source_path} to {dest_path}: {e}")

if __name__ == "__main__":
    sync_folders()
