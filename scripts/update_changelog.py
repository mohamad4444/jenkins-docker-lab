#!/usr/bin/env python3
import sys
import os
import re
from datetime import datetime

def main():
    if len(sys.argv) < 3:
        print("Usage: update_changelog.py <file> <version>")
        sys.exit(1)

    file_path = sys.argv[1]
    version = sys.argv[2]
    
    # Simple append for simulation
    entry = f"\n## [{version}] - {datetime.now().strftime('%Y-%m-%d')}\n- Automated version bump\n"
    
    if os.path.exists(file_path):
        with open(file_path, 'a') as f:
            f.write(entry)
    else:
        with open(file_path, 'w') as f:
            f.write("# Changelog\n" + entry)

if __name__ == "__main__":
    main()
