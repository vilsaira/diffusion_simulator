classdef particle
    %PARTICLE Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        x;
        y;
        origx;
        origy;
    end
    
    methods
        
        function obj = particle(x,y)
            %PARTICLE Construct an instance of this class
            %   Detailed explanation goes here
            obj.x = x;
            obj.origx = x;
            obj.y = y;
            obj.origy = y;
        end
        
        function move(obj, restriction_mask)
            dx = 2.0*rand - 1.0;
            dy = 2.0*rand - 1.0;
            x = round(obj.x + dx);
            collidex = restriction_mask(x, obj.y);
            y = round(obj.y + dy);
            collidey = restriction_mask(obj.x, y);
            if collidex
                self.x = self.x - dx;
            else
                self.x = x;
            end
            if collidey
                self.y = self.y - dy;
            else
                self.y = y;
            end
        end
        
    end
end

