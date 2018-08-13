/* A Bison parser, made by GNU Bison 3.0.2.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2013 Free Software Foundation, Inc.

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

#ifndef YY_YY_Y_TAB_H_INCLUDED
# define YY_YY_Y_TAB_H_INCLUDED
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
    INTEGER = 258,
    REAL = 259,
    NUMBER = 260,
    ID = 261,
    TYPE = 262,
    PROGRAM = 263,
    VAR = 264,
    READLN = 265,
    WRITELN = 266,
    IF = 267,
    THEN = 268,
    ELSE = 269,
    ATTR = 270,
    GEQ = 271,
    LEQ = 272,
    NEQ = 273,
    EXPR = 274,
    MOD = 275,
    DIV = 276,
    DECL = 277,
    STMTS = 278,
    START = 279,
    END = 280,
    WHILE = 281,
    DIFF = 282,
    UMINUS = 283
  };
#endif
/* Tokens.  */
#define INTEGER 258
#define REAL 259
#define NUMBER 260
#define ID 261
#define TYPE 262
#define PROGRAM 263
#define VAR 264
#define READLN 265
#define WRITELN 266
#define IF 267
#define THEN 268
#define ELSE 269
#define ATTR 270
#define GEQ 271
#define LEQ 272
#define NEQ 273
#define EXPR 274
#define MOD 275
#define DIV 276
#define DECL 277
#define STMTS 278
#define START 279
#define END 280
#define WHILE 281
#define DIFF 282
#define UMINUS 283

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef int YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_Y_TAB_H_INCLUDED  */
