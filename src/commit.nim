import auth, fileManage, types, codes, libsha / sha256, vexbox, jsony, tables

const commitIDLen: int = 10;

proc commit*(data: CommitRequest): string = 
    let usr = getUserFile(data.auth.username)
    if usr.id == notFound:
        return notFound
    elif usr.id != data.auth.username:
        return notAuth;

    # Authenticate
    let correctAuth = auth(data.auth);
    if not correctAuth:
        return notAuth;

    let commitID = sha256hexdigest(data.box)[0..commitIDLen-1]
    
    var branch = data.branch
    if branch == "":
        branch = "main"

    var repo = getRepoFile(usr.username, data.repo)
    if repo.name == notFound:
        return notFound;
    repo.structure[branch].cont.add(commitID)
    let op = editRepoFile(repo);
    if op != ok:
        return op
    # Check if box is correct
    let dt = decompress(data.box)
    let js = dt.fromJson(Box)
    discard js

    return repo.addBoxFile(commitID, data.box)