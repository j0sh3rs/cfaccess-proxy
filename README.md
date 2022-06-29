# cfaccess-proxy

[![GitHub Super-Linter](https://github.com/j0sh3rs/cfaccess-proxy/workflows/Lint%20Code%20Base/badge.svg)](https://github.com/marketplace/actions/super-linter)

cfaccess-proxy is an HTTP proxy implemented to run transparently behind [Cloudflare
Access](https://teams.cloudflare.com/access/) and forward the email and username of the signed-in user to any downstream service.

Forked from [jorgelbg/cloudflare-access-grafana](https://github.com/jorgelbg/cloudflare-access-grafana), which sadly appeared abandoned, this proxy takes a more generic approach than the specific-to-grafana usecase of its predecessor.

Specifically, I have done the following:

1. Updated go and all modules (2+ years worth of fixes/changes)
1. Added the ability to extract a username from the Cloudflare Access email provided in the JWT, and send this as a separate header
1. Applied all super-lint suggestions and fixes

## 📥 Installation / Getting started

There are several ways this proxy can be used/configured, including supporting the usecase [jorgelbg created it for](https://github.com/jorgelbg/cloudflare-access-grafana#-installation--getting-started).

At a high level, you can define the properties outlined below in the Configuration section, configure your service to accept proxy auth, and there you have it.


You can copy the template from [.env.template](.env.template) into your environment file and adjust
the required values. Now you can run the cfaccess-proxy container with the following command:

```
cp .env.template .env
docker run --rm -d --env-file $(pwd)/.env --name cfaccess-proxy -p 3001:3001 j0sh3rs/cfaccess-proxy
```

This will start the proxy on the specified address and it will start to listen for incoming requests.
When a new HTTP request is received it will validate the JWT token, extract the `email` claim from
the token and forward to the specified host the header with the email address. Additionally, it will parse the `email` claim to make a basic attempt to produce a `userName` equivalent not currently provided by Cloudflare.

> Additional configuration on the Cloudflare Access is required to route your subdomain/DNS entry
> into the cfaccess-proxy instance. Your service doesn't need to be accessible externally since
> all requests will go through the proxy.

## 👾 Known Issues

Since the authentication is no longer on your service side (and is the responsibility of the proxy), any logout actions within a service will not work as
expected. This happens
because the current user has not been logged out of Cloudflare Access, nor will the proxy try to do that.

## 🛠 Configuration

All the configuration options are passed to cfaccess-proxy as environment variables:

* `AUTHDOMAIN`: This is your cloudflare authentication domain. Normally in the form of `https://<your-own-domain>.cloudflareaccess.com`.
* `POLICYAUD`: Application Audience (AUD) Tag.
* `FORWARDUSERHEADER`: The header to be forwarded upstream to indicate which user is currently logged in.
* `FORWARDEMAILHEADER`: The header to be forwarded upstream to indicate the email of the user currently logged in.
* `FORWARDHOST`: Downstream URL where your service listens
* `ADDR`: Address where the cfaccess-proxy will listen for incoming connections.

## 👨🏻‍💻 Developing

WIP

## 🤚🏻 Contributing

If you'd like to contribute, please fork the repository and use a feature
branch. Pull requests are happily embrased.

## 🚀 Links

* The project logo is based on [Cloudflare icon](https://icons8.com/icons/set/cloudflare) by [Icons8](https://icons8.com).
