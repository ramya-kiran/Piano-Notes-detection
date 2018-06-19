function [img] = detecting_Notes(rawimg,template1,template2,template3,color1,color2,color3)

 [~,l] = size(template3);
 l = l + 5;

 [g] = hough_Transform(rawimg);

 [img2,r2,c2] = hammingDist(rawimg,template1,template2,template3,color1,color2,color3);
 
 
g1 = g(1:5);
threshold1 = mean(diff(g1,1));
g2 = g(6:10);
threshold2 = mean(diff(g2,1));
 
 for i = 1:length(r2)
% checking if the note is in bass or trebel staff.    
    if (r2(i)) < (g(5) + 10)
% checking if the note is in between the rows detected by Hough Transform
       if (r2(i)  < g(1))
         img2 = insertText(img2,[(c2(i) -l) (r2(i) - 10)],'F','FontSize', 18,'textColor','red','BoxOpacity',0); 
       elseif ((r2(i)) == g(1))
         img2 = insertText(img2,[(c2(i) -l) (r2(i) - 10)],'E','FontSize', 18,'textColor','red','BoxOpacity',0);
       elseif ((r2(i)) > g(1)) && ((r2(i)) < g(2))
         img2 = insertText(img2,[(c2(i) -l) (r2(i) - 10)],'D','FontSize', 18,'textColor','red','BoxOpacity',0);
       elseif ((r2(i)) == g(2))
         img2 = insertText(img2,[(c2(i) -l) (r2(i) - 10)],'C','FontSize', 18,'textColor','red','BoxOpacity',0);
       elseif (r2(i)  > g(2)) && (r2(i) < g(3))
         img2 = insertText(img2,[(c2(i) -l) (r2(i) - 10)],'B','FontSize', 18,'textColor','red','BoxOpacity',0);
       elseif (r2(i)  == g(3))
         img2 = insertText(img2,[(c2(i) -l) (r2(i) - 10)],'A','FontSize', 18,'textColor','red','BoxOpacity',0);
       elseif (r2(i)> g(3)) && (r2(i) < g(4))
         img2 = insertText(img2,[(c2(i) -l) (r2(i) - 10)],'G','FontSize', 18,'textColor','red','BoxOpacity',0); 
       elseif (r2(i) == g(4))
         img2 = insertText(img2,[(c2(i) -l) (r2(i) - 10)],'F','FontSize', 18,'textColor','red','BoxOpacity',0); 
       elseif (r2(i) > g(4)) && (r2(i) < (threshold1 / 2))
         img2 = insertText(img2,[(c2(i) -l) (r2(i) - 10)],'E','FontSize', 18,'textColor','red','BoxOpacity',0); 
       elseif (r2(i) > g(4)) && (r2(i) > (threshold1/2))
         img2 = insertText(img2,[(c2(i) -l) (r2(i) - 10)],'C','FontSize', 18,'textColor','red','BoxOpacity',0); 
       elseif (r2(i) == g(5))
         img2 = insertText(img2,[(c2(i) -l) (r2(i) - 10)],'D','FontSize', 18,'textColor','red','BoxOpacity',0);
       end
        
    else
       if (r2(i) < g(6)) && (r2(i) >(g(6) - threshold2))
         img2 = insertText(img2,[(c2(i) -l) (r2(i) - 10)],'A','FontSize', 18,'textColor','red','BoxOpacity',0);
       elseif (r2(i) == g(6))
         img2 = insertText(img2,[(c2(i) -l) (r2(i) - 10)],'G','FontSize', 18,'textColor','red','BoxOpacity',0);
       elseif (r2(i)  > g(6)) && (r2(i)  < g(7))
         img2 = insertText(img2,[(c2(i) -l) (r2(i) - 10)],'F','FontSize', 18,'textColor','red','BoxOpacity',0);
       elseif (r2(i)  == g(7))
         img2 = insertText(img2,[(c2(i) -l) (r2(i) - 10)],'E','FontSize', 18,'textColor','red','BoxOpacity',0);
       elseif (r2(i) > g(7)) && (r2(i)< g(8))
         img2 = insertText(img2,[(c2(i) -l) (r2(i) - 10)],'D','FontSize', 18,'textColor','red','BoxOpacity',0);
       elseif (r2(i) == g(8))
         img2 = insertText(img2,[(c2(i) -l) (r2(i) - 10)],'C','FontSize', 18,'textColor','red','BoxOpacity',0);
       elseif (r2(i) > g(8)) && (r2(i) < g(9))
         img2 = insertText(img2,[(c2(i) -l) (r2(i) - 10)],'B','FontSize', 18,'textColor','red','BoxOpacity',0);
       elseif (r2(i) == g(9))
         img2 = insertText(img2,[(c2(i) -l) (r2(i) - 10)],'A','FontSize', 18,'textColor','red','BoxOpacity',0);
       elseif (r2(i) > g(9)) && (r2(i)  < g(10))
         img2 = insertText(img2,[(c2(i) -l) (r2(i) - 10)],'G','FontSize', 18,'textColor','red','BoxOpacity',0);
       elseif (r2(i) ==( g(6) - threshold2))
         img2 = insertText(img2,[(c2(i) -l) (r2(i) - 10)],'B','FontSize', 18,'textColor','red','BoxOpacity',0);
       elseif r2(i) < (g(6) - threshold1)&& (r2(i) > (g(6) - 2*threshold2))
         img2 = insertText(img2,[(c2(i) -l) (r2(i) - 10)],'C','FontSize', 18,'textColor','red','BoxOpacity',0); 
       end 
        
    end
   
      
 end
 
 
 
 
 img = img2;
 
 
 
 
end




