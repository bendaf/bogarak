classdef Map
    
    properties
        mapSize = [100 100];    % map size is 100*100 
        
        bugs = [];              % bugs on the map
        foodSupply = [];        % food on the map
        obstacles = [];         % obstacles on the map
    end
    
    methods
        function obj = Map(insectsNumber)
            % n number of obstacles will be placed on the map
            n = round(rand*(obj.mapSize(1)*obj.mapSize(2))*0.01)+1;
            % this for loop adds random positioned obstacles to the map
            for i = 1:n
                x = round(rand*obj.mapSize(1))+1;
                y = round(rand*obj.mapSize(2))+1;
                obj.obstacles = [obj.obstacles Obstacle([x y],2)];
            end
            
            % this for loop adds random number of insects
            for i = 1:insectsNumber
                obj.bugs = [obj.bugs Insect(obj.mapSize(1))];
            end
        end
        
        % plots all of the objects on the map
        function plot(self)
            arrayfun(@plot, self.foodSupply);
            
            arrayfun(@plot, self.obstacles);
            
            arrayfun(@plot, self.bugs);
            arrayfun(@step, self.bugs);
        end
    end
end
