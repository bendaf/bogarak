classdef Obstacle < handle
   
    properties
        pos = [0 0];    % this position is the upper left corner position
        size = 1;       % unit size obstacles
    end
    
    methods
        % obstacle contructor method
        function obj = Obstacle(pos, size)
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
                [self.pos(1)-0.5,self.pos(2)-0.5,self.size-0.5,self.size-0.5]);
        end
    end 
end