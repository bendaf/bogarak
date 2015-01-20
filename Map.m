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
            clf;
            hold on;
            arrayfun(@plot, self.foodSupply);
            arrayfun(@plot, self.obstacles);
            arrayfun(@plot, self.bugs);
            axis([ 0 self.mapSize(1) 0 self.mapSize(2)]);
            drawnow;
            
        end 
        
        function self = step(self)
            if(round(rand*10)==1)
                self.foodSupply = [self.foodSupply Food(self.mapSize(1))];
            end
            
            s = size(self.bugs);
            for i = 1:s(2)
                self.bugs(i).pos=self.calcNextStep(self.bugs(i).pos,...
               self.nearestFood(self.bugs(i).pos));
            end
        end
        
        function nfPos= nearestFood(self, pos)
            s = size(self.foodSupply);
            if s(2) == 0
                nfPos = [];
            elseif s(2) == 1
                nfPos = self.foodSupply(1,:).pos;
            else
                min = self.foodSupply(1,:).pos;
                for i = 2:s(2)
                    if ~Map.isCloser(min,self.foodSupply(i).pos,pos)
                        min=self.foodSupply(i,:);
                    end
                end
                nfPos = min;
            end
        end
        
        function nextStep = calcNextStep(self, posFrom, posTo)
            if nargin == 3  && ~isempty(posTo)
                nextPos = posTo;
                possibleSteps = self.getPosSteps(nextPos);
                possibleSteps = Map.quicksort(possibleSteps,posFrom);
                
                while possibleSteps(1,:) ~= posFrom
                    nextPos = possibleSteps(1,:);
                    possibleSteps(1,:) = [];
                    possibleSteps = [self.getPosSteps(nextPos); possibleSteps]; %#ok<AGROW>
                    possibleSteps = unique(possibleSteps,'rows');
                    possibleSteps = Map.quicksort(possibleSteps, posFrom);
%                     posTo = possibleSteps(1,:)
%                     posFrom = posFrom
                end
                nextStep = nextPos;
            end
            
            if nargin == 2 || isempty(posTo)
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
            lastSwap = s(1)-1;
            for j = 1:s(1)-1
                isSorted = true;
                curSwap = -1;
                for i = 1:lastSwap
                    if ~Map.isCloser(stepVec(i,:),stepVec(i+1,:),posTo)
                        idStepVec = stepVec(i,:);
                        stepVec(i,:) = stepVec(i+1,:);
                        stepVec(i+1,:) = idStepVec;
                        isSorted = false;
                        curSwap = i;
                    end
                end
                if(isSorted)
                    sortedStepVec = stepVec;
                    return;
                end;
                lastSwap = curSwap;
            end
            sortedStepVec = stepVec;
        end
    end
end
