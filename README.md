## Setup

Run your [PHPUnit](https://phpunit.de/) tests with:

```bash
--coverage-html=./path/to/coverage \
--coverage-clover ./path/to/coverage/coverage.xml
```

You can customize `./path/to/coverage`, but make sure clover is generated in `coverage.xml`
inside the folder.

## Usage

Add the following step to your jobs:

```yaml
- name: Coverage
  uses: tonybogdanov/coverage@master
  with:
      path: ./path/to/coverage
      password: <optional password>
```

The password is optional, but if specified, all HTML files in the coverage will be
cryptographically encoded with the specified password.

## Example job

```yaml
coverage:
    name: coverage

    needs: [ test ]
    runs-on: ubuntu-latest

    steps:
        - name: Checkout
          uses: actions/checkout@v1

        - name: Download artifacts
          uses: actions/download-artifact@v1
          with:
              name: coverage

        - name: Coverage
          uses: tonybogdanov/coverage@master
          with:
              path: coverage
              password: coverage

        - name: Publish
          uses: JamesIves/github-pages-deploy-action@releases/v3
          with:
              ACCESS_TOKEN: ${{ secrets.GITHUB_TOKEN }}
              BRANCH: gh-pages
              FOLDER: coverage
```
