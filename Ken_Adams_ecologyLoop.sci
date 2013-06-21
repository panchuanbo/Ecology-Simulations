function a = init(height, width, start)
    for i = 1:height,
        b = start;
        for j = 1:width,
            a(i, j) = b;
            if a(i, j) == 4 then
                a(i, j) = 5;
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

function world = initmod(x,y,k)
    for i = 1:x
        for j = 1:y
            world(i,j) = modulo(i+j,k) + 1
        end
    end
endfunction

function vm = generationvmLoop(mat, iterations, plot_rate, delay)
    dim = size(mat);
    for i = 1:iterations
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
        bl = 0; blue = 0; cyan = 0; green = 0;
        for p = 1:dim(1, 2),
            for q = 1:dim(1, 1),
                if mat(p, q) == 1 then
                    bl = bl + 1;
                elseif mat(p, q) == 2 then
                    blue = blue + 1;
                elseif mat(p, q) == 3 then //14
                    green = green + 1;
                elseif mat(p, q) == 4 then //21
                    cyan = cyan + 1;
                end
            end
        end
        bl_count(i) = bl
        blue_count(i) = blue
        cyan_count(i) = cyan
        green_count(i) = green
        if modulo( i, plot_rate ) == 0 then
            subplot(1,2,1)
            Matplot(mat);
            subplot(1,2,2)
            t = 1:i
            plot(t,bl_count(t),'k-',t,blue_count(t),'b-',t,cyan_count(t),'c-',t,green_count(t),'g-');
            a=gca();
            a.data_bounds=[0,0;iterations,dim(1,2)*dim(1, 1)];
        end
        if delay > 0 then
            sleep(delay);
        end
    end
    vm = mat;
endfunction
