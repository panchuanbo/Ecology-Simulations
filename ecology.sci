function a = init(height, width, start)
    for i = 1:height,
        b = start;
        for j = 1:width,
            a(i, j) = b;
            if a(i, j) == 4 then
                a(i, j) = 5;
            end
            if a(i, j) == 3 then
                a(i, j) = 14;
            end
            if a(i, j) == 5 then
                a(i, j) = 21;
            end
            b = b - 1;
            if b < 1 then
                b = 4;
            end
        end
        start = start - 1;
        if start < 1 then
            start = 4;
        end
    end
endfunction


function r = generateloc(dim, w, h)
        //1=up, 2=down, 3=right, 4=left
        tmp = 0; tmp2 = 0;
        if w == 1 & h == 1 then
            r = 4; tmp = 4; tmp2 = 1;
        elseif w == 1 & h == dim(1, 1) then
            r = 4; tmp = 4; tmp2 = 2;
        elseif w == dim(1, 2) & h == 1 then
            r = 3; tmp = 3; tmp2 = 1;
        elseif w == dim(1, 2) & h == dim(1, 1) then
            r = 3; tmp = 3; tmp2 = 2;
        elseif w == 1 then 
            r = 4; tmp = 4; 
        elseif w == dim(1, 2) then
            r = 3; tmp = 3;
        elseif h == 1 then
            r = 1; tmp = 1;
        elseif h == dim(1, 1) then
            r = 2; tmp = 2;
        end,
        if tmp == 0 then
            r = ceil(rand()*4);
        else
            while r == tmp | r == tmp2, r = ceil(rand() * 4); end,
        end,
endfunction

function vm = generationvm(mat, iterations, delay)
    dim = size(mat);
    counter = 1;
    for i = 1:iterations,
        w = ceil(rand() * dim(1, 2));
        h = ceil(rand() * dim(1, 1));
        r = generateloc(dim, w, h);
        if r == 1 then mat(h, w) = mat(h-1, w);
        end,
        if r == 2 then mat(h, w) = mat(h+1, w);
        end,
        if r == 3 then mat(h, w) = mat(h, w+1);
        end,
        if r == 4 then mat(h, w) = mat(h, w-1);
        end,
        black = 0; blue = 0; red = 0; green = 0;
        for i = 1:dim(1, 2),
            for j = 1:dim(1, 1),
                if mat(i, j) == 1 then
                    black = black + 1;
                elseif mat(i, j) == 2 then
                    blue = blue + 1;
                elseif mat(i, j) == 14 then
                    green = green + 1;
                elseif mat(i, j) == 21 then
                    red = red + 1;
                end
            end
        end
        
        subplot(2,2,2)
        pie([black blue red green], ["Black", "Blue", "Red", "Green"]);
        
        subplot(2,2,1)
        Matplot(mat);
        subplot(2,2,3)
        xfrect(dim(1, 1)+1, dim(1, 2)+50, 20, dim(1, 1));
         if delay > 0 then
            sleep(delay);
        end
        xstring(dim(1, 1)+1, dim(1, 2), 'Black: ' + string(black))
        xstring(dim(1, 1)+1, dim(1, 2)-1*(dim(1,2)/10), 'Blue: ' + string(blue))
        xstring(dim(1, 1)+1, dim(1, 2)-2*(dim(1,2)/10), 'Red: ' + string(red))
        xstring(dim(1, 1)+1, dim(1, 2)-3*(dim(1,2)/10), 'Green: ' + string(green))
        xstring(dim(1, 1)+1, dim(1, 2)-4*(dim(1,2)/10), 'Currently On')
        xstring(dim(1, 1)+1, dim(1, 2)-4.5*(dim(1,2)/10), 'Iteration:')
        xstring(dim(1, 1)+1, dim(1, 2)-5*(dim(1,2)/10), string(counter) + '/' + string(iterations))
        counter = counter + 1;
    end,
    vm = mat;
endfunction

function ip = generationip(mat, iterations, delay)
    dim = size(mat);
    for i = 1:iterations,
        w = ceil(rand() * dim(1, 2));
        h = ceil(rand() * dim(1, 1));
        r = generateloc(dim, w, h);
        if r == 1 then mat(h-1, w) = mat(h, w);
        end,
        if r == 2 then mat(h+1, w) = mat(h, w);
        end,
        if r == 3 then mat(h, w+1) = mat(h, w);
        end,
        if r == 4 then mat(h, w-1) = mat(h, w);
        end,
        Matplot(mat);
        if delay > 0 then
            sleep(delay);
        end
    end,
    ip = mat;
endfunction
