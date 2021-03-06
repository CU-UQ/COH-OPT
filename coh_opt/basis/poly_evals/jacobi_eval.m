% evaluates set of orthonormal Jacobi polynomials
% orthogonal with respect to  2*betarnd(b+1,a+1)-1;
% -----
% f_o = jacobi_eval(ord,f_i,a,b);
% -----
% Input
% -----
% ord: maximum order of polynomial
% f_i: column vector of points being evaluated
% a: jacobi alpha
% b: jacobi beta
% ------
% Output
% ------
% f: rows of function evaluations, column corresponds to order
function f = jacobi_eval(ord,f_i,a,b)
    f = zeros(size(f_i,1),ord);
    % These combinations can be used frequently
    ab = a+b; ab1 = a+b+1; a1 = a+1; ab2 = a+b+2; a2 = a+2; ab3 = a+b+3;
    ab4 = a+b+4; a_1 = a-1; b_1 = b-1; b1 = b+1; ab_1 = a+b-1;
    ab_2 = a+b-2; asq_bsq = a^2-b^2;
    switch ord % before 3 term is effective
        case 0 % this case should not be used
            return
        case 1
            f(:,1) = 0.5*(2*(a1)+(ab2)*(f_i-1)); %needs normalized
            f(:,1) = f(:,1)*sqrt(ab3*gamma(2)*gamma(ab2)/(gamma(a2)*gamma(b+2)))*sqrt(beta(a1,b1));
            return
    end
    f(:,1) = 0.5*(2*a1+ab2*(f_i-1));
    f(:,2) = 0.125*(4*a1*a2+4*ab3*a2*(f_i-1)+ab3*ab4*(f_i-1).^2);
    for k = 3:ord % three term recurrence
        f(:,k) = (2*k+ab_1)*((2*k+ab)*(2*k+ab_2)*f_i+asq_bsq).*f(:,k-1)-2*(k+a_1)*(k+b_1)*(2*k+ab)*f(:,k-2);
        f(:,k) = f(:,k)/(2*k*(k+ab)*(2*k+ab_2));
    end
    nc = sqrt(beta(a1,b1));%    nc = 1/sqrt(ab1*gamma(a1)*gamma(b1)/gamma(ab1));
    for k = 1:ord % normalization to orthonormality
        f(:,k) = f(:,k)*sqrt((2*k+ab1)*gamma(k+1)*gamma(ab1+k)/(gamma(a1+k)*gamma(b1+k)))*nc;
    end
end
