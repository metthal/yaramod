#!/bin/bash

source use_env.sh

pip install twine

cat >~/.pypirc <<EOF
[distutils]
index-servers =
	pypi
[pypi]
username=${PYPI_USERNAME}
password=${PYPI_PASSWORD}
EOF

cat ~/.pypirc

if [ "${TRAVIS_OS_NAME}" = "linux" ]; then
	python setup.py sdist
elif [ "${TRAVIS_OS_NAME}" = "windows" ]; then
	python setup.py bdist_wheel
fi

twine upload --skip-existing dist/*
