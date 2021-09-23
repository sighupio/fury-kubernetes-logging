#!/usr/bin/env python3

import glob
import json
import logging
import os
import pathlib
import re
import subprocess
import sys
import yaml
from typing import Union


MODULE = "fury-kubernetes-module"
VERSION = "v1.0.0"
SIGHUP_REGISTRY = "registry.sighup.io/fury/"

output_path = 'docs/releases/'
ignorable_resources = [
    "Namespace",
    "ClusterRole",
    "ClusterRoleBinding",
    "Secret",
    "ConfigMap",
    "Role",
    "RoleBinding"
]


def search(d: dict, key: str, default=None) -> Union[list, dict]:
    """Return a value corresponding to the specified key in the (possibly
    nested) dictionary d. If there is no item with that key, return
    default.
    """
    stack = [iter(d.items())]
    while stack:
        for k, v in stack[-1]:
            if isinstance(v, dict):
                stack.append(iter(v.items()))
                break
            elif k == key:
                return v
        else:
            stack.pop()
    return default


def _get_versioned_filename(path: str, basename: str, ext: str ='yaml') -> str:
    return os.path.join(path,
                        '{}-{}-{}.{}'.format(basename, MODULE, VERSION,
                                             ext))


def _get_json_file() -> str:
    return _get_versioned_filename(output_path, "canonical-definition")


def _read_yaml(stream: str):
    return yaml.safe_load(stream)


def _get_kustomization_files() -> list:
    """
     We look for the kustomization files in the immediate directory after
     `katalog` directory. The recursive ones are assumed to be included in that
     `kustomization` file
    """
    return glob.glob("katalog/**/kustomization.yaml")


def _get_specs(resource: str) -> dict:
    component_data = {}
    data = _read_yaml(resource)
    kind = data["kind"]
    if kind in ignorable_resources:
        return {}
    # gather necessary specs from the yaml file
    component_data["apiVersion"] = data["apiVersion"]
    component_data["kind"] = kind
    metadata = data["metadata"]
    component_data["name"] = metadata["name"]
    component_data["namespace"] = metadata.get("namespace", "")
    # Recursively search for "containers" keyword in the yaml. The ones that
    # doesn't (for eg: Service) will get an empty list
    containers = search(data, "containers", [])
    init_containers = search(data, "initContainers", [])
    component_data["containers"] = [_get_image_and_name(container) for container
                                    in containers + init_containers]
    return component_data


def _kustomize_build(filepath: str) -> str:
    return subprocess.check_output(["kustomize", "build", filepath])


def _get_component_name(filepath: str) -> str:
    return pathlib.PurePath(filepath).name


def _get_filepath(filename: str) -> str:
    return os.path.dirname(os.path.abspath(filename))


def create_bundled_output(files: list) -> list:
    """
    This function creates a bundle output of all the kustomization files and
    outputs to a file in `docs` directory
    """
    resources = []
    for filename in files:
        resource_dict = {}
        filepath = _get_filepath(filename)
        resource_dict["name"] = _get_component_name(filepath)
        resource_dict["resources"] = []
        rendered_output = _kustomize_build(filepath)
        component_list = []
        for resource in re.split("\n---\n", rendered_output.decode("utf8")):
            specs = _get_specs(resource)
            if specs:
                component_list.append(specs)
        resource_dict["resources"] = component_list
        resources.append(resource_dict)
    return resources


def get_k8s_resources() -> str:
    kustomize_files = _get_kustomization_files()
    return create_bundled_output(kustomize_files)


def write_canonical_json(canonical_data: dict):
    logging.info("writing canonical definition file")
    filepath = _get_json_file()
    if os.path.exists(filepath):
        os.remove(filepath)
    with open(filepath, 'w') as fp:
        json.dump(canonical_data, fp, indent=4, sort_keys=False)


def _get_image_and_name(container_spec: dict) -> dict:
    containers = {}
    image, version = container_spec.get("image").split(":")
    containers["image"] = image
    containers["version"] = version
    containers["name"] = container_spec.get("name")
    # Assumption here is that the images we use are always from Harbor registry
    # in the modules and that the naming convention we use is `SIGHUP_REGISTRY`
    # value followed by the image name from community hub.
    # #TODO make exception from images from GCR or Quay
    containers["upstream_image"] = image.replace(SIGHUP_REGISTRY, "")
    return containers


if __name__ == "__main__":
    try:
        _this, MODULE, VERSION = sys.argv
    except ValueError:
        logging.error("Missing required arguments")
        sys.exit("Usage: ./gen_canonical_def <Module_Name> <Module_Version>")
    canonical_data = {"module": MODULE, "version": VERSION}
    canonical_data["components"] = get_k8s_resources()
    write_canonical_json(canonical_data)
    logging.info("Successfully wrote the Canonical defintion")
