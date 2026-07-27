# Tools - GIMP

David Williamson @ Varilink Computing Ltd

------

Tool for using GIMP batch mode to generate images that are transformed from source image files in website projects. Projects that use this tool can define and track the source image files and the GIMP Script-Fu script file or files that are run in order to generate their distribution images. They do not then need to track those distribution images.

Note that this tool installs GIMP from the APT repository for the Debian bookworm release, which is "old stable" at time of writing. This installs GIMP version 2.10.34. I am currently holding off upgrading this tool to use the Debian trixie release, as its APT repository installs GIMP version 3.0.4. The GIMP batch scripting interface changes considerably from GIMP version 2 to GIMP version 3 and all of my project GIMP scripts are based on the version 2 interface.

## Using this tool

### Install

To install this tool in projects, add it as a Git submodule with the submodule path tools/gimp. The tool is implemented as a Docker Compose service. Add the path to its `docker-compose.yml` file to the paths defined by the `COMPOSE_FILE` Docker Compose environment variable in the project's Docker Compose `.env` file.


This tool implements the following volume mappings for it to use within your project:
```yaml
volumes:
  - ./wordpress/gimp/:/gimp/
  - ./wordpress/media/:/media/
```

Typically you should setup your website's Docker Compose project in order to use these volumes as follows:

- Follow the convention of having your website's WordPress repository as a submodule of its Docker Compose project at the path `wordpress`.

- Within your website's WordPress repository, create a `gimp` directory that contains one or more `.scm` scripts and the source files they act upon. The path of source files relative to the scripts is whatever you want it to be, so long as the scripts refer to the source files correctly.

- Within your website's WordPress repository, create a `media` directory that will contain the generated images produced by running your `.scm` script or scripts. Configure Git to ignore these generated images.

### Run

You can then run this tool from the root folder of your project, either without any command arguments:

```bash
docker-compose run --rm gimp
```

In which case it will run every `.scm` file within the folder that you mapped to `/gimp` in the container.

Or, you can specify one or more `.scm` scripts that are located in the same folder, omitting the file extension; for example:

```bash
docker-compose run --rm gimp theme library
```

That example will run the `theme.scm` and `library.scm` scripts, if they are present in the folder that you mapped to `/gimp` in the container.

### Examples

Here are a couple of my repositories that use this tool:

- [FoBV - Docker](https://github.com/varilink/fobv_docker)
- [Website - Ansible](https://github.com/varilink/website-ansible)
