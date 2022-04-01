classdef restriction
    %RESTRICTION Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        mask;
        type;
        size;
    end
    
    methods
        function obj = restriction(type,x,y)
            %RESTRICTION Construct an instance of this class
            %   Detailed explanation goes here
            % Zero = no-go
            % > zero different go regions
            mask = ones(y,x);
            switch type
                case 'Free'
                    mask = ones(y,x);
                case 'Restricted - isotropic'
                    mask = ones(y,x);
                    r = 15;
                    search_region = r*2;
                    for i = 1+r:50:x+10
                        for j = 1+r:50:y+10
                            for k = i-search_region:i+search_region
                                ki = k;
                                if k < 1
                                    ki = 1;
                                elseif k > x
                                    ki = x;
                                end
                                for l = j-search_region:j+search_region
                                    li = l;
                                    if l < 1
                                        li = 1;
                                    elseif l > y
                                        li = y;
                                    end
                                    if sqrt((ki-i)^2 + (li-j)^2) < r
                                        mask(li,ki) = 0;
                                    end
                                end
                            end
                        end
                    end
                case 'Restricted - anisotropic1'
                    mask = ones(y,x);
                    ymiddle = y/2;
                    r = 30;
                    for j = 1:y
                        if abs(j - ymiddle) > r
                            mask(j,:) = 0;
                        end
                    end
                    xinds1 = round([1:x/5, 2*x/5:3*x/5, 4*x/5:x]);
                    xinds2 = round([x/7:x/2-20, x/2+20:6*x/7]);
                    mask(ymiddle-r/2-2:ymiddle-r/2+2, xinds1) = 0;
                    mask(ymiddle-2:ymiddle+2, xinds2) = 0;
                    mask(ymiddle+r/2-2:ymiddle+r/2+2, xinds1) = 0;
                case 'Restricted - anisotropic2'
                    mask = ones(y,x);
                    ymiddle = y/2;
                    xmiddle = x/2;
                    r = 30;
                    for i = 1:x
                        for j = 1:y
                            if abs(j - ymiddle) > r && abs(i - xmiddle) > r
                                mask(j,i) = 0;
                            end
                        end
                    end
                case 'Restricted - an+isotropic'
                    %%
                    mask = ones(y,x);
                    ymiddle = y/2;
                    r1 = 30;
                    
                    for j = 1:ymiddle-r1-1
                        mask(j, :) = 2;
                    end
                    for j = ymiddle+r1+10:y
                        mask(j,:) = 2;
                    end
                    
                    for j = 1:y
                        val = abs(j - ymiddle);
                        if (val > r1) && (val < r1 + 10)
                            mask(j,:) = 0;
                        end
                    end
                    
                    r2 = 15;
                    search_region = r2*2;
                    for i = 1+r2+5:50:x+10
                        for j = 1+2*r2:50:ymiddle-r1
                            for k = i-search_region:i+search_region
                                ki = k;
                                if k < 1
                                    ki = 1;
                                elseif k > x
                                    ki = x;
                                end
                                for l = j-search_region:j+search_region
                                    li = l;
                                    if l < 1
                                        li = 1;
                                    elseif l > y
                                        li = y;
                                    end
                                    if sqrt((ki-i)^2 + (li-j)^2) < r2
                                        mask(li,ki) = 0;
                                    end
                                end
                            end
                        end
                    end
                    xinds1 = round([1:x/5, 2*x/5:3*x/5, 4*x/5:x]);
                    xinds2 = round([x/7:x/2-20, x/2+20:6*x/7]);
                    mask(ymiddle-r1/2-2:ymiddle-r1/2+2, xinds1) = 0;
                    mask(ymiddle-2:ymiddle+2, xinds2) = 0;
                    mask(ymiddle+r1/2-2:ymiddle+r1/2+2, xinds1) = 0;
            end
            % Set edges
%             mask(:,1:2) = 1;
%             mask(:,end-1:end) = 1;
%             mask(1:2,:) = 1;
%             mask(end-1:end,:) = 1;
            obj.mask = mask;
        end
        
    end
end

