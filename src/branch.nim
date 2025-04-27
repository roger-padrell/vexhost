import types, codes, auth, fileManage, tables

proc newBranch*(data: BranchRequest): string = 
    let usr = getUserFile(data.auth.username);

    if usr.id == notFound:
        return notFound
    elif usr.id != data.auth.username:
        return notAuth;

    # Authenticate
    let correctAuth = auth(data.auth);
    if not correctAuth:
        return notAuth;

    # Get repo object
    var repo = getRepoFile(data.username, data.reponame)
    if repo.name == notFound:
        return notFound;

    # Version exists
    let box = getBoxFile(repo, data.fromCommit)
    if box == notFound:
        return notFound;

    # Branch exists
    if repo.structure.hasKey(data.branchName):
        return used;

    # Create branch and add first commit´
    if data.fromCommit == "none":
        repo.structure[data.branchName] = RepoBranch(name: data.branchName, cont: @[])
    else:
        repo.structure[data.branchName] = RepoBranch(name: data.branchName, cont: @[data.fromCommit])

    # Write to repo file
    return editRepoFile(repo)