import sys, json
# SD-06 pixel (100dpi) corners -> Rob plan metres
sd = [(41,238),(1889,103),(1971,1299),(123,1437)]
rb = [(10.7,65.5),(7.3,18.6),(37.9,16.5),(41.4,63.2)]
# least squares affine: x' = a x + b y + c ; y' = d x + e y + f
def solve(A, b):
    n=len(A[0]); M=[[sum(A[k][i]*A[k][j] for k in range(len(A))) for j in range(n)] for i in range(n)]
    v=[sum(A[k][i]*b[k] for k in range(len(A))) for i in range(n)]
    for i in range(n):
        p=max(range(i,n),key=lambda r:abs(M[r][i])); M[i],M[p]=M[p],M[i]; v[i],v[p]=v[p],v[i]
        for r in range(n):
            if r!=i:
                f=M[r][i]/M[i][i]; M[r]=[M[r][j]-f*M[i][j] for j in range(n)]; v[r]-=f*v[i]
    return [v[i]/M[i][i] for i in range(n)]
A=[[x,y,1] for x,y in sd]
px=solve(A,[p[0] for p in rb]); py=solve(A,[p[1] for p in rb])
def T(x,y): return (round(px[0]*x+px[1]*y+px[2],2), round(py[0]*x+py[1]*y+py[2],2))
for (x,y),r in zip(sd,rb): print('corner',T(x,y),'vs',r)
print('coef',px,py)
for line in sys.stdin:
    line=line.strip()
    if not line or line.startswith('#'): continue
    name,*vals=line.split()
    v=list(map(float,vals)); pts=[T(v[i]*1.17,v[i+1]*1.17) for i in range(0,len(v),2)]
    print(name,pts)
