classdef NFO
    properties
        row
        col
        lr
        cr
        iternum
        problem
    end
    
    methods
        function obj = NFO(n_individuals, n_vars, lr, cr, iternum, problem)
            obj.row = n_individuals;
            obj.col = n_vars;
            obj.lr = lr;
            obj.cr = cr;
            obj.iternum = iternum;
            obj.problem = problem;
        end
        
        function dpop = decode(obj,bpop)
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
        
        function [sup,inf] = location(obj,bpop,rslt)   
            %求hamming distance
            one_array = ones(obj.row,1);
            xcopy = kron(bpop,one_array);
            hamming_array = sum(xor(xcopy,repmat(bpop,obj.row,1)),2);
            hamming_distance = reshape(hamming_array,obj.row,obj.row);%对称矩阵
            %求xc
            [all_x_rslt,x_rslt] = meshgrid(rslt,rslt);
            c = all_x_rslt > x_rslt;
            c_hamming = c .* hamming_distance; %保留有效的hamming distance
            cmin = abs(log(c_hamming+0.00001));
            [~,cidx] = min(cmin);
            sup = bpop(cidx,:);
            w = all_x_rslt < x_rslt;
            w_hamming = w .* hamming_distance; %保留有效的hamming distance
            wmin = abs(log(w_hamming+0.00001));
            [~,widx] = min(wmin);
            inf = bpop(widx,:);
        end
        
        function bpop = crossover(obj,v,bpop)
            idxary = rand(obj.row,3*obj.col);
            [rows,cols] = find(idxary  < rand);
            jary = unidrnd(6,obj.row,3*obj.col);
            idxary = linspace(1,3*obj.col,3*obj.col);
            full_idxary = repmat(idxary,obj.row,1);
            [idxrow,idxcol] = find(jary == full_idxary);
            bpop(rows,cols) = v(rows,cols);
            bpop(idxrow,idxcol) = v(idxrow,idxcol);
        end
        
        function v = mutation(obj,bpop,xc,xw)
            r1 = rand(obj.row,3*obj.col) < rand;
            r2 = rand(obj.row,3*obj.col) < rand;
            v1 = and(r1,xor(xc,bpop));
            v2 = and(r2,xor(xc,xw));
            v = xor(bpop,or(v1,v2));
        end
        
        function [nextpop,rslt] = selection(obj,u,bpop,rslt)
            du = obj.decode(u);
            urslt = obj.problem.solve(du);
            idx = find(rslt>urslt);
            bpop(idx,:) = u(idx,:);
            decodenextpop = obj.decode(bpop);
            rslt = obj.problem.solve(decodenextpop);
            nextpop = bpop;
        end
        
        function bestpop = iter(obj)
            bx = unidrnd(2,obj.row,3*obj.col) - 1;
            dx = obj.decode(bx);
            prslt = obj.problem.solve(dx);
            [rslt,idx] = sort(prslt);%rslt为行向量
            bx = bx(idx,:);
            for i = 1:obj.iternum
                [xc,xw] = obj.location(bx,rslt);
                v = obj.mutation(bx,xc,xw);
                u = obj.crossover(v,bx);
                [bx,rslt] = obj.selection(u,bx,rslt);
            end
            bestpop = roundn(mean(obj.decode(bx)),0);
        end
            
    end  
end

