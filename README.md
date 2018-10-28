# RobotLab: RoboCon 2019 Jupyter Workshop

While Robot Framework has no dependencies beyond the Python standard library,
using it for non-trivial testing usually requires a fair amount of additional,
non-trivial Python dependencies, and even some more exotic ones.

For this focus of this workshop, `robotkernel` also requires the Jupyter stack,
and to demonstrate some of its more advanced features, some fairly extensive
extra libraries from the scientific Python stack.

To make the insThis repo uses [conda][] and [constructor][] to build single-file installers
for multiple platforms.

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
Console, Editor, etc.).

Because, for the purposes of the workshop, we want to get to the Good Stuff
of running Robot notebooks, and not spend a bunch of time debugging NodeJS and
webpack we've added a few choice JupyterLab extensions, and wrapped them into
a new command, which can do most of the things `jupyter lab` can do:

```
robotlab
```


## constructor
Once we have all our dependencies captured,


[conda-forge]: https://github.com/conda-forge
[conda]: https://github.com/conda/conda
[constructor]: https://github.com/conda/constructor
