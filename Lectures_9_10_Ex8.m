%Exercicio 8
function [epochs,Eouts] = Lectures_9_10_Ex8()


%%Implementation of the Stochastic Gradient Descent SGD


%learning rate
eta = 0.01;



for run = 1:100
    %initalization of epoch counter
    epoch = 0;
    
    %initialization of weights
    w = [0,0,0];
    w_past= [1,1,1];
    
    %Generate Target Funcgtion and Data Points
    
    [X,Y,line_points] = generateTarget();
    
    
    while(norm(w-w_past,'fro')>0.01)
        
        %increment the epoch counter
        epoch = epoch + 1;
        
        %update w_past
        w_past = w;
        
        %shuffle the indexes
        idx = randperm(100);
        
        for k = 1:length(X)
            i = idx(k);
            
            grad = -Y(i).*(X(i,:))./(1 + exp(Y(i)*w*X(i,:)'));
            
            w = w -  eta*grad;
        end
        
        
    end
    epochs(run) = epoch;
    
    [X,Y] = generateAndClassifyPoints(line_points);
    
    X = [ones(length(X),1) X];
    
    Eouts(run) = (1/100)*sum(log(1+exp(-1*Y.*(w*X'))));
    
    
end



















end


function [y] = which_side(LA,LB,P)

Ax = LA(1);
Ay = LA(2);
Bx = LB(1);
By = LB(2);
Cx = P(1);
Cy = P(2);
CAB = (Bx - Ax) * (Cy - Ay) - (By - Ay) * (Cx - Ax);

if(CAB>0)
    y = 1;
    scatter(P(1),P(2),'b','filled');
else
    y = -1;
    scatter(P(1),P(2),'r','filled');
end
end

function [X,Y,line_points] = generateTarget()

%Generate 2 random numbers to create the line
a = -1;
b = 1;


line_points = a + (b-a).*rand(2,2);
if(line_points(2,1)<line_points(1,1))
    temp = line_points(1,1);
    line_points(1,1) = line_points(2,1);
    line_points(2,1) = temp;
end

%Compute the coeficients of the line

coefficientes = polyfit(line_points(:,1),line_points(:,2),1);

%Compute the y value of points in x = 1 and x = -1
y1 = coefficientes(1)*(-1)+ coefficientes(2);
y2 = coefficientes(1)*(1) + coefficientes(2);

plot([-1,1],[y1,y2]);
hold on

%Generate 100 random points

X = a + (b-a).*rand(100,2);

%Classify the random points
for i = 1:length(X)
    res = which_side(line_points(1,:),line_points(2,:),X(i,:));
    Y(i) = res;
end

%Add the bias term to X

X = [ones(length(X),1), X];



end


function [X,Y] = generateAndClassifyPoints(line_points)
a = -1;
b = 1;

%Generate 100 random points

X = a + (b-a).*rand(100,2);

%Classify the random points
for i = 1:length(X)
    res = which_side(line_points(1,:),line_points(2,:),X(i,:));
    Y(i) = res;
end


end
