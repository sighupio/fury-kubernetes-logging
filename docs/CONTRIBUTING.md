# Contributing

Read the following guide about how to contribute to this project and get
familiar with.

## Concepts

All the KFD modules have the same base structure:

```
.
├── docs
│  ├── COMPATIBILITY_MATRIX.md
│  ├── CONTRIBUTING.md
│  └── releases
│     ├── vX.X.X.md
│     └── vX.X.X.md
├── examples
├── katalog
├── modules
├── LICENSE
└── README.md
```

The `katalog` folder contains all the `packages` for the module in the form of `kustomize` bases.
The `modules` folder contains all the `packages` for the module in the form of `terraform` modules.
The `docs` folder contains general documentation for the module, and all the releases changelog.
The `examples` folder contains examples of how to use the packages inside the module.

## Module maintenance

The module follows the semantic versioning [specification](https://semver.org/spec/v2.0.0.html).
Addition and removal of packages is done by the Module Owner. All the contributions on existing packages are welcome.

### Release cycle

The module will be released on a regular basis. Every 4 months a new version will be released to be compatible with the latest
Kubernetes version and 2 or 3 old versions.
Every two months a maintenance release will be made to fix bugs and improve the module.

There can be also additional releases if needed.

### Update COMPATIBILITY_MATRIX.md

Every time a new version of the module is released, the `COMPATIBILITY_MATRIX.md` file should be updated.
This file contains a compatibility matrix between Kubernetes versions and the module versions.

Everytime a new patch version is released, the `COMPATIBILITY_MATRIX.md` file should be updated putting a waring on the
affected Module versions.

If there are additional changes to be made aware of, the "Warning" list should also be updated.

## Package maintenance and development

Each package inside the `katalog` folder is a `kustomize` base.

Basic rules:

- `README.md` file should always be present, describing what the package is and how to use it.
- `MAINTENANCE.md` file should always be present, describing the package maintenance specifying what to do to upgrade the package.
- If possible, add a Prometheus `ServiceMonitor` to the component if metrics are exported.
- If possible, add a Grafana dashboard for the component using the ConfigMap approach: [add-new-dashboards][add-new-dashboards].
- All the images in the module should be pushed to the sighup registry using our [image-sync repository][image-sync-repository].

## CI explanations

Each module repository contains a `.drone.yml` file with some automatic static checks and e2e tests to be run on each push/tag event.

### Static testing

The static testing is composed of the following parts:

1) Check if all the yaml files have the copyright header on top.
2) Linting testing, using our policeman image based of github/super-linter upstream image to lint the code.
3) Testing all the packages and builtding the final yaml using `kustomize build <package-path>`. 
4) Testing the final yamls files against deprecations using `swade1987/deprek8ion`.

### E2E testing

To test module in a real Kubernetes cluster, there are 3 to 4 pipelines in the `.drone.yml` definition that tests all
the packages against the latest 3-4 versions of Kubernetes.

The technology used to bring up clusters is a combination of terraform and kind clusters.

The testing is executed via `bats` tests, usually the tests definition are in the `katalog/tests/` folder.

### Release step

In a tag event, the module, after passing all the static and e2e tests will be prepared for the release. The tag must be a `vX.X.X` or, in the case of a release candidate
a `vX.X.X-rcX` version. 
If the tag is a stable one, a release will be made. Otherwise, a pre-release will be made.

## Support Makefile

In each module, there is a `Makefile` file that defines some useful command that can be run on the repository.
Run `make help` to see all the available commands.

<!-- Links -->

[add-new-dashboards]: https://github.com/sighupio/fury-kubernetes-monitoring/tree/master/katalog/grafana#add-new-dashboards
[image-sync-repository]: https://github.com/sighupio/fury-distribution-container-image-sync
