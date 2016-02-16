import sys

print sys.argv[1]
name = sys.argv[1]  #"Bogoliubon_vs_ars1969kar_2012_11_03-computer-analysis.pgn"
tmp = name.split("_2012")
tmp0 = tmp[0].split("_vs_")
wplayer = tmp0[0]
bplayer = tmp0[1]
date = "2012."+tmp[1].split("_")[1]+"."+tmp[1].split("_")[2]
date = date.split("-")[0]
f = open(name)

#game = f.read()

game = ""

for line in f:
    #print line
    nline=[i for i, e in enumerate(line) if e in ["{","}"]]
    #print nline
    if len(nline)==2:
        line = line[0:nline[0]]+line[nline[1]+1:]
        line2 = line[nline[0]:nline[1]]
        print line
        print line2

    if len(nline)==4:
        line = line[0:nline[0]]+line[nline[1]+1:nline[2]]+line[nline[3]+1:]
        #print line

    tmp = [i for i, e in enumerate(line) if e in ["$",")"]]
    #print tmp
    if len(tmp)==1:
        line = line[0:tmp[0]-1]
    if len(tmp)==2:
        line = line[0:tmp[0]]+") "
#    print line
    line=line.replace("\n"," ")
    line = line.replace("("," (")
    if "[" not in line:
        line=line.replace("(","[")
        line=line.replace(")","]")
        game=game+line

for i in reversed(range(100)):
    game = game.replace(str(i)+".","")


g= open(sys.argv[1]+".tex","w")

g.write("\\whitename{"+wplayer+"}\n\\blackname{"+bplayer+"}\n\\chessevent{"+date+"}\n\\makegametitle \n")
g.write("|" + game +"|\n")
