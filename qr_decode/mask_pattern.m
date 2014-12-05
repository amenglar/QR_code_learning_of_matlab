function rst = mask_pattern(size,module)
%·µ»ØÑÚÄ£Í¼ÐÎ
msize = size;
mmodule = module;
rst(1:msize,1:msize) = 0;

for i = 0 : msize-1
    for j = 0 : msize-1
        switch mmodule
            case '000'
                if(mod(i+j,2)==0)
                    rst(i+1,j+1) = 0;
                else
                    rst(i+1,j+1) = 1;
                end
            case '001'
                if(mod(i,2)==0)
                    rst(i+1,j+1) = 0;
                else
                    rst(i+1,j+1) = 1;
                end
            case '010'
                if(mod(j,3)==0)
                    rst(i+1,j+1) = 0;
                else
                    rst(i+1,j+1) = 1;
                end
            case '011'
                if(mod(i+j,3)==0)
                    rst(i+1,j+1) = 0;
                else
                    rst(i+1,j+1) = 1;
                end
            case '100'
                if(mod(((floor(i/2))+(floor(j/3))),2)==0)
                    rst(i+1,j+1) = 0;
                else
                    rst(i+1,j+1) = 1;
                end
            case '101'
                if((mod(i*j,2)+mod(i*j,3))==0)
                    rst(i+1,j+1) = 0;
                else
                    rst(i+1,j+1) = 1;
                end
            case '110'
                if(mod((mod(i*j,2)+mod(i*j,3)),2)==0)
                    rst(i+1,j+1) = 0;
                else
                    rst(i+1,j+1) = 1;
                end
            case '111'
                if(mod((mod(i*j,3)+mod(i*j,2)),2)==0)
                    rst(i+1,j+1) = 0;
                else
                    rst(i+1,j+1) = 1;
                end
            otherwise
                
        end
                
    end
end

end