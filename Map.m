classdef Map < handle
    
    properties
        mapSize = [100 100];    % map size is 100*100 
        
        bugs = [];              % bugs on the map
        foodSupply = [];        % food on the map
        obstacles = [];         % obstacles on the map
        stepCounter = 1;        % time 
        bugsInTime = [];        % Saved data of the bug population
    end
    
    methods
        function obj = Map(insectsNumber, mapSize, time)
            if nargin >= 3
                obj.mapSize = [mapSize mapSize];
            elseif nargin >= 2
                obj.mapSize = [mapSize mapSize];
                time = 200;
            elseif nargin == 0
                insectsNumber = 5;    
                time = 200;
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
            obj.bugsInTime = zeros(time,insectsNumber);
        end
        
        % plots all of the objects on the map
        function plot(self)
            clf;
            
            % plot the map
            subplot(1,2,1);
            title('Map')
            hold on;
            arrayfun(@plot, self.foodSupply);
            arrayfun(@plot, self.obstacles);
            arrayfun(@plot, self.bugs);
            axis([ 0 self.mapSize(1) 0 self.mapSize(2)]);
            
            % plot the foodSpare
            subplot(1,2,2);
            title('Foodspare of the bugs');
            hold on;
            s = size(self.bugs);
            for i = 1:s(2)
                line([i i],[0 self.bugs(i).foodSpare],'LineWidth',7);
            end
            axis([0 s(2)+1 0 12]);
            drawnow;
        end 
        
        % Make a step
        function self = step(self)
            
            % The bugs eat the food and other bugs under them
            self.eat(0);
            
            % Bugs calculate their next step
            s = size(self.bugs);
            for i = 1:s(2)
                if self.bugs(i).isAlive
                    if mod(self.stepCounter,7) == 0
                        self.bugs(i).decFoodSpare;
                    end
                    foodPos = self.nearestFood(self.bugs(i).pos);
                    self.bugs(i).setHeadDirection(foodPos);
                    self.bugs(i).pos=self.calcNextStep(self.bugs(i).pos, foodPos);
                    
%                     Speed algorithm
%                     if(self.bugs(i).foodSpare > 11)
%                         fs = 11;
%                     else
                        fs = self.bugs(i).foodSpare;
%                     end
                    if mod(self.stepCounter, round(fs)) == 0
                        self.bugs(i).pos=self.calcNextStep(self.bugs(i).pos, foodPos);
                    end
                end
            end
            
            % Place a new food randomly
            if(round(rand*4)==1)
                genFood = false;
                while ~genFood
                    idFood = Food(self.mapSize(1));
                    if self.isValidPos(idFood.pos)
                        self.foodSupply = [self.foodSupply idFood];
                        genFood = true;
                    end
                end
            end
            
            % Save bugs
            s = size(self.bugs);
            self.stepCounter
            for i = 1:s(2)
                self.bugsInTime(self.stepCounter, i) = self.bugs(i).foodSpare; 
            end
            
            %Increase stepcounter
            self.stepCounter = self.stepCounter + 1;
        end
        
        % Check which bug can eat and feed them
        function self = eat(self, version)
            if(version>0)
                self = eatEachOther(self);
            else
                self = eatDivideFood(self);
            end
        end
        
        function self = eatEachOther(self)
            % Bugs eat each other
            sb = size(self.bugs);
            for i = 1:sb(2)
                if self.bugs(i).isAlive
                    for j = i:sb(2)
                        if self.bugs(j).isAlive
                            if Map.isEqual(self.bugs(i).pos, self.bugs(j).pos) && i ~= j
                                self.bugs(i).eatFood(self.bugs(j));
                                self.bugs(j).foodSpare = 0;
                            end
                        end
                    end
                end
            end
            
            % Bugs eat the food
            sf = size(self.foodSupply);
            for i = 1:sf(2)
                %#In this version just one bug can eat the food
                for j = 1:sb(2)
                    if i<=sf(2) && i>0 && self.bugs(j).isAlive
                        if Map.isEqual(self.bugs(j).pos, self.foodSupply(i).pos)
                            self.bugs(j).eatFood(self.foodSupply(i));
                            self.foodSupply(i) = [];
                            i = i-1; %#ok<FXSET>
                            sf = size(self.foodSupply);
                        end
                    end
                end
            end
        end
        
        function self = eatDivideFood(self)
            % Bugs eat the food
            sb = size(self.bugs);
            sf = size(self.foodSupply);
            for i = 1:sf(2)
                %#In this version the bugs divide the food
                curBugs = 0;
                for j = 1:sb(2)
                    if i<=sf(2)
                        if Map.isEqual(self.bugs(j).pos, self.foodSupply(i).pos)
                            curBugs = curBugs + self.bugs(j).foodSpare;
                        end
                    end
                end
                if curBugs > 0 
                    for j = 1:sb(2)
                        if i<=sf(2)
                            if Map.isEqual(self.bugs(j).pos, self.foodSupply(i).pos)
                                self.bugs(j).eatFoodSpare(self.foodSupply(i).foodSpare * ...
                                (self.bugs(j).foodSpare/curBugs));
                            end
                        end
                    end 
                    self.foodSupply(i) = [];
                    i = i-1; %#ok<FXSET>
                    sf = size(self.foodSupply);
                end
            end
        end
        
        % return with the nearesr food or bug position to the pos
        function nfPos = nearestFood(self, pos)
            s = size(self.foodSupply);
            nearestBug = self.nearestBug(pos);  %% change this to search nearest bug
            if s(2) == 0
                nfPos = nearestBug;
            elseif s(2) == 1 && isempty(nearestBug)
                nfPos = self.foodSupply(1).pos;
            else % min search
                min = nearestBug;
                for i = 1:s(2)
                    if ~Map.isCloser(min,self.foodSupply(i).pos,pos)
                        min=self.foodSupply(i).pos;
                    end
                end
                nfPos = min;
            end
        end
        
        % calculate the next position for the bug
        function nextStep = calcNextStep(self, posFrom, posTo)
            % when we have destination
            if nargin == 3  && ~isempty(posTo) 
                nextPos = posTo;
                possibleSteps = self.getPosSteps(nextPos);
                possibleSteps = Map.quicksort(possibleSteps,posFrom);
                while ~Map.isEqual(possibleSteps(1,:), posFrom)
                    nextPos = possibleSteps(1,:);
                    possibleSteps(1,:) = [];
                    possibleSteps = [self.getPosSteps(nextPos); possibleSteps]; %#ok<AGROW>
                    possibleSteps = unique(possibleSteps,'rows');
                    possibleSteps = Map.quicksort(possibleSteps, posFrom);
                end
                nextStep = nextPos;
            end
            % when we don't have a destination just a random step
            if nargin == 2 || isempty(posTo)
                goodStep=false;
                while ~goodStep
                    step = [round(rand*2)-1 round(rand*2)-1];
                    goodStep = self.isValidPos(posFrom + step);
                end
                nextStep = posFrom + step;
            end
        end
        
        % return with the pos of the nearest bug in the radious
        function bugPos = nearestBug(self, pos, radius)
            if nargin == 2 
                bugPos = [];
            else
                bugPos = [];

                % search for the live bugs in the radious
                s = size(self.bugs);
                for i = -radius:radius
                    for j = -radius:radius
                        if i ~= 0 || j ~= 0
                            for ib = 1:s(2)
                                if Map.isEqual(pos + [i j], self.bugs(ib).pos) && ...
                                       self.bugs(ib).isAlive
                                    bugPos = [bugPos; pos + [i j]]; %#ok<AGROW>
                                end
                            end
                        end
                    end
                end
                % select the closest bug
                s = size(bugPos);
                if s(1)>1
                    bugPos = Map.quicksort(bugPos,pos);
                    bugPos = bugPos(1,:);
                end
            end
        end
        
        % Return with the reachable positions from the posFrom
        function moreValidPos = getPosSteps(self, posFrom)
            moreValidPos = zeros(9,2);
            count = 0;
            for i = -1:1
                for j = -1:1
                    if self.isValidPos(posFrom + [i j]) 
                        if i~=0 || j ~=0 
                            count = count + 1;
                            moreValidPos(count,:) = posFrom + [i j];
                        end
                    end
                end
            end
            moreValidPos = moreValidPos(1:count,:);
        end
        
        % Return with false if the pos is invalid on map
        function isValidPos = isValidPos(self, pos)
            isValidPos = true;
            s = size(self.obstacles);
            if pos(1)<0 || pos(1)>self.mapSize(1)
                isValidPos = false;
                return;
            end
            if pos(2)<0 || pos(2)>self.mapSize(2)
                isValidPos = false;
                return;
            end
            for i = 1:s(2)
                if Map.isEqual(pos, self.obstacles(i).pos)
                    isValidPos = false;
                    return;
                end
            end
        end
    end
    
    methods(Static)
        
        % return 0 if pos1 is closer to posTo than pos2 else 1
        function index = isCloser(pos1, pos2, posTo)
            % if one of the pos is empty then false
            if isempty(pos1)
                index = 0;
            else
%                 pathVec1 = ;
%                 pathVec2 = ;
                index = (norm(posTo - pos1) < norm(posTo - pos2)) ; 
            end
        end
        
        % check the equality of two pos
        function isEqual = isEqual(pos1, pos2)
            isEqual = pos1(1) == pos2(1) && pos1(2) == pos2(2);
        end
        
        % short the steps vector with optimized bublesort
        function [sortedStepVec] = quicksort(stepVec, posTo)
            if nargin<2
                sortedStepVec = stepVec;
            else
                s = size(stepVec);
                lastSwap = s(1)-1;
                for j = 1:s(1)-1
                    isSorted = true;
                    curSwap = -1;
                    for i = 1:lastSwap
                        if ~Map.isCloser(stepVec(i,:),stepVec(i+1,:), posTo)
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
                    end
                    lastSwap = curSwap;
                end
                sortedStepVec = stepVec;
            end
        end
    end
end
