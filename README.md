# Super quick attempt at a build server

So you want to build your fancy new docker container as part of CI, but whatever CI service you have does not give enough control, caching or cores to really make it work. At the same time, it is quite nice for the testing parts, so you don't want to get rid of it completely.

One possible solution is to have a dedicated build server that will do the compute intensive parts with plenty of caching opportunities, while you keep the CI service for testing.

The idea:
- Using the Github GUI, set up a webhook that listens for any pushes to master.
- Let the webhook trigger a user-definable (shell) script that does the actual building.
- Optional: Use the Github API to send a response about the success of the build.
