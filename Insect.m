classdef Insect < Food % Insect inherite from food (pos and foodSpare)
    properties
        headDirection = 0;  % Direction of the head in degrees
    end
    
    methods
        %%% Constructor 
        % size: size of the map
        % foodSpare: starting foodSpare of the insect
        function obj = Insect(size, foodSpare) 
            switch nargin
                case 0
                    size = 100;
                    foodSpare = round(rand*5)+3;
                case 1
                    foodSpare = round(rand*5)+3;
            end
            obj@Food(size, foodSpare);
        end
        
        %%% Decrease the food spare of the insect 
        % return the remaining food spare 
        function remFoodSpare = decFoodSpare(self)
            self.foodSpare = self.foodSpare - 1;
            remFoodSpare = self.foodSpare;
        end
        
        %%% Eat the food
        function remFoodSpare = eatFood(self, food)
            self.foodSpare = self.foodSpare + food.foodSpare;
            remFoodSpare = self.foodSpare;
        end
        
        %%% Eat the foodSpare
        function remFoodSpare = eatFoodSpare(self, foodSpare)
            self.foodSpare = self.foodSpare + foodSpare;
            remFoodSpare = self.foodSpare;
        end
        
        %%% Change the direction of the bug's head in the direction of the pos
        function self = setHeadDirection(self, pos)
            if isempty(pos)
                self.headDirection = rand*360;
            else
                delta = pos - self.pos;
                self.headDirection = atan2(delta(2), delta(1)) *180 / pi;
            end
        end
        
        function isAlive = isAlive(self)
            isAlive = self.foodSpare >= 1;
        end
        
        %%% Plot the insect
        function plot(self)
            if self.isAlive
                plot(self.pos(1),self.pos(2),'o');
                line([self.pos(1) self.pos(1)+cosd(self.headDirection)], ...
                 [self.pos(2) self.pos(2)+sind(self.headDirection)]);
            else
                plot(self.pos(1),self.pos(2),'ro');
                line([self.pos(1) self.pos(1)+cosd(self.headDirection)], ...
                 [self.pos(2) self.pos(2)+sind(self.headDirection)],'Color','r');
            end
        end
    end
end
