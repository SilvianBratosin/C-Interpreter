#include <stdio.h>
#include "Proiect.h"
#include "Proiect.tab.h"
#include <ctype.h>


extern FILE *yyout;

int ex(nodeType *p) 
{
	if (!p) return 0;
	
	switch(p->type) 
	{
		case typeCon: 	return p->con.val;
		case typeId: 	return sym[p->id.i];
		case typeOper:
		switch(p->opr.oper) 
		{
			case WHILE: 	while(ex(p->opr.op[0])) ex(p->opr.op[1]); return 0;
			case FOR: 	for(ex(p->opr.op[0]);ex(p->opr.op[1]);ex(p->opr.op[2])) ex(p->opr.op[3]); return 0;
			case IF: 		if (ex(p->opr.op[0]))
							ex(p->opr.op[1]);
						else if (p->opr.nops > 2)
							ex(p->opr.op[2]);
						else 
							ex(p->opr.op[3]);
						return 0;
			case WRITE: 	fprintf(yyout,"%d\n", ex(p->opr.op[0])); return 0;
			case ';': 		ex(p->opr.op[0]); return ex(p->opr.op[1]);
			case '=': 		return sym[p->opr.op[0]->id.i] = ex(p->opr.op[1]);
			case UMINUS: 	return -ex(p->opr.op[0]);
			case '+': 		return ex(p->opr.op[0]) + ex(p->opr.op[1]);
			case PE: 		return sym[p->opr.op[0]->id.i] += ex(p->opr.op[1]);
			case '-': 		return ex(p->opr.op[0]) - ex(p->opr.op[1]);
			case MiE: 		return sym[p->opr.op[0]->id.i] -= ex(p->opr.op[1]);
			case '*': 		return ex(p->opr.op[0]) * ex(p->opr.op[1]);
			case ME: 		return sym[p->opr.op[0]->id.i] *= ex(p->opr.op[1]);
			case '/': 		return ex(p->opr.op[0]) / ex(p->opr.op[1]);
			case DE: 		return sym[p->opr.op[0]->id.i] /= ex(p->opr.op[1]);
			case '<': 		return ex(p->opr.op[0]) < ex(p->opr.op[1]);
			case '>': 		return ex(p->opr.op[0]) > ex(p->opr.op[1]);
			case GE: 		return ex(p->opr.op[0]) >= ex(p->opr.op[1]);
			case LE: 		return ex(p->opr.op[0]) <= ex(p->opr.op[1]);
			case NE: 		return ex(p->opr.op[0]) != ex(p->opr.op[1]);
			case EQ: 		return ex(p->opr.op[0]) == ex(p->opr.op[1]);
			case POSTINC:	{
							int aux = sym[p->opr.op[0]->id.i];
							sym[p->opr.op[0]->id.i]++;
							return aux;
						}
			case POSTDEC:	{
							int aux = sym[p->opr.op[0]->id.i];
							sym[p->opr.op[0]->id.i]--;
							return aux;
						}
			case PREINC: 	return ++sym[p->opr.op[0]->id.i];
			case PREDEC: 	return --sym[p->opr.op[0]->id.i];
		}
	}
	return 0;
}