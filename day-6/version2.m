f = readlines('input.txt');
f(end) = []; % last line is empty str
f = split(f, ""); % 2D arr of chars
f = f(:, 2:end-1); % trim empty strs on either side
map = f;

dir = 2;
[x, y] = find(map=="^");
pos = [x,y];

% convert the direction # to coords
function cdir = convert_dir(dir)
    cdir = [mod(dir+1, 2) * (1-dir), mod(dir, 2) * (2-dir)];
end
% return the future position of the guard
function npos = next_pos(pos, dir) 
    npos = pos + convert_dir(dir);
end
% increment direction
function ndir = turn(dir) 
    ndir = mod(dir + 3, 4);
end

function [flag, nmat] = mark(mat, dir, pos) 
    flag = false;
    if bitand(mat(pos(1),pos(2)), bitshift(1, dir))
        flag = true;
    end

    mat(pos(1),pos(2)) = bitor(mat(pos(1),pos(2)), bitshift(1, dir));
    nmat = mat;
end

function [method, steps, alt] = checkPaths(map, dir, pos, forward, theoretical)
    n=0;
    alt = 0;
    while n < (130^2)
        % loop:
        next = [1,1];
        while true
            % check forward
            next = next_pos(pos, dir);
            if or(max(next) > 130, min(next) < 1)
                break
            end
            if ~isequal(map(next(1), next(2)), '#')
                break
            end
            % rotate if blocked
            dir = turn(dir);
        end
        if or(max(next) > 130, min(next) < 1)
            method = 0;
            break
        end
        % check obstacle opt
        if and(forward(next(1), next(2)) == 0, ~theoretical)
            tmap = map;
            tmap(next(1), next(2)) = '#';
            [method, s, a] = checkPaths(tmap, dir, pos, forward, true);
            alt = alt + method;
            if and(mod(n, 500) == 0, n > 1)
                disp("step: ")
                disp(n)
                disp("alts: ")
                disp(alt)
            end
        end
        
        % step forward
        pos = next;
        [flag, forward] = mark(forward, dir, pos);
        if flag
            method = 1;
            break
        end
        n = n + 1;
    end
    steps = length(find(forward));
end

forward = zeros([130,130]);
[flag, forward] = mark(forward, dir, pos);

[m, total, alt] = checkPaths(map, dir, pos, forward, false);

disp('steps taken');
disp(total)
disp('obstacles possible');
disp(alt)
% debugging
%fid = fopen('out1.txt','wt');
%fprintf(fid, join(join(f,''), '\n'));
%fclose(fid);
%
forward = arrayfun(@(a)dec2hex(a),forward,'uni',0);
forward = join(join(forward, ''), '\n');
fid = fopen('out2.txt','wt');
fprintf(fid, string(forward));
fclose(fid);

