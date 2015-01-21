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
                    foodSpare = round(rand*8)+2;
                case 1
                    foodSpare = round(rand*8)+2;
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
        
        %%%
        function plot(self)
            plot(self.pos(1),self.pos(2),'o');
            line([self.pos(1) self.pos(1)+cos(self.headDirection)], ...
                 [self.pos(2) self.pos(2)+sin(self.headDirection)]);
        end
    end
end
