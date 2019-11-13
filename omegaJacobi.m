function x = omegaJacobi(A, b, guess, w, tolConvergence)
%Inputs
% A - A positive definite matrix of order n.
% b - A column vector having n components.
% guess - The initial starting guess.
% w - The omega parameter input.
% tolConvergence - The accuracy of the solution.

%Outputs
% x - A column vector consisting of the solution.
[rows, cols] = size(A);
x = guess;
x_new = zeros(rows, 1);
error = Inf;
iterationsUsed = 0;
diagonalDominance = true;
for i = 1:rows
    rowSum = 0;
    for j = 1:cols
        if (i ~= j)
            rowSum = rowSum + abs(A(i, j));
        else
            temp = A(i, j);
        end
    end
    if abs(temp) >= rowSum
        diagonalDominance = diagonalDominance & true;
    else
        diagonalDominance = false;
    end
end
if (diagonalDominance == true)
    while (error > tolConvergence)
        disp('Current solution:');
        disp(transpose(x));
        for i = 1 : rows
            rowSum = 0;
            for j = 1 : cols
                if (i ~= j)
                    rowSum = rowSum +(A(i, j) * x(j));
                end
            end
            x_new(i) = (b(i) - rowSum) / A(i, i);
            x_new(i) = (w * x_new(i)) + (1 - w) * x(i);
        end
        error = norm(x_new - x, inf) / norm(x_new, inf);
        iterationsUsed = iterationsUsed + 1;
        x = x_new;
    end
    fprintf('The number of iterations are %i\n', iterationsUsed);
    x = transpose(x);
    return;
else
    disp('Matrix A is not diagonally dominant; Jacobi does not apply. Trivial solution:');
    disp(transpose(x_news));
    return;
end
end