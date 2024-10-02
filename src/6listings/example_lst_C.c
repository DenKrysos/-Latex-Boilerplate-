#include¢\lstCstring{<stdlib.h>}¢
// Some comment
void* ¢\lstfuncdeclplain{some_function}¢(void* args, int argc){// Another comment
	if(¢\lstCvar{var}¢->entry){
		char* some_point = NULL;
		char[] str = "String";
		int ¢\lstCvar{len}¢ = ¢\lstCfunc{make_something}¢($some_point);
		struct timespec ¢\lstCvar{tim}¢;
		¢\lstCvar{tim}¢->tv_nsec=200;
		struct some_struct ¢\lstCvar{struc}¢;
		¢\lstCvar{struc}¢->¢\lstCmember{member}¢=2;
		while(current != ¢\lstCvar{var}¢->iterator){
			//Some Comment
		}
		free(some_point);
	}else{
		switch(¢\lstCfunc{get_type}¢(some_point)){
		case val1:{
			¢\lstCfunc{another_func}¢(input);
			break;
		}
		case val2:{
			//Do something else
			break;
		}
		default:{
			break;
		}
		}//end switch (type)
	}
	return;
}