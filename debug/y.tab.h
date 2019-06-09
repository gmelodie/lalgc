/* A Bison parser, made by GNU Bison 3.0.4.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015 Free Software Foundation, Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

#ifndef YY_YY_BUILD_Y_TAB_H_INCLUDED
# define YY_YY_BUILD_Y_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    PROCEDURE = 258,
    PROGRAM = 259,
    DOT = 260,
    CONST = 261,
    READ = 262,
    WRITE = 263,
    ID = 264,
    VAR = 265,
    ATTR = 266,
    DIV = 267,
    MINUS = 268,
    PLUS = 269,
    TIMES = 270,
    RELATION_S = 271,
    EQUAL = 272,
    INTEGER = 273,
    INT = 274,
    REAL = 275,
    BEG = 276,
    END = 277,
    FOR = 278,
    WHILE = 279,
    CLOSE_PAR = 280,
    OPEN_PAR = 281,
    COLON = 282,
    COMMA = 283,
    SC = 284,
    DO = 285,
    IF = 286,
    ELSE = 287,
    THEN = 288
  };
#endif
/* Tokens.  */
#define PROCEDURE 258
#define PROGRAM 259
#define DOT 260
#define CONST 261
#define READ 262
#define WRITE 263
#define ID 264
#define VAR 265
#define ATTR 266
#define DIV 267
#define MINUS 268
#define PLUS 269
#define TIMES 270
#define RELATION_S 271
#define EQUAL 272
#define INTEGER 273
#define INT 274
#define REAL 275
#define BEG 276
#define END 277
#define FOR 278
#define WHILE 279
#define CLOSE_PAR 280
#define OPEN_PAR 281
#define COLON 282
#define COMMA 283
#define SC 284
#define DO 285
#define IF 286
#define ELSE 287
#define THEN 288

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef int YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_BUILD_Y_TAB_H_INCLUDED  */
