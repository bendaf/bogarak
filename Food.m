classdef  Food < handle
    properties
        pos = [0 0];
        foodValue = 1;
    end     
    methods
        
        function obj = Food(size, foodValue)
            switch nargin
                case 2
                    obj.foodValue = foodValue;
                    obj.pos = [round(rand*size) round(rand*size)];
                case 1
                    obj.foodValue = round(rand*5);
                    obj.pos = [round(rand*size) round(rand*size)];
                otherwise
                    obj.foodValue = round(rand*5);
                    obj.pos = [round(rand*100)  round(rand*100)];
            end
        end
    end
end