%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>

// Define the maximum number of tokens
#define MAX_TOKENS 1000

// Define the structure for tokens
typedef struct {
    char original_lexeme[100];  // Store original lexeme
    char lexeme[100];           // Normalized lexeme for counting
    char token[100];
    int count;
} Token;


// Array to hold tokens
Token tokens[MAX_TOKENS];
// Counter for the n.o of token
int token_count = 0;
// Counter for the line n.o
int line_number = 1;
// Flag to indicate if an error occurred
int error_occurred = 0;

// Function to add a token to the token array
void add_token(const char* lexeme, const char* token) {
    // Convert lexeme to lowercase for counting
    char lowercase_lexeme[100];
    int len = strlen(lexeme);
    for (int i = 0; i < len; i++) {
        lowercase_lexeme[i] = tolower(lexeme[i]);
    }
    lowercase_lexeme[len] = '\0';

    // Check if the lowercase lexeme already exists
    for (int i = 0; i < token_count; i++) {
        if (strcmp(tokens[i].lexeme, lowercase_lexeme) == 0) {
            tokens[i].count++;
            return;
        }
    }

    // If lexeme not found, add it as a new token
    strcpy(tokens[token_count].original_lexeme, lexeme);  // Store original lexeme
    strcpy(tokens[token_count].lexeme, lowercase_lexeme); // Store normalized lexeme for counting
    strcpy(tokens[token_count].token, token);
    tokens[token_count].count = 1;
    token_count++;
}

// Function to print tokens
void print_tokens() {
    // Sort tokens by lexeme
    for (int i = 0; i < token_count - 1; i++) {
        for (int j = i + 1; j < token_count; j++) {
            if (strcmp(tokens[i].lexeme, tokens[j].lexeme) > 0) {
                Token temp = tokens[i];
                tokens[i] = tokens[j];
                tokens[j] = temp;
            }
        }
    }

    // Print header
    printf(" %-10s %s %-20s\n", "TOKEN", "COUNT", "LEXEME");
    // Print tokens
    for (int i = 0; i < token_count; i++) {
        printf(" %-10s %d %-20s\n", tokens[i].token, tokens[i].count , tokens[i].original_lexeme);
    }
}

// Function to handle errors
void yyerror(const char* msg) {
    if (!error_occurred) {
// Print error mssg with line n.o 
        fprintf(stderr, "Bruh it is an ERROR: %s at line %d\n", msg, line_number);
        error_occurred = 1; // set  error flag
    }
}

%}

%option noyywrap 

%%



\n              { line_number++; }
[ \t\r\f]+      { /* Ignore whitespace */ }

"ARRAY"|"BEGIN"|"BOOLEAN"|"COMMENT"|"CONTINUE"|"DO"|"DOUBLE"|"ELSE"|"END"|"FALSE"|"FOR"|"IF"|"INTEGER"|"LABEL"|"LIST"|"LONG"|"OWN"|"PROCEDURE"|"STEP"|"SWITCH"|"THEN"|"TRUE"|"UNTIL"|"VALUE"|"WHILE" { add_token(yytext, "KEYWORD"); }

"AND"|"OR"|"LEQ"|"UT"|"GEQ"|"GT"|"NOT"|"EQL"|"NEQ"|"\\|\\|"|"&&"|"<<|>>|<=|>=|="|":="|"\\+|-|\\*|/|%|\\^"  { add_token(yytext, "OPERATOR"); }
[<>!=]          { yyerror("Invalid operator"); }

"{"[^}]*"}"     { /* Ignore comments */ }

[A-Za-z][A-Za-z0-9]* {
    add_token(yytext, "IDENTIFIER");
}

\"([^\"]*)\"    { add_token(yytext, "STRING"); }
\'([^\']*)\'    { add_token(yytext, "STRING"); }

"("|")"|";"|":"|","|"''"|"\\["|"\\]"|"\\{"|"\\}"|"\\("|"\\)"  { add_token(yytext, "DELIMITER"); }

0[Xx][0-9A-Fa-f]+ {
    if (strlen(yytext) == 3) { // Ensure only "0x1", not "0x01"
        add_token(yytext, "HEXADECIMAL");
    } else {
        yyerror("Invalid hexadecimal literal");
    }
}

[1-9][0-9]* {
    add_token(yytext, "INTEGER");
}

[0-9]+\.[0-9]{1,6} {
    add_token(yytext, "FLOATING_POINT");
}

. {
    yyerror("Invalid character or ill-formed string");
}

%%

int main(int argc, char **argv) {
    if (argc > 1) {
        FILE *file = fopen(argv[1], "r");
        if (!file) {
            fprintf(stderr, "Error: Could not open file %s\n", argv[1]);
            return 1;
        }
        yyin = file;
    }
    yylex();
    print_tokens();
    return 0;
}

