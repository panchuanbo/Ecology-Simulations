function a = init(height, width, start)
    for i = 1:height,
        b = start;
        for j = 1:width,
            a(i, j) = b;
            if a(i, j) == 3 then
                a(i, j) = 14;
            end
            if a(i, j) == 4 then
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

function vm = generationvmLoop(mat, iterations, delay)
    dim = size(mat);
    counter = 1;
    for i = 1:iterations,
        w = ceil(rand() * dim(1, 2));
        h = ceil(rand() * dim(1, 1));
        r = ceil(rand() * 4);
        if r == 1 then 
            if h-1 < 1 then
                mat(h, w) = mat(dim(1, 1), w);
            else
                mat(h, w) = mat(h-1, w);
            end
        end,
        if r == 2 then 
            if h+1 > dim(1, 1) then
                mat(h, w) = mat(1, w);
            else
                mat(h, w) = mat(h+1, w);
            end
        end,
        if r == 3 then 
            if w+1 > dim(1, 2) then
                mat(h, w) = mat(h, 1);
            else
                mat(h, w) = mat(h, w+1);
            end
        end,
        if r == 4 then 
            if w-1 < 1 then
                mat(h, w) = mat(h, dim(1, 2));
            else
                mat(h, w) = mat(h, w-1);
            end
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
        
        //subplot(2,2,2)
        //pie([black blue red green], ["Black", "Blue", "Red", "Green"]);
        if modulo(counter, 10000) == 0 then
        //subplot(2,2,1)
        Matplot(mat);
        //subplot(2,2,3)
        xfrect(dim(1, 1)+1, dim(1, 2)+50, 20, dim(1, 1));
         if delay > 0 then
            sleep(delay);
        end
        xstring(dim(1, 1)+1, dim(1, 2), 'Black: ' + string(black))
        //xstring(10,10, 'Black: ' + string(black))
        xstring(dim(1, 1)+1, dim(1, 2)-1*(dim(1,2)/10), 'Blue: ' + string(blue))
        xstring(dim(1, 1)+1, dim(1, 2)-2*(dim(1,2)/10), 'Red: ' + string(red))
        xstring(dim(1, 1)+1, dim(1, 2)-3*(dim(1,2)/10), 'Green: ' + string(green))
        xstring(dim(1, 1)+1, dim(1, 2)-4*(dim(1,2)/10), 'Currently On')
        xstring(dim(1, 1)+1, dim(1, 2)-4.5*(dim(1,2)/10), 'Iteration:')
        xstring(dim(1, 1)+1, dim(1, 2)-5*(dim(1,2)/10), string(counter) + '/' + string(iterations))
        end
        counter = counter + 1;
    end,
    vm = mat;
endfunction

function ip = generationipLoop(mat, iterations, delay)
    dim = size(mat);
    for i = 1:iterations,
        w = ceil(rand() * dim(1, 2));
        h = ceil(rand() * dim(1, 1));
        r = ceil(rand() * 4);
        if r == 1 then 
            if h-1 < 1 then
                mat(dim(1, 1), w) = mat(h, w);
            else
                mat(h-1, w) = mat(h, w);
            end
        end,
        if r == 2 then 
            if h+1 > dim(1, 1) then
                mat(1, w) = mat(h, w);
            else
                mat(h+1, w) = mat(h, w);
            end
        end,
        if r == 3 then 
            if w+1 > dim(1, 2) then
                mat(h, 1) = mat(h, w);
            else
                mat(h, w+1) = mat(h, w);
            end
        end,
        if r == 4 then 
            if w-1 < 1 then
                mat(h, dim(1, 2)) = mat(h, w);
            else
                mat(h, w-1) = mat(h, w);
            end
        end,
        Matplot(mat);
        if delay > 0 then
            sleep(delay);
        end
    end,
    ip = mat;
endfunction
