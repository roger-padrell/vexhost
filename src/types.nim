import tables
# From https://github.com/roger-padrell/vex/
type 
    Repo* = object
        name*: string
        ownerID*: string # User ID
        owner*: string # Username
        version*: string
        hosted*: bool = false
        origin*: string = ""
        editors*: seq[string] = @[]

    RepoBranch* = object
        name*: string
        cont*: seq[string] = @[] # VexBox id's / hashes

    RepoFile* = object
        owner*: User
        structure*: Table[string, RepoBranch] = {"main": RepoBranch(name: "main")}.toTable
        name*: string
    
    User* = object
        username*: string
        id*: string

    Auth* = object
        username*: string
        passwordHash*: string

    RepoRequest* = object
        repo*: Repo
        auth*: Auth

    CommitRequest* = object
        auth*: Auth
        repo*: string
        box*: string # Encrypted VexBox
        branch*: string = "main" # Previous commit ID

    CloneRequest* = object
        repo*: string
        user*: string
        branch*: string
        version*: string
