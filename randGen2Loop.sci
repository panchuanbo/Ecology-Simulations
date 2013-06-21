function a = randGen2Loop(Mat, iterations, delay)
    dim = size(Mat); t = 0;
    for i = 1:iterations,
        t=0;
        while t == 0,
            h1 = ceil(10*rand());
            h2 = ceil(10*rand());
            w1 = ceil(10*rand());
            w2 = ceil(10*rand());
            if h1 == h2 & modulo(w1, 10) == modulo(w2 - 1, 10) then
                t = ceil(2 * rand());
            elseif h1 == h2 & modulo(w1, 10) == modulo(w2 + 1, 10) then
                t = ceil(2 * rand());
            elseif w1 == w2 & modulo(h1, 10) == modulo(h2 - 1, 10) then
                t = ceil(2 * rand());
            elseif w1 == w2 & modulo(h1, 10) == modulo(h2 + 1, 10) then
                t = ceil(2 * rand());
            end
        end
        if t == 1 then
            Mat(h1, w1) = Mat(h2, w2);
        elseif t == 2 then
            Mat(h2, w2) = Mat(h1, w1);
        end
        Matplot(Mat);
        a = Mat;
        if delay > 0 then
            sleep(delay);
        end
    end
endfunction
