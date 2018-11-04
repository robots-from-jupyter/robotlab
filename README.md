# RobotLab: Building the _Robots from Jupyter_ Workshop Installer

## Build It
Get [Miniconda][]. Install [anaconda-project][].

On Linux, run:
```bash
anaconda-project run build
anaconda-project run test
```

On Windows, run:
```bash
anaconda-project run winbuild
anaconda-project run wintest
```

> TODO: On OSX, run:
```bash
anaconda-project run macbuild
anaconda-project run mactest
```


## Motivation

While Robot Framework has no dependencies beyond the Python standard library,
using it for non-trivial testing or process automation usually requires a fair
amount of additional Python dependencies, and even some more exotic ones.

As the focus of this workshop, using [robotkernel][] requires the Jupyter stack,
and to demonstrate some of its more advanced features, some fairly extensive
extra libraries from both the Robot Framework and the scientific Python ecosystems.

To make a three-hour workshop reasonable, this repo uses [conda][] and
[constructor][] to build single-file installers for multiple platforms, reducing
the per-participant install time to a minimum, and make sneaker-net distribution
possible in the event that network problems arise.


## conda
Once it has matured, `robotkernel` and its dependencies will be available from
[conda-forge][], the community-driven upstream of the Anaconda Distribution.
However, in the name of efficiency, `conda-forge` builds `noarch: python`
packages, which are not compatible with `constructor`'s multiplatform magic.

So for these installers, we build (or rebuild) a number of dependencies.

### robotlab
While still pre-`1.0`, JupyterLab's build chain has some negative externalities
for end users, namely an install- or run-time dependency on NodeJS and npmjs.org
when using any labextensions other than the built in set (e.g. Notebook, Terminal,
Console, Editor, etc.). Because, for the purposes of the workshop, we want to
get to the Good Stuff of running Robot notebooks and not spend a bunch of time
debugging `nodejs` and `webpack`, we've added a few choice JupyterLab extensions:

- `jupyterlab_robotmode`: syntax highlighting for Robot Framework
- `@jupyterlab/toc`: a table of contents pane for Markdown headers
- `@jupyter-widgets/jupyterlab-manager`: because widgets are always good

and wrapped them into a new command, which can do most of the things
`jupyter lab` can do.

`robotlab` works like `jupyter lab`, while `robotlab-extension` works like
`jupyter labextension`. This isn't a toy installation: with `nodejs`, you can
still install any of the [labextensions][] that are compatible with the
version `robotlab` was built with: as of writing, `0.35.x`.

## [constructor][]
Once we have all our dependencies captured in `environment.yml`, we use this
to build a `construct.yml`.


[anaconda-project]: https://github.com/anaconda-platform/anaconda-project
[conda-forge]: https://github.com/conda-forge
[conda]: https://github.com/conda/conda
[constructor]: https://github.com/conda/constructor
[labextensions]: https://www.npmjs.com/search?q=keywords:jupyterlab-extension
[Miniconda]: https://conda.io/miniconda.html
[robotkernel]: https://github.com/datakurre/robotkernel
