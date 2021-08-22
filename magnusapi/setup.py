#!/usr/bin/env python
from setuptools import find_packages, setup

from magnusapi.version import __version__

setup(
    name="template",
    version=__version__,
    packages=find_packages(exclude=["tests"]),
    include_package_data=True,
    zip_safe=False,
)
