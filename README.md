# Build instructions

```sh
conda install conda-build
conda build .
```

By default, this will build the latest commit on the `master` branch of the
[`sci-bots/microdrop-3`][md3].


# Customizing version

## Custom commit/branch

Modify `{% set COMMIT = "..." %}` line in `meta.yaml`.

## Custom `git` source

Modify `git_url: ...` line in `meta.yaml`, e.g.:

    git_url: C:\Users\...\microdrop-3


[md3]: https://github.com/sci-bots/microdrop-3
