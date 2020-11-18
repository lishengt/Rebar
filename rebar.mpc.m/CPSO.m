classdef CPSO
    properties
        n_individuas = 30;
        n_var = 2;
        
    end
    
    methods
        function obj = CPSO(inputArg1,inputArg2)
        %UNTITLED 构造此类的实例
        %   此处显示详细说明
        obj.Property1 = inputArg1 + inputArg2;
        end
        
        function outputArg = method1(obj,inputArg)
        %METHOD1 此处显示有关此方法的摘要
        %   此处显示详细说明
        outputArg = obj.Property1 + inputArg;
        end
    end
end

