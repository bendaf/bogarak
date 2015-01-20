classdef Map
    
    properties
        size = [100 100];   % map size is 100*100 
        
        bugs = {};          % bugs on the map
        foodSupply = {};    % food on the map
        obstacles = {};     % obstacles on the map
    end
    
    methods
        function obj = Map
            % initialize other properties of the map
            % creates a 100 by 100 cell array with no contents
            obj.bugs = cell(obj.size(1),obj.size(2));
            obj.foodSupply = cell(obj.size(1),obj.size(2));
            obj.obstacles = cell(obj.size(1),obj.size(2));
            
            % number of obstacles
            n = round(rand*4)+1;
            % this for loop adds random positioned obstacles to the map
            for i = 1:n
                x = round(rand*obj.size(1))+1;
                y = round(rand*obj.size(2))+1;
                while obj.obstacles{x,y} ~= 0
                    x = round(rand*obj.size(1))+1;
                    y = round(rand*obj.size(2))+1;
                end
                obj.obstacles{x,y} = Obstacle;
            end
        end
        
        % plot the entire map
%         function plotMap()
% 
%         end
        
        % adds an insect to swarm
%         function addInsect()
%             
%         end
          
        % adds food at random position on the map
%         function addFood
%         
%         end
    end
    
end