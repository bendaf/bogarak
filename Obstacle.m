classdef Obstacle
   
    properties
        pos = [0 0];    % this position is the upper left corner position
        size = 1;       % unit size obstacles
    end
    
    methods
        function obj = Obstacle(pos, size) % obstacle contructor method
            switch nargin
                case 2
                    obj.pos = pos;
                    obj.size = size;
                case 1
                    obj.pos = pos;
                    obj.size = round(rand*10);
                otherwise
                    obj.pos = [round(rand*100) round(rand*100)];
                    obj.size = round(rand*10);
            end
        end
        
        function plot(self)
            rectangle('Position', ...
                [self.pos(1),self.pos(2),self.size,self.size]);
        end
    end 
end