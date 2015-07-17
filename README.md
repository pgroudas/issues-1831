This repo demonstrates that pants is unable to build python artifacts
when configured without pypi.

My goal is to essentially 'check-in' all our python wheels such that
we can do our builds / deploys without any external connectivity.

I believe the pants.ini 'repos' configuration enables us to do that, except for
the interpreter cache.

This repository has a simple BUILD target that references flufl.enum wheel that
is provided in `prebuilt/dists` and configured in pants.ini.

To reproduce:
  Run `./pants run //:test` => This should fail

Edit pants.ini to uncomment the default pypi index:
  Run `./pants run //:test` => This will succeed, and create stuff in .pants.d/python/interpreters

Edit pants.ini to re-comment the default pypi index:
  Run `./pants run //:test` => This will now continue to succeed until `pants clean-all` is invoked.

