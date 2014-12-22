classdef  Food < handle
    properties
        pos = [0 0];
        foodValue = 1;
    end     
    methods
        
        function obj = Food(size)
            switch nargin
                case 1
                    obj.pos = [round(rand*size) round(rand*size)];
                otherwise
                    obj.pos = [round(rand*100)  round(rand*100)];
            end
        end
    end
end