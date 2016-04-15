[num,txt,raw] = xlsread('data.xlsx')
[r,c]=size(txt);
for i=2:r
    data(i).Team=txt(i,1);
    data(i).PG=txt(i,2);
    data(i).SG=txt(i,6);
    data(i).SF=txt(i,10);
    data(i).PF=txt(i,14);
    data(i).C=txt(i,18);
    data(i).PGn=txt(i,3);
    data(i).SGn=txt(i,7);
    data(i).SFn=txt(i,11);
    data(i).PFn=txt(i,15);
    data(i).Cn=txt(i,19);
end