import auth, fileManage, types, codes, tables

proc newRepo*(data: RepoRequest): string = 
    let usr = getUserFile(data.repo.owner)
    if usr.id == notFound:
        return notFound
    elif usr.id != data.repo.ownerID or data.auth.username != usr.username:
        return notAuth;
    
    # Authenticate
    let correctAuth = auth(data.auth);
    if not correctAuth:
        return notAuth;
    
    # Create repo file
    var f = RepoFile(owner: usr, name: data.repo.name, structure: {"main": RepoBranch(name: "main")}.toTable)
    let createOut = createRepoFile(f)
    
    return createOut;