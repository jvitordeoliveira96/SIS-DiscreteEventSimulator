%  N - represents the total elements (individuals)
N=10;


C = 10;  % como se fosse o sup lambda lokao (codigo do pupilo)

% Lambda - represents the exogenous infection rate
lambda = C/N;
    
% healing rate (desinfeccao)
mu=1;

% Total de iteracoes
Iter =  10^5;  % LEMBRAR DE USAR NUMERO MUITO ELEVADO NA HORA DE BOTAR NO RELATORIO

% Gamma - represents the endogenous infection rate
% \gamma to be tested:
dominio = [10:5:55];

for gamma = 0.1:0.5:2.6
%for gamma = 1.1:1.1
    p_ds = zeros(10,1);              %Armazena o numero de infectados estimado
    margenserr = zeros(6,1);        %Armazena as margens de erro associadas ao anterior

    N = 10;
    for k=1:10
        [p_d, margemerr] = simularSI(N, Iter, lambda, gamma , mu);
        p_ds(k) = p_d;
        margenserr(k) = margemerr;
        N = N + 5;
    end
    
    plot(dominio, p_ds);
    hold on;
end
legend('gamma = 0.1', 'gamma = 0.6', 'gamma = 1.1', 'gamma = 1.6', 'gamma = 2.1', 'gamma=2.6');