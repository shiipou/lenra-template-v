# template-v
[V](https://github.com/vlang/v) template to boostrap Lenra app

## Get Started !

### Prerequis

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
