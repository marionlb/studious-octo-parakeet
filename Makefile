.PHONY: help build test doc quality
.DEFAULT: help

SRC = 'src/'

help:
	@echo "make build"
	@echo "       builds and installs the package"
	@echo "make test"
	@echo "       run tests with coverage"
	@echo "make coverage"
	@echo "       show coverage reports"
	@echo "make clean"
	@echo "       deletes local install-related and doc-related files"
	@echo "make doc"
	@echo "       generates documentation"
	@echo "make doc"
	@echo "       generates documentation"


# Requirements are in setup.py, so whenever setup.py is changed, re-run installation of dependencies.
build:
	pipenv install
	python setup.py install

test: devdependencies
	pipenv run coverage run --branch --source=./src -m pytest -s tests/ -v

tests: test

coverage: test
	pipenv run coverage report && pipenv run coverage html -d doc/htmlcov

devdependencies:
	pipenv install --dev

quality: devdependencies
	pipenv run flake8 ${SRC} tests/
	pipenv run pylint ${SRC} tests/

clean:
	rm -rf dist *.egg-info build doc/api doc/htmlcov
#	find build/* -not -name 'source' -prune -exec rm -r {} +

doc: coverage
	pipenv run sphinx-apidoc -o doc/api/ ${SRC}
	pipenv run sphinx-build -b html doc/ build
