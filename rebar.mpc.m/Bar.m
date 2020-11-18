classdef Bar
    properties
        start;
        goal;
        current_location = 0;
        pre_location;
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

