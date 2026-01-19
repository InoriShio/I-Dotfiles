import os
import shutil
import re
import subprocess

FOLDERS = [
    "/home/inorishio/.config/hypr/",
    "/home/inorishio/.config/zshrc/",
    "/home/inorishio/.config/ohmyposh/",
    "/home/inorishio/.config/fastfetch/",
    "/home/inorishio/.config/uwsm/",
    "/home/inorishio/.config/waybar/",
    "/usr/share/sddm/themes/inorishio-theme/",
    "/home/inorishio/.config/foot/",
    "/home/inorishio/NVML/",
    "/home/inorishio/.config/rofi/",
    "/home/inorishio/.config/swaync/",
    "/home/inorishio/.config/swayimg/",
    "/home/inorishio/.config/quickshell/",
]
GITREPO = "/home/inorishio/Documents/Git/Hyprland/Programs/"

EXCLUDE_PATTERN = re.compile(r'.*\.git$')

def get_file_date(filepath):
    return os.path.getmtime(filepath)

def sync_folders():
    all_files_in_repo = set()
    
    # Track existing files in the GITREPO
    for root, _, files in os.walk(GITREPO):
        for file in files:
            if EXCLUDE_PATTERN.match(file):
                continue
            relative_path = os.path.relpath(os.path.join(root, file), GITREPO)
            all_files_in_repo.add(relative_path)
    
    for folder in FOLDERS:
        if not os.path.exists(folder):
            continue
            
        base_folder_name = os.path.basename(os.path.normpath(folder))
        
        for root, _, files in os.walk(folder):
            for file in files:
                source_path = os.path.join(root, file)
                
                if EXCLUDE_PATTERN.match(file):
                    continue
                
                relative_path = os.path.relpath(source_path, folder)
                dest_path = os.path.join(GITREPO, base_folder_name, relative_path)
                
                os.makedirs(os.path.dirname(dest_path), exist_ok=True)
                
                try:
                    if os.path.exists(dest_path):
                        source_time = get_file_date(source_path)
                        dest_time = get_file_date(dest_path)
                        
                        if source_time > dest_time:
                            shutil.copy2(source_path, dest_path)
                        elif dest_time > source_time:
                            shutil.copy2(dest_path, source_path)
                    else:
                        shutil.copy2(source_path, dest_path)
                    
                    all_files_in_repo.discard(os.path.join(base_folder_name, relative_path))
                except Exception as e:
                    print(f"Error copying file {source_path} to {dest_path}: {e}")
    
    for remaining_file in all_files_in_repo:
        try:
            os.remove(os.path.join(GITREPO, remaining_file))
        except Exception as e:
            print(f"Error removing file {remaining_file} from {GITREPO}: {e}")

def push_to_github():
    try:
        subprocess.run(['git', 'add', '.'], cwd=GITREPO, check=True)
        subprocess.run(['git', 'commit', '-m', 'Sync folders'], cwd=GITREPO, check=True)
        subprocess.run(['git', 'push'], cwd=GITREPO, check=True)
    except subprocess.CalledProcessError as e:
        print(f"Error pushing to GitHub: {e}")

if __name__ == "__main__":
    sync_folders()
    push_to_github()
