function A = init(n)
    for i=1:n
        for j=1:n
        //changes 4's to 5's to incorporate red color
            if modulo(i+j,4)+1 == 4 then
                A(i, j) = 5;
            else
                A(i,j)= modulo(i+j,4)+1
            end
        end
    end
endfunction
