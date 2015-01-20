classdef  Food < handle %% Food class 
    properties
        pos = [0 0];    %% Position on the map
        foodSpare = 1;  %% Food value of the food
    end     
    methods
        
        %%% Constructor 
        % size: size of the map
        % foodSpare: value of the food
        function obj = Food(size, foodSpare) 
            switch nargin
                case 2
                    obj.foodSpare = foodSpare;
                    obj.pos = [round(rand*size) round(rand*size)];
                case 1
                    obj.foodSpare = round(rand*4)+1;
                    obj.pos = [round(rand*size) round(rand*size)];
                otherwise
                    obj.foodSpare = round(rand*4)+1;
                    obj.pos = [round(rand*100)  round(rand*100)];
            end
        end
    end
end