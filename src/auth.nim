import libsha / sha256, fileManage, std/strutils, types

proc auth*(a: Auth): bool = 
    # Get long hash
    let totalhash = sha256hexdigest(a.username&";;"&a.passwordHash)
    # Get UserID to check match
    let usr = getUserFile(a.username)
    let id = usr.id;
    if id == "404":
        return false;
    elif totalhash.startsWith(id):
        return true;
    else:
        return false;