from configparser import ConfigParser
from pathlib import Path

parser = ConfigParser()
firefox_path = Path.home() / ".mozilla/firefox"
parser.read(firefox_path / "profiles.ini")
print(firefox_path / parser.get("Profile0", "Path"))
