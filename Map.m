classdef Map < handle
    
    properties
        mapSize = [100 100];    % map size is 100*100 
        
        bugs = [];              % bugs on the map
        foodSupply = [];        % food on the map
        obstacles = [];         % obstacles on the map
    end
    
    methods
        function obj = Map(insectsNumber, mapSize)
            if nargin == 2
                obj.mapSize = [mapSize mapSize];
            elseif nargin == 0
                insectsNumber = 5;    
            end
            % n number of obstacles will be placed on the map
            n = round(rand*(obj.mapSize(1)*obj.mapSize(2))*0.01)+1;
            % this for loop adds random positioned obstacles to the map
            for i = 1:n
                x = round(rand*obj.mapSize(1))+1;
                y = round(rand*obj.mapSize(2))+1;
                obj.obstacles = [obj.obstacles Obstacle([x y],1)];
            end
            
            % this for loop adds random number of insects
            for i = 1:insectsNumber
                obj.bugs = [obj.bugs Insect(obj.mapSize(1))];
            end
        end
        
        % plots all of the objects on the map
        function plot(self)
            arrayfun(@step, self.bugs);
            arrayfun(@plot, self.foodSupply);
            arrayfun(@plot, self.obstacles);
            arrayfun(@plot, self.bugs);
        end 
        
%         function path = shortestPath(self, posFrom, posTo, vel)
%             pathVec = posTo - posFrom;
%             pathVec(1) = (pathVec(1) / norm(pathVec))*vel;
%             pathVec(2) = (pathVec(2) / norm(pathVec))*vel;            
%             path = arrayfun(@round,pathVec);
%         end
        
        function nextStep = calcNextSteps(self, posFrom, posTo)
            if nargin == 3
                nextPos = posTo;
                possibleSteps = self.getPosSteps(nextPos);
                possibleSteps = Map.quicksort(possibleSteps,posFrom);
                
                while possibleSteps(1) ~= posFrom
                    nextPos = possibleSteps(1);
                    possibleSteps(1) = [];
                    possibleSteps = [possibleSteps; self.getPosSteps(nextPos);]; %#ok<AGROW>
                    possibleSteps = Map.quicksort(possibleSteps, posFrom);
                end
                nextStep = nextPos;
            end
            
            if nargin == 2
                goodStep=false;
                while ~goodStep
                    step = [round(rand*2)-1 round(rand*2)-1];
                    goodStep = self.isValidPos(posFrom + step);
                end
                nextStep = posFrom + step;
            end
        end
        
        
        function moreValidPos = getPosSteps(self, posFrom)
            moreValidPos = [];
            for i = -1:1
                for j = -1:1
                    if self.isValidPos(posFrom + [i j]) 
                        if i~=0 || j ~=0 
                            moreValidPos = [moreValidPos; posFrom + [i j]]; %#ok<AGROW>
                        end
                    end
                end
            end
        end
        
        function isValidPos = isValidPos(self, pos)
            isValidPos = true;
            s = size(self.obstacles);
            for i = 1:s(2)
                if pos == self.obstacles(i).pos
                    isValidPos = false;
                end
            end
            if pos(1)<0 || pos(1)>self.mapSize(1)
                isValidPos = false;
            end
            if pos(2)<0 || pos(2)>self.mapSize(2)
                isValidPos = false;
            end
        end
    end
    
    methods(Static)
        function index = isCloser(pos1, pos2, posTo)
           pathVec1 = posTo - pos1;
           pathVec2 = posTo - pos2;
           index = (norm(pathVec1) < norm(pathVec2)) ; 
        end
        
        function [sortedStepVec] = quicksort(stepVec, posTo)
            s = size(stepVec);
            for j = 1:s(1)-1
                for i = 1:s(1)-j
                    if Map.isCloser(stepVec(i,:),stepVec(i+1,:),posTo)
                        idStepVec = stepVec(i,:);
                        stepVec(i,:) = stepVec(i+1,:);
                        stepVec(i+1,:) = idStepVec;
                    end
                end
            end
            sortedStepVec = stepVec;
        end
        
        function isContains = contains(stepVec, goal)
            isContains = false;
            s = size(stepVec);
            for i = 0:s(2)
                if goal == stepVec(i) 
                    isContains = true;
                    break;
                end;
            end
        end
    end
end
