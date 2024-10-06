import subprocess
import argparse
from dataclasses import dataclass

extensions = {
    "vim": "vscodevim.vim",
    "copilot": "GitHub.copilot-chat",
    "python": "ms-python.python",
    "jupyter": "ms-toolsai.jupyter",
}

def main(args):
    base_cmd = "code" if not args.insiders else "code-insiders"

    for name, ext in extensions.items():
        print(f'Installing {name} extension...')
        result = subprocess.run([base_cmd, "--install-extension", ext], check=True, capture_output=True, text=True)
        if args.debug:
            print(result.stdout)
        if result.stderr:
            print(result.stderr)

    print('✅ Done')


if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('--insiders', action='store_true', help='Enable insiders edition', default=False)
    parser.add_argument('--debug', action='store_true', help='Enable debug mode', default=False)
    args = parser.parse_args()
    main(args)