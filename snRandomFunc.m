function [ funcPoints ] = snRandomFunc(nPoints, funcClass)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

    if nargin<2
        funcClass=floor(3*rand())+1;
    end
        
    switch funcClass
        case 1 % step
            funcPoints=ones(1, nPoints)*200*rand();
        case 2 % ramp
            funcPoints=sign(rand()-0.5)*[0:(nPoints-1)]*25*rand();
        case 3 % quadratic
            funcPoints=4*sign(rand()-0.5)* (...
                rand()*[0:(nPoints-1)]+ ...
                rand()*[1:nPoints].^(sign(rand()-0.5)*2) ...
            );
    end
%     return
%             
%     switch funcClass
%         case 1 % sin
%             period=nPoints*(0.3+rand());
%             amplitude=abs(200*(rand())-.25);
%             phase=nPoints*rand();
%             offset=3*rand();
%             funcPoints=70*offset+amplitude*sin(2*pi*([1:nPoints]/period)+phase);
%         case 2 % exp
%             amplitude=300*(rand());
%             tau=nPoints*(rand()+2)/3;
%             offset=2*rand()-0.5;
%             funcPoints=1.2*(offset+amplitude*exp(-[1:nPoints]/tau));
%         case 3 % poly    
%             amplitude=4*(rand())*sign(rand()-0.5);
%             amplitude2=4/82*(rand())*sign(rand()-0.5);
%             amplitude3=4/960*(rand())*sign(rand()-0.5);
%             Toffset=sign(rand()-0.5)*floor(nPoints*rand());
%             offset=2*rand()-0.5;
%             
%             funcPoints = 5*abs(offset+...
%                 amplitude*([1:nPoints]+Toffset)+...
%                 amplitude2*([1:nPoints]+Toffset).^2+ ...
%                 amplitude3*([1:nPoints]+Toffset).^3 ...
%                );
%     end
%     
% %     funcPoints=funcPoints-mean(funcPoints);
% %     funcPoints=funcPoints/std(funcPoints);
%             
% end

