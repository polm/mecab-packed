import subprocess
from setuptools import setup
from setuptools.command.install import install as _install

def prep(binpath):
    # binpath is like env/bin if env is a venv root
    res = subprocess.check_call(["./build.sh", binpath])

class Install(_install):
    def run(self):
        prep(self.install_scripts)
        _install.run(self)

setup(name = 'mecab-packed',
       version = '0.0.3',
       description = 'Bundled Mecab and Unidic',
       author = 'Paul McCann',
       author_email = 'polm@dampfkraft.com',
       license = "WTFPL", 
       url = "https://github.com/polm/mecab-packed",
       # This only installs binary executables and data, there's no Python.
       packages = [],
       cmdclass={'install': Install}
       )
