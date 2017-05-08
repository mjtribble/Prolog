%% Melody Tribble
%% CSCI305 Spring 2017
%% Programing Lab 3 Prolog
%% Sources: http://www.learnprolognow.org, www.github.com, www.stackoverflow.com, 
%% Collaborators: Morgan Johnson, Mandy Hawkins, Ken Taylor, Tina Yin, Courtney Linder...

% Question 1
%% Knowledge base given:
connected(1,2).
connected(3,4).
connected(5,6).
connected(7,8).
connected(9,10).
connected(12,13).
connected(13,14).
connected(15,16).
connected(17,18).
connected(19,20).
connected(4,1).
connected(6,3).
connected(4,7).
connected(6,11).
connected(14,9).
connected(11,15).
connected(16,12).
connected(14,17).
connected(16,19).

%% Basecase:
%% This checks to see if there is a direct connection between X, and Y.
%% X = start, Y = end. 
path(X,Y):- connected(X,Y).

%% Recursive:
%% This recursivly checks to see if there are any ways to get from 
%% X to Y using multiple connections in our knowledge base. 
path(X,Y):-
	%% If there is a connection from X to any other number(Z).
	connected(X,Z), 
	%% Then call path with Z and the our destination number (Y)
	path(Z,Y).


% Question 2
%% Given knowledge base
byCar(auckland,hamilton).
byCar(hamilton,raglan).
byCar(valmont,saarbruecken).
byCar(valmont,metz).

byTrain(metz,frankfurt).
byTrain(saarbruecken,frankfurt).
byTrain(metz,paris).
byTrain(saarbruecken,paris).

byPlane(frankfurt,bangkok).
byPlane(frankfurt,singapore).
byPlane(paris,losAngeles).
byPlane(bangkok,auckland).
byPlane(singapore,auckland).
byPlane(losAngeles,auckland).

%% Basecases:
%% These functors check if there is a direct rule for getting
%% from location X to location Y via car, train  or plane.
%% X = origin city, Y = destination city.
travel(X,Y):-byCar(X,Y).
travel(X,Y):-byTrain(X,Y).
travel(X,Y):-byPlane(X,Y).

%% Recursive 
%% This runs through all the options of getting from X to Y..
%% either by taking more than one trip in one type of transportaion( Car, Train, Plane, )
%% or by taking multiple types of transportation. 
travel(X,Y):-
	% If we can we get from X to any other destination (Z) by car, train, or plane;
	% Then recursivly check if we can travel from Z to our final destination Y
	byCar(X,Z), travel(Z,Y);
	byTrain(X,Z), travel(Z,Y);
	byPlane(X,Z), travel(Z,Y).

% Question 3

%% Basecase to check for a direct rule from X to Y.
%% This Takes in our original location(X), our destination(Y),
%% and a placeholder go(X,Y) to keep track of our transfers.
travel(X,Y,go(X,Y)):- byCar(X,Y).
travel(X,Y,go(X,Y)):- byTrain(X,Y).
travel(X,Y,go(X,Y)):- byPlane(X,Y).

%% This recursively checks for multiple transfers to get from X to Y,
%% keeps track of transfers with go(X,Z,R).
%% X is our origin, 
%% Z is an unknown variable for our transfer city, 
%% R is a placeholder for our next transfer. (notice R is not present in the basecase functors) 
travel(X,Y,go(X,Z,R)):- 
	byCar(X,Z), travel(Z,Y,R);
	byPlane(X,Z), travel(Z,Y,R);
	byTrain(X,Z), travel(Z,Y,R).

	

% Extra Credit

%% Basecase, only a leaf is left(center of our tree)
%% Assign the Variable to the leaf.
%% X is a number in this example.
swap(leaf(X), leaf(X)).

%% This recursivly creates a reverse image of a binary tree through unification.
%% tree(T1,T2) represents a tree of trees that will be sent in to be reversed.
%% tree(V1, V2) represents the Variables that will hold the reversed tree in each recursive call.
swap(tree(T1,T2), tree(V1, V2)):-
	swap(T1,V2),
	swap(T2,V1).
