# RobotLab [![Build Status][build-badge]][build-status]

> A one-click installer for [Robot Framework][robotframework],
  [JupyterLab][jupyterlab], [Firefox][], and Friends

## Get RobotLab
Start the download now for your platform:

### [Linux][] | [MacOSX][] | [Windows][]

> ... or view the [release notes][release-notes].

[Linux]: https://github.com/robots-from-jupyter/robotlab/releases/download/v2019.9.0/RobotLab-2019.9.0-Linux-x86_64.sh
[MacOSX]: https://github.com/robots-from-jupyter/robotlab/releases/download/v2019.9.0/RobotLab-2019.9.0-MacOSX-x86_64.sh
[Windows]: https://github.com/robots-from-jupyter/robotlab/releases/download/v2019.9.0/RobotLab-2019.9.0-Windows-x86_64.exe
[release-notes]: https://github.com/robots-from-jupyter/robotlab/releases/tag/v2019.9.0

## Install RobotLab
> You'll want at least 2GB available to install and run RobotLab

- On Windows, double-click the installer
  - We recommend:
    - _don't_ add RobotLab to your `PATH`
    - _don't_ register RobotLab's python
- On Linux/MacOSX
  - `bash RobotLab-*.sh`
    - follow the prompts
    - _don't_ install into your shell

> **Remember** where you install RobotLab!
>
>  We recommend someplace
  - **short**, e.g. `C:\robotlab` or `/home/myuser/robotlab`
  - with **no spaces** in the path, e.g. ~~`c:\Robot Lab`~~
  - **not shared** on something like Dropbox, or a network drive


## Run RobotLab
During installation, RobotLab will try to create a desktop icon:
<img width="32" src="./robotlab/src/robotlab/icons/lab.svg" style="float"/>

### _There is an icon on my desktop/menu_
Click it to launch the RobotLab server in a console window. It will also attempt
to launch the bundled Firefox. The application log will keep running in the
background, and sometimes useful information will appear there.

### _Nope, no icon here_
If you don't see an icon, launch a console, e.g. `bash` on Linux/MacOSX or
`cmd.exe` on Windows.

| | Linux/MacOSX |  Windows
|--|-|
| start a prompt | open your terminal or console application | open `cmd.exe` from the start menu |
| activate the robotlab environment | type `source /path/to/robolab/bin/activate` <br/> press <kbd>ENTER</kbd> |  type `c:\path\to\robotlab\Scripts\activate` <br/> press <kbd>ENTER</kbd>
| start robotlab | type `robotlab`<br/> press <kbd>ENTER</kbd> | type `robotlab` <br/> press <kbd>ENTER</kbd>

## _Still didn't work_
If you're still stuck, open [an issue][robotlab-issues]. There should be some
template information to provide.

## Advanced RobotLab Commands and Invocations
```bash
# assuming you've already `activate`d
robotlab [.]               # basically just jupyterlab
robotlab-tutorial [.]      # copy the robotkernel tutorial to this directory
robotlab-examples [.]      # "    "   "           examples "  "    "
robotlab-shortcuts
```

## Uninstall RobotLab
- Delete the installation directory.
- Delete any desktop shortcuts.
- That is all.

## Motivation
While [Robot Framework][robotframework] has no dependencies beyond the Python
standard library, using it for non-trivial testing or process automation usually
requires a fair number of additional Python dependencies, and even some more
exotic ones. We wanted to run a workshop for [RoboCon][] 2019 and show interactive
editing/running with [robotkernel][].

The focus of this workshop, running Robot tests and tasks interactively, required
the Jupyter stack. To demonstrate some of its more advanced features, some fairly
extensive extra libraries from both the Robot Framework and the scientific Python
ecosystems were needed, and getting these to install smoothly on every attendee's
computers can prove to be... interesting.

To make a three-hour workshop reasonable, we needed a distribution approach that
was:
- easy to start, to that we could get to the Good Stuff
- cross-platform, so that everyone could follow along
- self-contained, so that it could be easily removed
- offline-capable, so that we could handle intermittent network access
- hackable by the user, so that we could fix Surprise Features

> ### _Field Notes_
>
> _At our 2019 workshop, graciously hosted by [Silli][], (whose network was super fast!)
> our room full of attendees, on three distributions of Linux, two versions of MacOSX
> and two versions of Windows were all up and running in under 30 minutes. We got
> through all of the [tutorial][] before lunch!_

## Tools
RobotLab is built with:
- [conda][], an OS-agnostic package manager
- [anaconda-project][], a multi-environment manager and command executor
- [conda-build][], the conda package builder
- [constructor][conda-constructor], the installer-builder of conda packages
- [azure pipelines][azure-pipelines], a continuous integration provider


## conda packaging
Once it has matured, `robotkernel` will be available from [conda-forge][], the
community-driven upstream of the Anaconda Distribution, which is also built
with [constructor][conda-constructor].

So for the RobotLab installers, and supporting examples and tutorials, we need to
build a number of dependencies.

### robotlab
[JupyterLab][]'s build chain has some negative externalities
for end users, namely an install- or run-time dependency on NodeJS and npmjs.org
when using any labextensions other than the built-in set (e.g. Notebook, Terminal,
Console, Editor, etc.). Because, for the purposes of the workshop, we want to
get to the Good Stuff of running Robot notebooks and not spend a bunch of time
debugging `nodejs` and `webpack`, we've added a few choice JupyterLab extensions:

- `jupyterlab_robotmode`: syntax highlighting for Robot Framework
- `@jupyterlab/toc`: a table of contents pane for Markdown headers
- `@jupyter-widgets/jupyterlab-manager`: because widgets are always good

All of these are built outside of the `conda-build` cycle.

This asset, and all our dependencies, are wrapped into a conda package which
exposes some useful commands, which can do most of the things `jupyter lab` can do,
as well as create desktop shortcuts, and unpack the tutorial content.

`robotlab` works like `jupyter lab`, while `robotlab-extension` works like
`jupyter labextension`. This isn't a toy installation: with the bundled `nodejs`,
an intrepid user can still install any of the [labextensions][] that are
compatible with the version `robotlab` was built with: as of writing, `1.1.x`.

## [constructor][conda-constructor]
All of the dependencies are captured in [construct.yaml.in][].
In addition to required dependencies, a number of extra libraries are included to
showcase some of the features of using Robot Framework interactively.
- `JupyterLibrary` for testing Jupyter clients with robotframework
- `SeleniumLibrary` for controlling browsers
  - `geckodriver` for interacting with...
    - `firefox`, the open source web browser
- `opencv` for image-driven testing
- `RESTInstance` for testing REST APIs, including swagger

## On Browsers and WebDrivers
RobotLab includes Mozilla Firefox and `geckodriver`, with versions that will be
supported for _years_, not _weeks_, by a team that is committed to open source
and web standards.

### webdriver for Microsoft Internet Explorer
It's pretty easy to [get `webdriver`][webdriver] for Microsoft Edge, but...
  - it but can't be redistributed
  - it has to match the version of Edge/Explorer exactly

### chromedriver for Google Chrome
It's also pretty easy to get [chromedriver][] for Google Chrome, but...
  - it has to match the version of Chrome exactly

# Work On RobotLab
Contributions are welcome! See the [issues][] for outstanding work we've been
discussing.

> - Get [Miniconda][]
> - Install [anaconda-project][]
> - Clone [this repo][robotlab]

From the command line e.g. `bash` or `cmd.exe` or the `Anaconda Prompt`, run:
```bash
anaconda-project run build:lab
anaconda-project run build
```

## Test Robotlab
```bash
anaconda-project run test
```

## Checking RobotLab

```bash
anaconda-project run lint
anaconda-project run integrity
```

[anaconda-project]: https://github.com/anaconda-platform/anaconda-project
[azure-pipelines]: https://azure.microsoft.com/en-us/services/devops/pipelines/
[build-badge]: https://dev.azure.com/robots-from-jupyter/robots-from-jupyter/_apis/build/status/robots-from-jupyter.robotlab?branchName=master
[build-status]: https://dev.azure.com/robots-from-jupyter/robots-from-jupyter/_build/latest?definitionId=3?branchName=master
[chromedriver]: https://chromedriver.chromium.org/downloads
[conda-build]: https://github.com/conda/conda-build
[conda-constructor]: https://github.com/conda/constructor
[conda-forge]: https://github.com/conda-forge
[conda]: https://github.com/conda/conda
[construct.yaml.in]: ./constructor/construct.yaml.in
[Firefox]: https://www.mozilla.org/en-US/firefox/
[jupyterlab]: https://jupyterlab.readthedocs.io
[labextensions]: https://www.npmjs.com/search?q=keywords:jupyterlab-extension
[Miniconda]: https://conda.io/miniconda.html
[RoboCon]: https://robocon.io
[robotframework]: https://github.com/robotframework/robotframework
[robotkernel]: https://github.com/robots-from-jupyter/robotkernel
[robotlab]: https://github.com/robots-from-jupyter/robotlab
[robotlab-issues]: https://github.com/robots-from-jupyter/robotlab/issues
[Silli]: https://siili.com
[tutorial]: https://github.com/robots-from-jupyter/robotkernel/tree/master/docs/notebooks
[webdriver]: https://developer.microsoft.com/en-us/microsoft-edge/tools/webdriver/#downloads
