# Assembly-Project

This is a 4 task assembly project.

## Task 1: 

calculates the least common multiple for two given numbers a and b.

C code: 

int cmmmc(int a, int b) {

    int r, x = a, y = b;
    
    while(y != 0) {
    
        if(x > y){
        
            x -= y;
            
        } else y -=x;
        
    }
    
    return a*b/x;
    
}


## Task2: 

checks for balanced brackets in an expression

C code:

int par(int str_lenght, char *str) {

    int decider = 0;
    
    for(int i=0; i < str_lenght; ++i) {
    
        if(str[i] == '(') {
        
            ++decider;
            
        } else {
        
            if(decider == 0) return 0;
            
            --decider;
            
        }
        
    }
    
    if(decider == 0) return 1;
    
    return 0;
    
}

## Task3: 

Takes the 2 arrays v1 and v2 with varying lengths, n1 and n2 and intertwine them. The resulting array is stored in v

C code: 

 void inter(int *v1, int n1, int *v2, int n2, int *v) {
 
    v = (int*) malloc((n1 + n2) * sizeof(int));
    
    int j = 0;
    
    int aux = 0;
    
    if (n1 > n2) aux = n1;
    
    else aux = n2;
    
    for (int i = 0; i < aux; i++) {
    
        if (i >= n1) {
        
            v[j] = v2[i];
            
            j++;
            
        }
        
        else {
        
            if (i >= n2) {
            
                v[j] = v1[i];
                
                j++;
                
            }
            
            else {
            
                v[j] = v1[i];
                
                j++;
                
                v[j] = v2[i];
                
                j++;
                
            }
            
        } 
               
    }
    
}

## Task4: 

Reads the manufacturer id string from cpuid and stores it in id_string

C function header: void cpu_manufact_id(char *id_string);

## The tasks are also explained in Romanian language in the project's README and via comentaries.
