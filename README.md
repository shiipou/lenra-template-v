<div id="top"></div>
<!--
*** This README was created with https://github.com/othneildrew/Best-README-Template
-->



<!-- PROJECT SHIELDS -->
[![Contributors][contributors-shield]][contributors-url]
[![Forks][forks-shield]][forks-url]
[![Stargazers][stars-shield]][stars-url]
[![Issues][issues-shield]][issues-url]
[![MIT License][license-shield]][license-url]



<!-- PROJECT LOGO -->
<br />
<div align="center">

<h3 align="center">Template V</h3>

  <p align="center">
    This template provides just enough to get started with your [V](https://github.com/vlang/v) application.
    <br />
    <br />
    <a href="https://github.com/lenra-io/template-v/issues">Report Bug</a>
    ·
    <a href="https://github.com/lenra-io/template-v/issues">Request Feature</a>
  </p>
</div>

## Get Started !

### Requirements*

- [x] docker
- [x] docker-compose
- [ ] buildkit
- [x] lenra_cli

_*Unchecked value is optional_


### How to install `lenra_cli`

You need to install the Lenra CLI to start the devtools that will show your app.

To download it, you can use cargo or download the binary via the [latest github release assets](https://github.com/lenra-io/lenra_cli/releases)

From cargo you need to run the following command :

```bash
cargo install lenra_cli --version=1.0.0-beta.5
# or `cargo install lenra_cli@1.0.0-beta.5`
```

When installed you can run the binary file

```bash
lenra --version
```

### Building and debugging your app

To build your app, you can run the `lenra build` command that will build the docker container
```bash
lenra build
```

The `lenra start` command will start all needed services to make your app ready and then open your browser so you can start debugging.

```bash
lenra start
```

When everything is fine, you can stop your app by running the `lenra stop` command. That will interrupt all current running services about your app. And delete all data from your app to be able to keep your test clean.

```bash
lenra stop
```


<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
[contributors-shield]: https://img.shields.io/github/contributors/lenra-io/template-v.svg?style=for-the-badge
[contributors-url]: https://github.com/lenra-io/template-v/graphs/contributors
[forks-shield]: https://img.shields.io/github/forks/lenra-io/template-v.svg?style=for-the-badge
[forks-url]: https://github.com/lenra-io/template-v/network/members
[stars-shield]: https://img.shields.io/github/stars/lenra-io/template-v.svg?style=for-the-badge
[stars-url]: https://github.com/lenra-io/template-v/stargazers
[issues-shield]: https://img.shields.io/github/issues/lenra-io/template-v.svg?style=for-the-badge
[issues-url]: https://github.com/lenra-io/template-v/issues
[license-shield]: https://img.shields.io/github/license/lenra-io/template-v.svg?style=for-the-badge
[license-url]: https://github.com/lenra-io/template-v/blob/master/LICENSE
