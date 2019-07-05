# scratch-ish

It's like `scratch`, but with a little more.

## Rationale

The `scratch` image is a great base for shipping binaries, but it can be limiting in production
deployments. In particular, it can be difficult to set up health checks (or readiness and liveness
probes) without having additional tooling such as `curl` or `cat` installed.

`scratch-ish` is an image that is based off of `scratch` but includes some basic tooling to
make production deployments easier.

## Features

### `/bin/exists`

An executable which checks whether or not a file exists.

The [Kubernetes liveness and readiness probes](https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-probes/)
page provides an example of a liveness probe using `cat` to determine whether a file exists:

```yaml
livenessProbe:
  exec:
    command:
    - cat
    - /tmp/healthy
  initialDelaySeconds: 5
  periodSeconds: 5
```

With a `scratch-ish`-based image, this would be configured as

```yaml
livenessProbe:
  exec:
    command:
    - /bin/exists
    - /tmp/healthy
  initialDelaySeconds: 5
  periodSeconds: 5
```
