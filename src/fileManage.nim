import os, jsony, types, codes

proc getUserFile*(username: string): User = 
    let path = getAppDir()&"/"&username&"/usr.json";
    if not fileExists(path):
        echo "Error: User does not exist"
        return User(id: notFound)
    else:
        return readFile(path).fromJson(User)

proc setUserFile*(username: string, data: User) = 
    let path = getAppDir()&"/"&username&"/usr.json";
    let cont = $(data.toJson())
    writeFile(path, cont);

proc createRepoFile*(r: RepoFile): string {.gcsafe.} = 
    let dir = getAppDir()&"/"&r.owner.username&"/"&r.name&"/";
    if dirExists(dir):
        return used;
    createDir(dir);
    # Create repo.json
    writeFile(dir&"repo.json", $(r.toJson()))
    return ok;

proc editRepoFile*(r: RepoFile): string = 
    let path = getAppDir()&"/"&r.owner.username&"/"&r.name&"/repo.json";
    if not fileExists(path):
        return notFound;
    writeFile(path, $(r.toJson()))
    return ok;

proc getRepoFile*(usr: string, repoName: string): RepoFile = 
    let path = getAppDir()&"/"&usr&"/"&repoName&"/repo.json";
    if not fileExists(path):
        return RepoFile(name: notFound);
    return readFile(path).fromJson(RepoFile)

proc addBoxFile*(r: RepoFile, fileName: string, boxFile: string): string = 
    let path = getAppDir()&"/"&r.owner.username&"/"&r.name&"/"&fileName&".box";
    if fileExists(path):
        return used;
    writeFile(path, boxFile)

proc getBoxFile*(r: RepoFile, id: string): string = 
    let path = getAppDir()&"/"&r.owner.username&"/"&r.name&"/"&id&".box";
    if not fileExists(path):
        return notFound;
    return readFile(path)