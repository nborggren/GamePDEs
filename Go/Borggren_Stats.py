from ROOT import TH1F,TCanvas

def ReadGame(game,path='./GoDat/KGS/'):
    g=open(path+game)
    return g.read()

f=open('./GoDat/KGS/Borggren.games')
mygames=f.read().split('\n')
games = [i for i in mygames if i.find('.sgf')>0]
myana = [i for i in mygames if i.find('/Bogoliubon.sgf')>0]
print len(games),len(mygames)

years=[str(i) for i in range(2017)[2004:]]
months=[str(i+1) for i in range(12)]

gcnt=0
grecord=[]
for i in years:
    for j in months:
        ngames=len([k for k in games if k.find(i+'/'+j+'/')>-1])
        print i,j,ngames
        gcnt+=ngames
        grecord.append(ngames)
print gcnt

grecord=grecord[9:-10]

hist=TH1F("hist","hist",138,-0.5,137.5)
for i,j in enumerate(grecord):
    for k in range(j):
        hist.Fill(i)

c1=TCanvas()
hist.Draw()
c1.Print("hist.ps")

zwom=input("sheat")
