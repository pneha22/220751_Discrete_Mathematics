# 220751_Discrete_Mathematics
STAMATICS SUMMER 2024 PROJECT
To run Assignment 2 -
First download all the executive files - Flex,Bison,DevC++(if there is no gcc compiler before)
Use https://www.youtube.com/watch?v=ArtBEUvS3PI&list=PL4gu8xQu0_5I_Aghe6d3vhcjzddlMDEHp&index=1 to know how to setup in environment variable path.
Open Folder in which prob1.l is present and type cmd at its path search. Then Command Prompt will be opened in that folder.
Now (Run the following command to generate the C source code from your lex/flex file:) 
flex prob1.l 
( You can see lex.yy.c file created jin your folder)
(Now, you need to compile the generated lex.yy.c file using the gcc compiler.
Run the following command to compile it:)
gcc lex.yy.c 
(This will create output file a.exe in the same folder)
(Execute it with following command for the output of input.knp kanpur programs.Replace input.knp with the actual Kanpur program file.)
a input.exe

(Now you can see the output, outputs for the public1,2,3,4.knp files are given in images uploaded)
