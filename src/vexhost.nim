import fileManage, types, aes, jester, jsony, codes, repo, commit, strutils, clone, auth, branch

const newUserKey = "new user.usernew"

routes:
    get "/":
        resp "vexhost"

    post "/usr":
        try:
            let decr = aes.decryptData(request.body, newUserKey);
            let js = decr.fromJson(User)
            if getUserFile(js.username).id != "404":
                resp used
            else:
                # Not used
                createUserDir(js.username)
                setUserFile(js.username, js)
                resp ok
        except:
            resp badReq

    post "/new/@username/@reponame":
        try:
            let decr = aes.decryptData(request.body, getUserFile(@"username").id);
            let js = decr.fromJson(RepoRequest)
            resp newRepo(js)
        except:
            resp badReq

    post "/com/@username/@reponame":
        try:
            let decr = aes.decryptData(request.body, getUserFile(@"username").id);
            let js = decr.fromJson(CommitRequest)
            resp commit(js)
        except:
            resp badReq
    
    post "/branch/@username/@reponame":
        try:
            let decr = aes.decryptData(request.body, getUserFile(@"username").id);
            let js = decr.fromJson(BranchRequest)
            resp newBranch(js)
        except:
            resp badReq

    get "/clone/@username/@reponame/?@version?":
        try:
            var v = @"version"
            if @"version" == "":
                v = "main.lts";
            let ob: CloneRequest = CloneRequest(user: @"username", repo: @"reponame", version: v.split(".")[1], branch: v.split(".")[0])
            resp clone(ob)
        except:
            resp badReq

    get "/data/@username/@reponame":
        try:
            resp $(getRepoFile(@"username",@"reponame").toJson())
        except:
            resp badReq

    post "/auth":
        try:
            let decr = aes.decryptData(request.body, newUserKey);
            let js = decr.fromJson(Auth)
            if auth(js):
                resp ok;
            else:
                resp notAuth;
        except:
            resp badReq