classdef Map
    
    properties
        size = [100 100];   % map size is 100*100 
        
        bugs = [];          % bugs on the map
        foodSupply = [];    % food on the map
        obstacles = [];     % obstacles on the map
    end
    
    methods
        function obj = Map
            % n number of obstacles will be placed on the map
            n = round(rand*4)+1;
            % this for loop adds random positioned obstacles to the map
            for i = 1:n
                x = round(rand*obj.size(1))+1;
                y = round(rand*obj.size(2))+1;
                obj.obstacles = [obj.obstacles Obstacle([x y],1)];
            end
        end
        
        % plot the entire map
        function plotMap(self)
            
        end
        
        % adds an insect to swarm
        function addInsect(self)
            
        end
          
        % adds food at random position on the map
        function addFood(index)
        
        end
        
        % removes an insect from a certain position (index)
        function removeInsect(index)
            % 
        end
        
        % removes a food object which has been eaten by an insect
        function removeFood(index)
        
        end
    end
    
end