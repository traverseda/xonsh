$PROJECT = $GITHUB_ORG = $GITHUB_REPO = 'xonsh'
$WEBSITE_URL = 'http://xon.sh'
$ACTIVITIES = ['version_bump', 'changelog', 'pytest',
               'sphinx', #'tag', 'pypi', 'conda_forge', 'ghpages', 'ghrelease'
               ]

$VERSION_BUMP_PATTERNS = [
    ('.appveyor.yml', 'version:.*', 'version: $VERSION.{build}'),
    ('xonsh/__init__.py', '__version__\s*=.*', "__version__ = '$VERSION'"),
    ]
$CHANGELOG_FILENAME = 'CHANGELOG.rst'
$CHANGELOG_TEMPLATE = 'TEMPLATE.rst'

#$PYTEST_COMMAND = "rm -r .cache/ __pycache__/ */__pycache__ */*/__pycache__ && pytest"

$TAG_REMOTE = 'git@github.com:xonsh/xonsh.git'
$TAG_TARGET = 'master'

$GHPAGES_REPO = 'git@github.com:scopatz/xonsh-docs.git'

$DOCKER_APT_DEPS = ['man']
with open('requirements-tests.txt') as f:
    conda_deps = f.read().split()
with open('requirements-docs.txt') as f:
    conda_deps += f.read().split()
conda_deps = {d.lower().split('=')[0] for d in set(conda_deps)}
conda_deps.discard('prompt-toolkit')
conda_deps |= {'prompt_toolkit', 'pip', 'psutil', 'numpy', 'matplotlib'}
$DOCKER_CONDA_DEPS = sorted(conda_deps)
$DOCKER_INSTALL_COMMAND = ('rm -rf .cache/ __pycache__/ */__pycache__ */*/__pycache__ build/ && '
                           './setup.py install')
$DOCKER_GIT_NAME = 'xonsh'
$DOCKER_GIT_EMAIL = 'xonsh@googlegroups.com'
