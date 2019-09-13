# RobotLab

[![Build Status](https://dev.azure.com/robots-from-jupyter/robots-from-jupyter/_apis/build/status/robots-from-jupyter.robotlab?branchName=master)](https://dev.azure.com/robots-from-jupyter/robots-from-jupyter/_build/latest?definitionId=3?branchName=master)

> Building the _Robots from Jupyter_ Workshop Installer


## Build It
Get [Miniconda][]. Install [anaconda-project][].

On OSX/Linux, run:
```bash
anaconda-project run build
anaconda-project run test
```

On Windows, run:
```bash
anaconda-project run build:win
anaconda-project run test:win
```

## Motivation

While [Robot Framework][robotframework] has no dependencies beyond the Python
standard library, using it for non-trivial testing or process automation usually
requires a fair amount of additional Python dependencies, and even some more
exotic ones.

The focus of this workshop, running Robot tests and tasks interactively with
[robotkernel][], requires the Jupyter stack, and to demonstrate some of its more
advanced features, some fairly extensive extra libraries from both the Robot
Framework and the scientific Python ecosystems.

To make a three-hour workshop reasonable, this repo uses [conda][] and
[constructor][] to build single-file installers for multiple platforms, reducing
the per-participant install time to a minimum, and make sneaker-net distribution
possible in the event that network problems arise.


## conda packaging
Once it has matured, `robotkernel` will be available from [conda-forge][], the
community-driven upstream of the Anaconda Distribution.

So for these installers, and supporting exmaples, we build a number of
dependencies.

### robotlab
JupyterLab's build chain has some negative externalities
for end users, namely an install- or run-time dependency on NodeJS and npmjs.org
when using any labextensions other than the built-in set (e.g. Notebook, Terminal,
Console, Editor, etc.). Because, for the purposes of the workshop, we want to
get to the Good Stuff of running Robot notebooks and not spend a bunch of time
debugging `nodejs` and `webpack`, we've added a few choice JupyterLab extensions:

- `jupyterlab_robotmode`: syntax highlighting for Robot Framework
- `@jupyterlab/toc`: a table of contents pane for Markdown headers
- `@jupyter-widgets/jupyterlab-manager`: because widgets are always good

...and wrapped them into a conda package which exposes some command, which can
do most of the things `jupyter lab` can do.

`robotlab` works like `jupyter lab`, while `robotlab-extension` works like
`jupyter labextension`. This isn't a toy installation: with the bundled `nodejs`,
an intrepid user can still install any of the [labextensions][] that are
compatible with the version `robotlab` was built with: as of writing, `1.1.x`.

## [constructor][]
All of the dependencies are captured in [construct.yaml.in][]. In addition to
everything mentioned above, you'll also find:

In addition to required dependencies a number of extra libraries are included to
showcase some of the features of using Robot Framework interactively.
- `JupyterLibrary` for testing Jupyter clients with robotframework
  - `SeleniumLibrary` for controlling browsers
    - `geckodriver` for interacting with Mozilla Firefox 57+
- `opencv` for image-driven testing
- `robotframework-lint` for helping you write clean robot syntax
- `RESTInstance` for testing REST APIs, including swagger

## other ****drivers
### webdriver
It's pretty easy to [get `webdriver`][webdriver] for Microsoft Edge
  - it but can't be redistributed
  - it has to match the version of Edge/Explorer exactly

### chromedriver
It's also pretty easy to get [chromedriver][] for Google Chrome, but
  - it has to match the version of Chrome exactly

[anaconda-project]: https://github.com/anaconda-platform/anaconda-project
[conda-forge]: https://github.com/conda-forge
[robotframework]: https://github.com/robotframework/robotframework
[conda]: https://github.com/conda/conda
[constructor]: https://github.com/conda/constructor
[construct.yaml.in]: ./constructor/construct.yaml.in
[labextensions]: https://www.npmjs.com/search?q=keywords:jupyterlab-extension
[Miniconda]: https://conda.io/miniconda.html
[robotkernel]: https://github.com/robots-from-jupyter/robotkernel
[webdriver]: https://developer.microsoft.com/en-us/microsoft-edge/tools/webdriver/#downloads
[chromedriver]: https://chromedriver.chromium.org/downloads
