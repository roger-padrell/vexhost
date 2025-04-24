import types, codes, fileManage, tables

proc clone*(r: CloneRequest): string = 
    # Check if repo exists
    let rf = getRepoFile(r.user, r.repo)
    if rf.name == notFound:
        return notFound;

    # Check if version exists
    var version = r.version;
    if r.version == "lts":
        version = rf.structure[r.branch].cont[rf.structure[r.branch].cont.len()]
    let vf = rf.getBoxFile(version)

    if vf == notFound:
        return notFound;

    return vf;