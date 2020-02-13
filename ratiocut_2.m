Tree_Generator_main                        %Program to generate trees
G=graph(adj);
plot(G);
arestas=G.Edges;                            %Import edges from an object
arestas = splitvars(arestas, 'EndNodes');
arestas = arestas{:,:};
arestas=transpose(arestas);
ss=arestas(1,:);
rr=arestas(2,:);
n=size(transpose(ss),1)+1;

for j=1:n
    try
        ss(j)=[];
        rr(j)=[];
        GG=graph(ss,rr);
        bins = conncomp(GG);        %take the connected components
        s=sum(bins>1.5);
        scomp=sum(bins < 1.5);
        for i=1:n
            if bins(i)==1
                x(i)= sqrt((scomp)/(s*n));
            else
                x(i)=-sqrt((s)/(scomp*n));
            end
        end
        x=transpose(x);
        rcut(j)= (x' * laplacian * x);
        x=x';
        ss=arestas(1,:);
        rr=arestas(2,:);
        continue
    end
    % Nothing to do
end

[M,I] = min(rcut);              %Take the min RatioCut, and it's position
   ss(I)=[];
    rr(I)=[];
    GG=graph(ss,rr);
    bins = conncomp(GG);        
    s=sum(bins>1.5);
    scomp=sum(bins < 1.5);
    for i=1:n
        try
            if bins(i)==1
                x(i)= sqrt((scomp)/(s*n));
            else
                x(i)=-sqrt((s)/(scomp*n));
            end
            continue
        end
    end
    x=transpose(x);
    rcut(I)= (x' * laplacian * x);
    
    p = plot(G);                        %Plot the result
    b=zeros(n,1);
    for i=1:n
        if x(i)>=0
            b(i)=i;
        end
    end
    b = nonzeros(b');
    highlight(p,b,'NodeColor','r')

    