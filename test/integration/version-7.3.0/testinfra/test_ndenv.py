import pytest
import testinfra

# testinfra uses 'docker exec -ti x /bin/sh -c' to execute each command, so
# each command is run in a non-interactive non-login shell. As such, none of
# the usual profile scripts are executed to be able to set up the environment.
ndenv = '~/.ndenv/bin/ndenv'

def test_folder_exists(File):
    assert File('/root/.ndenv').exists

@pytest.mark.parametrize("name", [
    ("grunt"),
    ("gulp"),
])
def test_ndenv_packages(Command, name):
    cmd = Command(ndenv + " which " + name)
    assert cmd.rc == 0

def test_ndenv_version(Command):
    cmd = Command(ndenv + " version")
    assert cmd.rc == 0
