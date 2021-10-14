# Contribution

Read the following guide about how to contribute to this project and get
familiar with.

## Make

This project contains an easy-to-use interface with a `Makefile`. It allows you
to pass all the checks the pipeline will pass on certain events. So it worth get
familiar with all the targets. To know what targets are available in the project
just run:

```bash
$ make list

 Choose a command to run in fury-kubernetes-logging:

  version                       lists the latest version of tool
  bump-major                    Bumps the module up by a major version
  bump-minor                    Bumps the module up by a minor version
  bump-patch                    Bumps the module up by a patch version
  check-label                   Check if labels are present in all kustomization files
  add-license                   Add license headers in all files in the project
  lint                          Run the policeman over the repository
  deploy-all                    Deploys all the components in the logging module (with curator-s3 and elasticsearch-triple)
  deploy-curator                Deploys the `curator` component in the cluster
  deploy-curator-s3             Deploys the `curator-s3` component in the cluster
  deploy-elasticsearch-single   Deploys the `elasticsearch-single` component in the cluster
  deploy-elasticsearch-triple   Deploys the `elasticsearch-triple` component in the cluster
  clean-%                       Clean the container image resulting from another target.
  build-canonical-json          Build a canonical JSON for any tag of module, only to be run inside a clean working directory
```

## bump-version (Release process)

`bump-%v` targets is the recommended way of creating a new release in this
module. This target internally uses
[`bump2version`](https://github.com/c4urself/bump2version/#installation) to bump
the versions of the module in the `examples` directory and the `kustomization`
labels. Then it creates the tag corresponding to the target chosen. We follow
semantic versioning and following is the criteria for versions:

- `bump-major`: Bumps up a major version, i.e. from 1.x.y -> 2.0.0
- `bump-major`: Bumps up a major version, i.e. from x.2.y -> x.2.0
- `bump-patch`: Bumps up a patch version, i.e. from x.y.2 -> x.y.3

Before bumping the version, make sure you have a file in the directory
`docs/releases/` with the name of the new tag to be created. That is if you are
planning to make a patch release to version `v1.9.2`, create a file
`docs/releases/v1.9.2.md` with the release notes. You can see an example
[here](releases/v0.1.0.md). Commit all the change with appropriate commit messages.

Then, in order to release it(assuming from version `1.9.1` to `1.9.2` - so a
patch release):

```bash
$ make bump-patch
Making a patch tag
$ git push --tags origin master
# This should trigger the drone pipeline to publish the new release with the release notes from the file created.
```

## lint

To ensure the code-bases follow a standard, we have automated pipelines testing
for the linting rules. If one has to test if the rules are respected locally,
the following command can be run:

```bash
$ make lint
# This will use a dockerised super-linter library to run linting
```

## add-license

We ensure all of our files are LICENSED respecting the community standards. The
automated drone pipelines fail, if some files are left without license. To add
our preferred license(BSD clause-3), one could locally run:

```bash
$ make add-license
# This will use a dockerised `addlicense` library to run linting
```

## clean-%v

The `clean-%v` target has been designed to remove the local built image
resulting from the different targets in the [`Makefile`](Makefile).

The main reason to implement this target is to save disk space. `clean-%v`
target is automatically called in the targets `lint` and `add-license`.

## Check-label

This targets verifies that required labels for KFD modules exist in each
kustomization file in the repo. The list of required labels and this
check can be found
[here](https://github.com/sighupio/ci-commons/blob/main/conftest/kustomization/kfd-labels.md).

## Deploy

To deploy the components available under this module easily, some make targets
are bundled in this repo. You can see the available option in the `make help`.
To deploy a minimal working setup of this module, one could run the following
command, which in turn triggers other make targets for individual components:

```bash
$ make deploy-all
# This deploys curator-s3, elasticsearch-triple, fluentd, kibana and cerebro
```

## build-canonical-json

> Warning: run this command only inside a clean working directory.

These two targets can be used to create the canonical definition for the
module or an existing TAG. The following are the usages:

```bash
$ TAG=v1.9.1 make build-canonical-json
INFO[0000] Building JSON for: module fury-kubernetes-logging, version v1.9.1
```

The above command builds a canonical JSON parsing the version `v1.9.1`.
