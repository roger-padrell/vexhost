# VexHost
Host/Origin for VEX repos

## TODO
- [x] `/` returns `vexhost`
- [x] `/usr` registers user
- [x] `/new/:username/:reponame` creates repo
- [x] `/com/:username/:reponame` commit to repo
- [ ] `/clone/:username/:reponame/:version` clones repo (version is optional)
- [ ] `/data/:username/:reponame` gets repo data (no need for owner/editor acces)
- [x] AES
- [x] Auth function