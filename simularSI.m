function[p_d, margemerr] = simularSI(N, Iter, lambda, gamma , mu)
    Status =zeros(N,1);      % Vetor que indica que se esta infectado(1) ou nao (0)
    
    
    
    %pi = zeros(N+1,1);
    
    tempoTotal = 0;    %Tempo total dos eventos    
    d_anterior = 0;
    tempoAnterior = 0;
    areaTotal = 0;
    d_samples = zeros(1,Iter);
    
    
    for k=1:Iter    
        d = sum(Status);          % Usando o fato de que o grafo é completo a priori        
        taxaInfeccao = lambda*(gamma^d);
        tempoEventos = zeros(N,1); % tempo de cada evento
        % gerar d numeros com taxa de desinfeccao
        % gerar n-d numeros com taxa de infeccao
        for j=1:length(Status)
            if (Status(j) == 0 ) % individuo sucetivel
                tempo = exprnd(1/taxaInfeccao);
                tempoEventos(j) = tempo;
            else
                tempo = exprnd(1/mu);
                tempoEventos(j) = tempo;
            end    
        end
        
        [menorTempo, indexmenorTempo] = min(tempoEventos);
        if (Status(indexmenorTempo) == 1)
            Status(indexmenorTempo) = 0;
        else
            Status(indexmenorTempo) = 1;
        end
        
        tempoTotal = tempoTotal + tempoEventos(indexmenorTempo);
        
        if(d~=d_anterior)
            areaTotal = areaTotal + d_anterior*(tempoTotal-tempoAnterior);
            tempoAnterior = tempoTotal;
            d_anterior = d;
        end
        
        %pi(d+1) = pi(d+1) + tempoEventos(indexmenorTempo);
        %tempoTotal = tempoTotal + tempoEventos(indexmenorTempo);
        %d_total = d_total + d;
        d_samples(k) = d;
        
    
    end
    
    p_d = areaTotal/((N-0.8)*tempoTotal);
    variancia = sum((d_samples/N -p_d).^2)/(Iter-1);
    margemerr = 1.96*sqrt(variancia)/sqrt(Iter);   %Intervalo de confianca
    
    %disp('probabilidade do escolhido estar infectado = ');
    %disp(d/N);

    %media_p_d = mean(samples_p_d);
    %desviopadrao_p_d = sqrt(sum((samples_p_d-media_p_d).^2)/(Iter-1));

    
    %p_d = media_p_d;
    %margemerr = 1.96*desviopadrao_p_d/sqrt(Iter);
    
    %pi = pi/tempoTotal;
    
    %for k=0:N
    %    if (k>0)
                % probability of a tagged node being infected
    %            pi_tagged(k+1)=(nchoosek(N-1,k+1-1-1))*pi(k+1);
    %    else
                % probability of a tagged node being infected is zero
    %            pi_tagged(k+1)=0; % pi(k+1);
    %    end 
    %end
    
    
    % p_d = ;

end