classdef Insect < Food
    properties
        headDirection = 0;
        foodSpare = 10;
    end
    
    methods
        function obj = Insect(size)
            if nargin == 0 
                size = 100;
            end
            obj@Food(size);
        end
        
        function remFoodSpare = decFoodSpare(self)
            self.foodSpare = self.foodSpare - 1;
            remFoodSpare = self.foodSpare;
        end
        
        %NEED TO MODIFY
        function direction = calcDirection(self, pos)
            direction = pos - self.pos;
        end
        
        function step(self,pos)
            switch nargin
                case 2
                    direction = self.calcDirection(pos);
                otherwise
                    direction = [round(rand*2)-1 round(rand*2)-1];
            end
            self.pos = self.pos + direction;
        end
        
        function eatFood(self, food)
            self.foodSpare = self. foodSpare + food.foodValue;
        end
    end
end