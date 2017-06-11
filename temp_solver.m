% Examples
%       FUN can be specified using @:
clear all;
x0 = [2,0.3,1];
         X = fminunc(@objFun,x0)
 
%     where myfun is a MATLAB function such as:
 

%       To minimize this function with the gradient provided, modify
%       the function myfun so the gradient is the second output argument:

%          function [f,g] = myfun(x)
%           f = sin(x) + 3;
%           g = cos(x);
%          end

%       and indicate the gradient value is available by creating options with
%       OPTIONS.SpecifyObjectiveGradient set to true (using OPTIMOPTIONS):

%          options = optimoptions('fminunc','SpecifyObjectiveGradient',true);
%          x = fminunc(@myfun,4,options);
 
%       FUN can also be an anonymous function:
%          x = fminunc(@(x) 5*x(1)^2 + x(2)^2,[5;1])