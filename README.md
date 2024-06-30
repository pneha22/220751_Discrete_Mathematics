# 220751_Discrete_Mathematics
STAMATICS SUMMER 2024 PROJECT <br />
To run Assignment 2 - <br />
First download all the executive files - Flex,Bison,DevC++(if there is no gcc compiler before) <br />
Use https://www.youtube.com/watch?v=ArtBEUvS3PI&list=PL4gu8xQu0_5I_Aghe6d3vhcjzddlMDEHp&index=1 to know how to setup in environment variable path. <br />
Open Folder in which prob1.l is present and type cmd at its path search. Then Command Prompt will be opened in that folder. <br />
Now (Run the following command to generate the C source code from your lex/flex file:)  <br />
flex prob1.l  <br />
( You can see lex.yy.c file created jin your folder) <br />
(Now, you need to compile the generated lex.yy.c file using the gcc compiler. <br />
Run the following command to compile it:) <br />
gcc lex.yy.c  <br />
(This will create output file a.exe in the same folder) <br />
(Execute it with following command for the output of input.knp kanpur programs.Replace input.knp with the actual Kanpur program file.) <br />
a input.exe <br />

(Now you can see the output, outputs for the public1,2,3,4.knp files are given in images uploaded) <br />
