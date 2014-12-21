classdef  Food < handle
    properties
        posX = 0;
        posY = 0;
    end     
    methods
        
        function obj = Food(size)
            switch nargin
                case 1
                    obj.posX = round(rand * size);
                    obj.posY = round(rand * size);
                otherwise
                    obj.posX = round(rand * 100);
                    obj.posY = round(rand * 100);
            end
        end
    end
end