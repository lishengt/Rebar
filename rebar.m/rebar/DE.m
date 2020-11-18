classdef DE
    properties
        row
        col
        cr
        F
        iternum
        problem
    end
    
    methods
        function obj = DE(n_individuals, n_vars, cr, F, iternum, problem)
            obj.row = n_individuals;
            obj.col = n_vars;
            obj.cr = cr;
            obj.F = F;
            obj.iternum = iternum;
            obj.problem = problem;
        end
        
        function dpop = decoding(obj,bpop)
            dpop = zeros(obj.row,obj.col);
            [~,bcol] = size(bpop);
            code_length = bcol/obj.col;
            superscript_single = sort(linspace(1,code_length,code_length)-1,'descend');
            superscript_set = repmat(superscript_single,1,obj.col);
            decode_array = bpop.*(2.^superscript_set);
            for i =1:obj.col
                dpop(:,i) = sum(decode_array(:,code_length*i -(code_length - 1):i * code_length),2);
            end
        end
        
        function mtpop = mutation(obj,bpop)
            mtpop = bpop;
            for i = 1:obj.row
                r1 = 0; r2 = 0; r3 =0;
                while i == r1 || i == r2 || i == r3 || r1 ==r2 || r1 ==r3 || r2 == r3
                    r1 = unidrnd(obj.row);
                    r2 = unidrnd(obj.row);
                    r3 = unidrnd(obj.row);
                end
                mtpop(i,:) = mtpop(r1,:);
                d = sum(xor(mtpop(r2,:),mtpop(r3,:)));
                pup = obj.F * d - floor(obj.F * d);
                if rand < pup
                    pointary = randperm(3*obj.col);
                    point = pointary(1:ceil(obj.F * d));
                    for j = 1 : length(point)
                        mtpop(i,point(j)) = ~mtpop(r1,point(j));
                    end
                else
                    pointary = randperm(3*obj.col);
                    point = pointary(1:floor(obj.F * d));
                    for j = 1 : length(point)
                        mtpop(i,point(j)) = ~mtpop(r1,point(j));
                    end
                end
            end
        end
            
            function bpop = crossover(obj,csvmtpop,bpop)
                csvpop = zeros(obj.row,3 * obj.col);
                for i = 1:obj.row
                    for j = 1:3*obj.col
                        if rand <= obj.cr || j == unidrnd(3*obj.col)
                            csvpop(i,j) = csvmtpop(i,j);
                        else
                            csvpop(i,j) = bpop(i,j);
                        end
                    end
                end
                bpop = csvpop;
            end
            
            function [bpop,rslt] = selection(obj,bpop,sltcsvpop,rslt)
                % sltpop = zeros(obj.row,3*obj.col);
                dsltpop = obj.decoding(sltcsvpop);
                sltrslt = obj.problem.solve(dsltpop);
                idx = find(rslt>sltrslt);
                bpop(idx,:) = sltcsvpop(idx,:);
                dpop = obj.decoding(bpop);
                rslt = obj.problem.solve(dpop);
            end
            
            function bestpop = iter(obj)
                bpop = unidrnd(2,obj.row,3*obj.col) - 1;
                dpop = obj.decoding(bpop);
                rslt = obj.problem.solve(dpop);
                for i = 1:obj.iternum
                    %     [bpop,rslt] = obj.encoding(pop);
                    mpop = obj.mutation(bpop);
                    cpop = obj.crossover(mpop,bpop);
                    [bpop,rslt] = obj.selection(bpop,cpop,rslt);
                end
                
                bestpop = roundn(mean(obj.decoding(bpop)),0);
            end
        
    end
    
end

