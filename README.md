## UrbanThings

#### Trade-offs: 
I keep everything in one View Controller, it would definitely be better to encapsulate
all the lift logic in some lift service which can be injected into some View Controller.
I also define all methods as public which is also something I would not do in a 
production environment. If you look at the tests you can see that I wrote new 
tests for each task (each branch), I tried reusing the tests from task one in the second 
task but since I was in a hurry I just changed them to solve the second task, obviously
that is not very good since it would be better to add task2 tests without needing to 
change all the tests from the first one. Task3 is the only branch that does not have 
100% test coverage. I skipped gitignore, so unwanted files maybe 
present. Also the git history is in a minor mess because I added the assignment 
descritpion from the github page not locally. 

#### How to Run:
- get a mac \
- download  Xcode 10 \
- swift language version 4.2
- open UrbanThings.xcodeproj \
- set signing in general tab \
- build and run with command+r \
- test with command+u \

