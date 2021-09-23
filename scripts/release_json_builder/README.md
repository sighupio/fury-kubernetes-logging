
# Release JSON builder

This script generates a JSON containing all the info of the components that can be
deployed as a part of this module. The script parse through the `katalog`
directory looking for all the base directories with a `kustomization` file. The
assumption is that each sub-directory of the `katalog` will be a component and
all the resource under that component can be deployed recursively using the
`kustomization` there.

The script is indented to be run when a new release is made, so a file of the
name `canonical-definition-<module_name>-<version>` will be created.

The script basically generates a rendered output by building all the
`kustomization` base directories. This rendering is parsed through resource by
resource to gather necessary information about it. Currently we ignore certain
kind of resources due to the lack of sub-component versioning. These resources are:

``` python
    "Namespace",
    "ClusterRole",
    "ClusterRoleBinding",
    "Secret",
    "ConfigMap",
    "Role",
    "RoleBinding"
```

The format of the JSON file output would be:

``` json
{
   "module":
   "version":
   "supportedK8sModules":
   "repoUrl":
   "docUrl":
   "components": [
        "name":
        "resources": [
            {
                "kind":
                "name":
                "apiVersion""
                "namespace":
                "containers" [
                    {
                        "image":
                        "version":
                        "upstreamImage":
                    }
                ]

            }
        ]
    ]
}
```

## Requirements

* Python >= 3.5,<= 3.9
* PyYaml  >= 5.4.1

> you can run `pip3 install -r requriments.txt` to install the `pyyaml` requirement

## Usage

``` sh
python3 json_builder <module_name> <module_version>
```

Example:

``` sh
python3 json_builder fury-kubernetes-logging v1.9.0

```

## Todo

* [ ] The changelog with clear structure of the kind of change being made is
      needed. We have to standardize the changelog creation procedure for it.
* [ ] We could externalize the logic by directly pulling modules from github.
      With this we can basically create canonical JSON for any existing tags of
      the module. With the current implementation we can only do generation from
      the latest state.
* [ ] We could change the version retrieval from the way it is now to taking it
      from the labels when he have proper labels in place.
* [ ] Add unittests for the script

