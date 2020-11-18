classdef Bar
    properties
        start;
        goal;
        current = 0;
        type;
        color;
    end
    
    methods
        function obj = Bar(start,goal)
            obj.start = start;
            obj.goal = goal;
        end
    end
end

