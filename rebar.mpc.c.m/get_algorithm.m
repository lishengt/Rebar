function algorithm = get_algorithm(alg, parameter)
    % 字符串转化为小写
    alg = lower(alg);
    if strcmp(alg, 'pso')
        pso = CPSO(parameter); 
        algorithm = pso;
    end
    if strcmp(alg, 'nfo')
        nfo = CNFO(parameter);
        algorithm = nfo;
    end
    
    if strcmp(alg, 'de')
        de = CDE(parameter);
        algorithm = de;
    end
end

