def ParseGame(GameSeq):
    tmp = GameSeq.split()
    mygame = ""
    for i in tmp[:-1]:
        mv = i.split(".")
        mygame = mygame+mv[-1]+" "
    return mygame

def ParseHead(GameHead):
    tmp = GameHead.split("\"")
    atmp = []
    for i in tmp:
        tmp2 = i.split("[")
        if tmp2[-1] != "]":
            atmp.append(tmp2[-1])
    return atmp

games = open("bogoliubon_games.pgn")

g = open("bogoliubon_games.tex","w")

sgames = games.read()

agames = sgames.split("\r\n\r\n\r\n")
for i,j in enumerate(agames[:-1]):
    #print i, "game"
    tmp = j.split("\r\n\r\n")
    head = ParseHead(tmp[0])
    wname = ""
    bname = ""
    rname = ""
    a1 = [i for i, e in enumerate(head[7]) if e=='_']
    b1 = [i for i, e in enumerate(head[9]) if e=='_']
    c1 = [i for i, e in enumerate(head[19]) if e=='_']

    for a,b in enumerate(head[7]):
        if a in a1:
            wname=wname+"\_"
        else:
            wname=wname+b

    for a,b in enumerate(head[9]):
        if a in b1:
            bname=bname+"\_"
        else:
            bname=bname+b

    for a,b in enumerate(head[19]):
        if a in c1:
            rname=rname+"\_"
        else:
            rname=rname+b

    g.write("\\whitename{"+wname+" \\bf{"+head[13]+"}}\n")
    #g.write("\\welo{"+head[13]+"}")
    #g.write("\\belo{"+head[15]+"}")
    g.write("\\blackname{"+bname+" \\bf{"+head[15]+"}}\n")
    g.write("\\chessevent{"+head[5]+"}\n")
    g.write("\\makegametitle\n")
    if i<10:print head
    g.write("|"+ParseGame(tmp[1]).replace("#","\#")+" |\n\n")
    g.write("\\showboard\n\n")
    g.write(rname+"\n\n")


print len(agames)

#for line in games:
#    aline = line.split("\"")
#    print aline
