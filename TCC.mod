param starting_time;
param T; #Último intervalo de tempo
param N; #Número de estágios 
param A; #Número de tarefas
set I = 1..A; #Conjunto das tarefas
set TT = 1..T; #Conjunto dos intervalos de tempo
set K = 1.. N; #Conjunto das etapas
set J {K}; #Conjunto das máquinas em cada etapa
var X {I,TT,k in K,J[k]} binary; #Variável de decisão
param d {I}; #Prazo de conclusão
param E {I, K}; #Tempo de execução
var Z; #Variável para função objetivo
 
minimize MakeSpan: Z;
#Restrição 1
subject to q {i in I,k in K}: sum {t in TT,j in J[k]} X[i,t,k,j] = 1;
 
#Restrição 2
subject to w {i in I, k in 2.. N, t in (E[i,k-1]) + 1.. T}: sum {j in J[k]} X[i,t,k,j] <=sum {j in J[k-1], b in 1..(t - E[i,k-1])} X[i,b,k-1,j];
 
#Restrição 3
subject to e {i in I, k in 2.. N}: sum {j in J[k], t in 1..sum {b in 1..(k-1)} E[i,b]} X[i,t,k,j] = 0;

#Restrição 4   
subject to r {t in TT,  k in K, j in J[k]}: sum {i in I, b in max(1,t-E[i,k] + 1)..t} X[i,b,k,j] <=1;
 
#Restrição 5
subject to y {i in I}: sum {j in J[N], t in 1..(d[i] - E[i,N] + 1)} X[i, t, N, j] = 1;
 
#Restrição 6
subject to u {i in I}: Z >= sum {t in TT, j in J[N]} (X[i,t,N,j] *( t + E[i,N] - 1));
